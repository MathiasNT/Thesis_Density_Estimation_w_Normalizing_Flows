#!/bin/sh 
#BSUB -J NYC_taxi_uncond
#BSUB -q gpuv100
#BSUB -gpu "num=1:mode=exclusive_process"
#BSUB -n 1
#BSUB -W 24:00 

#BSUB -R "span[hosts=1]"
#BSUB -R "rusage[mem=40GB]"
#BSUB -R "select[gpu32gb]"

#BSUB -N 
#BSUB -o logs/%J_Output.out 
#BSUB -e logs/%J_Error.err

echo "Starting:"

# Experiment settings
OVER_RUN_FOLDER=results/nyc_taxi/rothfuss_comp
RESULTS_FOLDER="$OVER_RUN_FOLDER/affine"
DATA_FOLDER=../data/nyc_taxi
DATA_FILE=processed_nyc_taxi_small.csv
CUDA_EXP=true

echo "Creating folders"
mkdir "$OVER_RUN_FOLDER"
mkdir "$RESULTS_FOLDER"


# Data headers
OBS_COLS="dropoff_longitude dropoff_latitude"
CONTEXT_COLS="pickup_longitude pickup_latitude pickup_dow_sin pickup_dow_cos pickup_tod_sin pickup_tod_cos"

# Regularization settings
NOISE_REG_SCHEDULER=constant

# Training settings
EPOCHS=1500
BATCH_SIZE=50000

CLIPPED_ADAM=10.0

# Flow settings
BATCHNORM_MOMENTUM=0.1
FLOW_DEPTH=11
C_NET_DEPTH=2
C_NET_H_DIM=32
CONTEXT_N_DEPTH=2
CONTEXT_N_H_DIM=32
RICH_CONTEXT_DIM=4
		
echo "Starting:"
cd DEwNF

EXPERIMENT_NAME=nyc_model_same_size
NOISE_REG_SIGMA=0.08
echo $EXPERIMENT_NAME
python3 conditional_simple_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
                       --obs_cols $OBS_COLS --context_cols $CONTEXT_COLS\
                       --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA\
                       --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM\
                       --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --batchnorm_momentum $BATCHNORM_MOMENTUM


