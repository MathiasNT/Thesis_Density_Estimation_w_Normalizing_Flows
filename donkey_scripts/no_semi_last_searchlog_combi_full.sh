#!/bin/sh 
#BSUB -J no_semi_combi
#BSUB -q gpuv100
#BSUB -gpu "num=1:mode=exclusive_process"
#BSUB -n 1
#BSUB -W 24:00 

#BSUB -R "span[hosts=1]"
#BSUB -R "rusage[mem=60GB]"
#BSUB -R "select[gpu32gb]"

#BSUB -N 
#BSUB -o logs/%J_Output_combi.out 
#BSUB -e logs/%J_Error_combi.err


# Experiment settings
OVER_RUN_FOLDER=results/coordinatesearchlog/last_no_semi_24
RESULTS_FOLDER="$OVER_RUN_FOLDER/run1"
DATA_FOLDER=../data/created_data_sets
DATA_FILE=CoordinateSearchlog_simple.csv
EXTRA_DATA_FILE=UnsupervisedCoordinateSearchlog.csv
CUDA_EXP=true

echo "Creating folders"
mkdir "$OVER_RUN_FOLDER"
mkdir "$RESULTS_FOLDER"


# Data headers
OBS_COLS="user_location_latitude user_location_longitude"
SEMISUP_CONTEXT_COLS="hour_sin hour_cos"
SUP_CONTEXT_COLS="rain"

# Regularization settings
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.02

# Training settings
EPOCHS=1500
BATCH_SIZE=50000
CLIPPED_ADAM=10.0
INITIAL_LR=0.0001
LR_FACTOR=0.1
LR_PATIENCE=200
MIN_LR=0.000001


# Flow settings
BATCHNORM_MOMENTUM=0.1
FLOW_DEPTH=24
C_NET_DEPTH=5
C_NET_H_DIM=24
CONTEXT_N_DEPTH=5
CONTEXT_N_H_DIM=24
RICH_CONTEXT_DIM=6


echo "Starting:"
cd DEwNF

EXPERIMENT_NAME=combi
echo $EXPERIMENT_NAME
python3 semisup_no_semi_searchlog_script_combi.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --extra_data_file $EXTRA_DATA_FILE --cuda_exp $CUDA_EXP\
                       --obs_cols $OBS_COLS --semisup_context_cols $SEMISUP_CONTEXT_COLS --sup_context_cols $SUP_CONTEXT_COLS\
                       --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA\
                       --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM --initial_lr $INITIAL_LR --lr_factor $LR_FACTOR --lr_patience $LR_PATIENCE --min_lr $MIN_LR\
                       --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --batchnorm_momentum $BATCHNORM_MOMENTUM
