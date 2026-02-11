#!/bin/bash

#SBATCH --partition=amilan 
#SBATCH --job-name=Cu_BTTL1.opt 
#SBATCH --account=ucb445_asc3  
#SBATCH --nodes=1			
#SBATCH --ntasks=48
#SBATCH --mem=82GB
#SBATCH --signal=B:USR1@30
#SBATCH --qos=normal
#SBATCH --time=0:02:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user= 

module purge
module load intel/2022.1.2 impi/2021.5.0
module load QE/7.2
WORKDIR=/scratch/alpine/chlu6955/$SLURM_JOBID
mkdir -p "$WORKDIR" && cp $SLURM_JOB_NAME.in "$WORKDIR" && cd "$WORKDIR" || exit -1 

trigger_timeout () {
	echo "copied before timeout"
	cp $SLURM_JOB_NAME.out $SLURM_SUBMIT_DIR
}
trap 'trigger_timeout' USR1
mpirun -np $SLURM_NTASKS pw.x < $SLURM_JOB_NAME.in > $SLURM_JOB_NAME.out & wait
cp $SLURM_JOB_NAME.out $SLURM_SUBMIT_DIR
