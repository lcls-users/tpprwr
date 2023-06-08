from mpi4py import MPI

print("testing testing...")

comm = MPI.COMM_WORLD
name=MPI.Get_processor_name()

print(f"name: {name}, my rank is {comm.rank}")
