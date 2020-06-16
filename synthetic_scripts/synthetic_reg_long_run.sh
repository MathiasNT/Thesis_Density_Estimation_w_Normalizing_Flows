#!/bin/sh 
#BSUB -q gpuv100
#BSUB -gpu "num=1:mode=exclusive_process"
#BSUB -J Synthetic
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
OVER_RUN_FOLDER=results/two_moons/long_run2
BASE_RESULTS_FOLDER=$OVER_RUN_FOLDER/long_run_comparison3
DATA_FOLDER=../data/syntetic/
DATA_FILE=rotating_two_moons_100k_n005.csv
CUDA_EXP=true

echo "Createing folders"
mkdir $OVER_RUN_FOLDER
mkdir $BASE_RESULTS_FOLDER
mkdir $BASE_RESULTS_FOLDER/constant
mkdir $BASE_RESULTS_FOLDER/no_reg
mkdir $BASE_RESULTS_FOLDER/dropout

# Flow settings
FLOW_DEPTH=10
C_NET_DEPTH=2
C_NET_H_DIM=18
CONTEXT_N_DEPTH=2
CONTEXT_N_H_DIM=10
RICH_CONTEXT_DIM=5


# Training settings
EPOCHS=1500
BATCH_SIZE=500
CLIPPED_ADAM=10.0
USE_BATCHNORM=True


cd DEwNF


# Experiments

echo "no reg ******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.0
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000 10000 15000 20000 25000 30000 40000 50000; do
	EXPERIMENT_NAME=$NOISE_REG_SCHEDULER$NOISEREG_SIGMA\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/no_reg
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM\
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --use_batchnorm $USE_BATCHNORM
done


echo "constant 02 ******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.2
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000 10000 15000 20000 25000 30000 40000 50000; do
	EXPERIMENT_NAME=$NOISE_REG_SCHEDULER$NOISEREG_SIGMA\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/$NOISE_REG_SCHEDULER
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM\
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --use_batchnorm $USE_BATCHNORM
done

echo "02 dropout context and coupling ******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.0
COUPLING_DROPOUT=0.2
CONTEXT_DROPOUT=0.2
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000 10000 15000 20000 25000 30000 40000 50000; do
	EXPERIMENT_NAME=dropout_coupling$COUPLING_DROPOUT\_context$CONTEXT_DROPOUT\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/dropout
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA --context_dropout $CONTEXT_DROPOUT --coupling_dropout $COUPLING_DROPOUT\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM\
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --use_batchnorm $USE_BATCHNORM
done



