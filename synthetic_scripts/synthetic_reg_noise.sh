#!/bin/sh 
#BSUB -J Reg_test_bn
#BSUB -q gpuv100
#BSUB -gpu "num=1:mode=exclusive_process"

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
OVER_RUN_FOLDER=results/two_moons/reg_run_noise_comp
BASE_RESULTS_FOLDER=$OVER_RUN_FOLDER/run3
DATA_FOLDER=../data/syntetic/
DATA_FILE=rotating_two_moons_100k_n005.csv
CUDA_EXP=true

echo "Createing folders"
mkdir $OVER_RUN_FOLDER
mkdir $BASE_RESULTS_FOLDER
mkdir $BASE_RESULTS_FOLDER/no_reg
mkdir $BASE_RESULTS_FOLDER/l2
mkdir $BASE_RESULTS_FOLDER/n02
mkdir $BASE_RESULTS_FOLDER/n01
mkdir $BASE_RESULTS_FOLDER/n005
mkdir $BASE_RESULTS_FOLDER/n005
mkdir $BASE_RESULTS_FOLDER/n0005

# Flow settings
FLOW_DEPTH=10
C_NET_DEPTH=2	
C_NET_H_DIM=18
CONTEXT_N_DEPTH=2
CONTEXT_N_H_DIM=10
RICH_CONTEXT_DIM=5


# Training settings
EPOCHS=1500
CLIPPED_ADAM=10.0
BATCHNORM_MOMENTUM=0.1
BATCH_SIZE=500



cd DEwNF

# Experiments
echo "no noise regularization ******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=no_reg_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/no_reg
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM\
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --batchnorm_momentum $BATCHNORM_MOMENTUM
done

echo "L2 Reg ******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.0
L2_REG=0.0001
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=L2_reg$L2_REG\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/l2
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA --l2_reg $L2_REG\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM\
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --batchnorm_momentum $BATCHNORM_MOMENTUM
done


echo "constant02 noise regularization ******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.2
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=$NOISE_REG_SCHEDULER$NOISEREG_SIGMA\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/n02
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM\
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --batchnorm_momentum $BATCHNORM_MOMENTUM
done
				    
echo "constant01 noise regularization ******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.1
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=$NOISE_REG_SCHEDULER$NOISEREG_SIGMA\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/n01
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM\
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --batchnorm_momentum $BATCHNORM_MOMENTUM
done

echo "constant005 noise regularization ******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.05
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=$NOISE_REG_SCHEDULER$NOISEREG_SIGMA\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/n005
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM\
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --batchnorm_momentum $BATCHNORM_MOMENTUM
done

echo "constant005 noise regularization ******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.005
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=$NOISE_REG_SCHEDULER$NOISEREG_SIGMA\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/n0005
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM\
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --batchnorm_momentum $BATCHNORM_MOMENTUM
done



echo "constant0005 noise regularization ******************************************"
NOISE_REG_SCHEDULER=constant
NOISE_REG_SIGMA=0.0005
for DATA_SIZE in 100 200 300 400 500 600 700 800 900 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 5000 6000 7000 8000 9000; do
	EXPERIMENT_NAME=$NOISE_REG_SCHEDULER$NOISEREG_SIGMA\_$DATA_SIZE
	RESULTS_FOLDER=$BASE_RESULTS_FOLDER/n0005
	echo "size $DATA_SIZE"
	python3 synthetic_script.py --experiment_name $EXPERIMENT_NAME --results_folder $RESULTS_FOLDER --data_folder $DATA_FOLDER --data_file $DATA_FILE --cuda_exp $CUDA_EXP\
        	                    --data_size $DATA_SIZE \
                	            --noise_reg_scheduler $NOISE_REG_SCHEDULER --noise_reg_sigma $NOISE_REG_SIGMA\
                	            --epochs $EPOCHS --batch_size $BATCH_SIZE --clipped_adam $CLIPPED_ADAM\
                       		    --flow_depth $FLOW_DEPTH --c_net_depth $C_NET_DEPTH --c_net_h_dim $C_NET_H_DIM --context_n_depth $CONTEXT_N_DEPTH --context_n_h_dim $CONTEXT_N_H_DIM --rich_context_dim $RICH_CONTEXT_DIM --batchnorm_momentum $BATCHNORM_MOMENTUM
done









