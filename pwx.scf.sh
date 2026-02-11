#!/bin/bash

#SBATCH --partition=amilan
#SBATCH --job-name=Cu_BTTL1.scf	
#SBATCH --account=
#SBATCH --nodes=1			
#SBATCH --ntasks=48
#SBATCH --mem=82GB
#SBATCH --qos=normal
#SBATCH --time=6:05:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

module purge
module load intel/2022.1.2 impi/2021.5.0
module load QE/7.2
WORKDIR=/scratch/alpine/chlu6955/$SLURM_JOBID
mkdir -p "$WORKDIR" && cp $SLURM_JOB_NAME.in "$WORKDIR" && cd "$WORKDIR" || exit -1 
mpirun -np $SLURM_NTASKS pw.x < $SLURM_JOB_NAME.in > $SLURM_JOB_NAME.out
cp $SLURM_JOB_NAME.out $SLURM_SUBMIT_DIR
