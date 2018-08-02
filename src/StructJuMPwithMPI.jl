module StructJuMPwithMPI

using StructJuMP
using MPI

export mpi_wrapper

type MPIWrapper
    comm::MPI.Comm
    init::Function

    function MPIWrapper()
        instance = new(MPI.Comm(-1))
        finalizer(instance, freeMPIWrapper)

        instance.init = function(ucomm::MPI.Comm)
            if MPI.Initialized() && ucomm.val == -1
                instance.comm = MPI.COMM_WORLD
            elseif !MPI.Initialized()
                MPI.Init()
                instance.comm = MPI.COMM_WORLD
            elseif MPI.Initialized() && ucomm.val != -1
                instance.comm = ucomm
            elseif MPI.Finalized()
                error("MPI is already finalized!")
            else
                #doing nothing
            end
        end
        return instance
    end
end
function freeMPIWrapper(instance::MPIWrapper)
    if isdefined(:MPI) && MPI.Initialized() && !MPI.Finalized()
        MPI.Finalize()
    end
end

const mpi_wrapper = MPIWrapper()

function getMyRank()
    myrank = 0
    mysize = 1
    if isdefined(:MPI) && MPI.Initialized() && !MPI.Finalized()
        comm = MPI.COMM_WORLD
        mysize = MPI.Comm_size(comm)
        myrank = MPI.Comm_rank(comm)
    end
    return myrank, mysize
end

function StructJuMP.getProcIdxSet(mpi_wrapper::MPIWrapper, numScens::Integer)
    mysize = 1;
    myrank = 0;
    if isdefined(:MPI) == true && MPI.Initialized() == true
        comm = MPI.COMM_WORLD
        mysize = MPI.Comm_size(comm)
        myrank = MPI.Comm_rank(comm)
    end
    # Why don't we just take a round-and-robin?
    proc_idx_set = Int[];
    for s = myrank:mysize:(numScens-1)
        push!(proc_idx_set, s+1);
    end
    return proc_idx_set;
end

end # module
