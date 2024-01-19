#!/bin/bash

##Job Script for FYP

#SBATCH --partition=SCSEGPU_UG
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --job-name=TestJob
#SBATCH --output=./output/output_%x_%j.out
#SBATCH --error=./error/error_%x_%j.err

module load cuda/12.1
module load anaconda
source activate torch
python3 ./tools/train.py -md rcnn_fpn_baseline
# python3 empty_cache.py