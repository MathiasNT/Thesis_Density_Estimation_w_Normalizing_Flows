# Thesis_Density_Estimation_w_Normalizing_Flows
In this repo is the code for my Master thesis.

All of the code for the normalizing flows is written in the Python module DEwNF.
The Normalizing flows have been trained in two ways:
- Using a compute cluster via bash and python scripts
- Using google colab using colab notebooks
All of the bash and python scripts should be usable for anyone with a cuda enabled GPU. Note that the DEwNF module needs to be in the same folder as the bash scripts.
All of the colab notebooks are usable if the user sets up a folder with the DEwNF module and a folder with the necessary data. The paths in the colab notebooks might need updated root paths but if the entire google_collab folder is uploaded all internal paths should match. To use the colab folder normalizingflows(colab files) the parenthesis needs to be removed.

All data preparation notebooks needs to have paths updated to match users system. The used paths are created to work for a linux system.

## Data
### Donkey data generation
Cleaning of climate station data - Donkey_data/Climate_station_data/DTU_weather_notebook.ipynb
Cleaning of Donkey Republic searchlogs - Donkey_data/Donkey_raw_data/analysis_of_searchlogs.ipynb
Generation of data - Donkey_data/Coordinate_Searchlog_simple.ipynb
Data sets - Donkey_data/Coordinate_Searchlog_simple.csv and Donkey_data/UnsupervisedCoordinateSearchlog.csv

### Two Moons data set:
Code for generating data - DEwNF/DEwNF/samplers/rotatingtwomoons.py
Generated data sets - Two_moon_data

### NYC data:
Datasets - normalizingflows(colab files)/datasets/NYC_yellow_taxi
Preprocessing - normalizingflows(colab files)/datasets/preprocess_nyc_taxi.ipynb

## Training
### Regularization experiments
Done via bash scripts see synthetic_scripts
Visualization via google colab - normalizingflows(colab files)/results/two_moons

### Two moon visualizations
Done via google colab
AC on one half-moon - normalizingflows(colab files)/plot_notebooks/Two_moons_plot_and_AC_per_layer.ipynb
Both half-moons - normalizingflows(colab files)/plot_notebooks/TYPE_both_moons_w_plots.ipynb

### NYC Experiments
Done via bash scrips see NYC_scripts
Visualization via google colab - normalizingflows(colab files)/results/nyc_taxi

### Donkey republic results
Done via bash scripts see donkey_scripts
Visualization via google colab - normalizingflows(colab files)/results/donkey_republic/last_results
