#!/bin/bash

#SBATCH --job-name=Amber
#SBATCH --nodes=3
#SBATCH --tasks-per-node=28
#SBATCH --time=24:00:00
#SBATCH --mem=100GB

cd /scratch/kfd233/final_project/CompChemFinal/prep/md  

module purge
module load amber/openmpi/intel/16.06 

mpiexec pmemd.MPI -O -i prod_npt.in -o prod1.out -p 100_1_5j0d_singleFile.prmtop -c equil.rst -r prod1.rst -x prod1.mdcrd

mpiexec pmemd.MPI -O -i prod_npt.in -o prod2.out -p 100_1_5j0d_singleFile.prmtop -c prod1.rst -r prod2.rst -x prod2.mdcrd
