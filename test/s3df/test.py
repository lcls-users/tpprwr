from mpi4py import MPI

def main():
    print("testing testing...")
    comm = MPI.COMM_WORLD
    name=MPI.Get_processor_name()
    print(f"name: {name}, my rank is {comm.rank}")

if __name__ == '__main__':
    main()
