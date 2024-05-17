# BirdAbundanceDetectionAnalysis
This repository provides a robust tool for analyzing bird abundance and detectability using site and observer covariates, offering valuable insights for ornithologists, ecologists, and wildlife researchers.

# The Logic

This R script aims to model bird abundance and detectability using an N-mixture model.
The script loads unmarked, MuMIn, and ape. libraries.

## Input Data

1. detection_history_BAOR.csv
2. environment.csv
3. effort.csv

It constructs an unmarked data frame (sample.unmarkedFrame_obs) using the unmarked package, incorporating the observed detection history (raw_abundance), observer covariates (effort), and site covariates (site_cov).

## Model Construction

  The script defines a list of site covariates (covariates) to be considered in the model.
  It defines a function (get_all_combinations) to generate all possible combinations of site covariates.
  It generates all possible combinations of site covariates using the defined function.
  It iterates over each covariate combination and fits an N-mixture model using the pcount function from the unmarked package.
  For each model, it calculates the AICc and AIC values using the AICc and AIC functions from the MuMIn package, respectively.
  It stores the covariate combination and corresponding AICc and AIC values in a data frame (results).

## Output
The script writes the results (covariate combinations, AICc, and AIC values) to a CSV file named BAOR_ZIP500.csv
