#!/bin/bash
#SBATCH --partition=amilan
#SBATCH --account=
#SBATCH --job-name=BTTL1.pdos	
#SBATCH --nodes=1			
#SBATCH --ntasks=6
#SBATCH --mem=128GB
#SBATCH --qos=normal
#SBATCH --time=03:00:00
#SBATCH --mail-type=all
#SBATCH --mail-user=

module purge
module load intel/2022.1.2 impi/2021.5.0
module load QE/7.2
WORKDIR=/scratch/alpine/chlu6955/$SLURM_JOBID
mkdir -p "$WORKDIR" && cp $SLURM_JOB_NAME.in "$WORKDIR" && cd "$WORKDIR" || exit -1 
mpirun -np $SLURM_NTASKS projwfc.x < $SLURM_JOB_NAME.in > $SLURM_JOB_NAME.out
sumpdos.x *\(C\)* > $SLURM_JOB_NAME.C.dat
sumpdos.x *\(O\)* > $SLURM_JOB_NAME.O.dat
sumpdos.x *\(H\)* > $SLURM_JOB_NAME.H.dat
sumpdos.x *\(Zn\)* > $SLURM_JOB_NAME.Zn.dat
sumpdos.x *\(S\)* > $SLURM_JOB_NAME.S.dat
cp $SLURM_JOB_NAME.out $SLURM_JOB_NAME.C.dat $SLURM_JOB_NAME.O.dat $SLURM_JOB_NAME.H.dat $SLURM_JOB_NAME.Zn.dat $SLURM_JOB_NAME.S.dat $SLURM_SUBMIT_DIR
