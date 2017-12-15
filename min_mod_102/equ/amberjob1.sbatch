#!/bin/bash

#SBATCH --job-name=Amber
#SBATCH --nodes=3
#SBATCH --tasks-per-node=28
#SBATCH --time=24:00:00
#SBATCH --mem=100GB
#SBATCH --mail-type=END
#SBATCH --mail-user=kfd233@nyu.edu

#Comments start here, above are not comments and should be in your script 
# go to your working directory: /scratch/YOURnetID/hw4/equ.
cd /scratch/kfd233/final_project/CompChemFinal/min_mod_102/equ

# load module to run amber

module purge
module load amber/openmpi/intel/16.06 

# run heating job
mpiexec pmemd.MPI -O -i heat.in -o heat.out -p 5j0d_mod_sol.prmtop -c min_all.rst -r heat.rst -x heat.mdcrd -ref min_all.rst

# run density job
mpiexec pmemd.MPI -O -i density.in -o density.out -p 5j0d_mod_sol.prmtop -c heat.rst -r density.rst -x density.mdcrd -ref min_all.rst

# run equil job
mpiexec pmemd.MPI -O -i equil.in -o equil.out -p 5j0d_mod_sol.prmtop -c density.rst -r equil.rst -x equil.mdcrd -ref min_all.rst

mkdir md 
cd md


mpiexec pmemd.MPI -O -i ../prod_npt.in -o prod1.out -p ../5j0d_mod_sol.prmtop -c ../equil.rst -r prod1.rst -x prod1.mdcrd

mpiexec pmemd.MPI -O -i ../prod_npt.in -o prod2.out -p ../5j0d_mod_sol.prmtop -c prod1.rst -r prod2.rst -x prod2.mdcrd
