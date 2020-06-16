#!/bin/sh 
#BSUB -q gpuv100
#BSUB -gpu "num=1:mode=exclusive_process"
#BSUB -J Synthetic
#BSUB -n 1
#BSUB -W 12:00 

#BSUB -R "span[hosts=1]"
#BSUB -R "rusage[mem=40GB]"
#BSUB -R "select[gpu32gb]"

#BSUB -N 
#BSUB -o logs/%J_Output.out 
#BSUB -e logs/%J_Error.err 

echo "Starting:"
# Experiment settings
BASE_RESULTS_FOLDER=results/two_moons/reg_comparisons_l2
DATA_FOLDER=../data/syntetic/
DATA_FILE=rotating_two_moons_100k_n005.csv
CUDA_EXP=true

echo "Createing folders"
mkdir $BASE_RESULTS_FOLDER
mkdir $BASE_RESULTS_FOLDER/e5
mkdir $BASE_RESULTS_FOLDER/e4
mkdir $BASE_RESULTS_FOLDER/e3
mkdir $BASE_RESULTS_FOLDER/e2
mkdir $BASE_RESULTS_FOLDER/e1





cd DEwNF


# Training settings
EPOCHS=2
BATCH_SIZE=500

# Flow settings
FLOW_DEPTH=10
C_NET_DEPTH=2
C_NET_H_DIM=18
CONTEXT_N_DEPTH=2
CONTEXT_N_H_DIM=10
RICH_CONTEXT_DIM=5



# Experiments
echo "L2 Reg  0.00001******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.0
L2_REG=0.00001
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=L2_reg$L2_REG\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/e5
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA --l2_reg $L2_REG\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE \
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM
done

echo "L2 Reg  0.0001******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.0
L2_REG=0.0001
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=L2_reg$L2_REG\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/e4
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA --l2_reg $L2_REG\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE \
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM
done

echo "L2 Reg  0.001******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.0
L2_REG=0.001
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=L2_reg$L2_REG\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/e3
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA --l2_reg $L2_REG\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE \
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM
done

echo "L2 Reg  0.01******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.0
L2_REG=0.01
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=L2_reg$L2_REG\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/e2
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA --l2_reg $L2_REG\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE \
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM
done

echo "L2 Reg  0.1******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.0
L2_REG=0.1
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=L2_reg$L2_REG\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/e1
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA --l2_reg $L2_REG\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE \
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM
done
