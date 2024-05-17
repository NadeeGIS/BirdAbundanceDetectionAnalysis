# nmixture model to calcualte bird abaundnace and detectability

# load required packages
library(unmarked)
library(MuMIn)
library(ape)

setwd("/Users/13193/OneDrive - The University of South Dakota/Desktop/Chapter3/NMIXTURE/data")
list.files()

###################################################################################
# Bird species name: BAOR
###################################################################################

# Loading raw abundance of bird species
raw_abundance <- read.csv("detection_history_BAOR.csv",
                          # First variable ("X") has row.names but not data
                          row.names = "X")

# Loading site covariates
site_cov <- read.csv("environment.csv",
                     # First variable ("X") has row.names but not data
                     row.names = "X") 

# Loading observer covariates
effort <- read.csv("effort.csv",
                   #First variable ("X") has row.names but not data 
                   row.names = "X") 

# Build a new unmarked_data_frame

sample.unmarkedFrame_obs <- unmarkedFramePCount( # y is a matrix with observed detection history 
  # (0's and 1's, one row per site, one column per survey)
  y = raw_abundance,
  obsCovs = list(effort = effort),
  # siteCovs = dataframe with site rows x column variables
  siteCovs = site_cov)

# List of site covariates
covariates <- c("c_ndvi",  "year", "X.pd_1_15", "X.pdgt_15","height_cv")

# Function to get all combinations of site covariates - to create all possible models
get_all_combinations <- function(covariates) {
  all_combinations <- list()
  
  for (i in 1:length(covariates)) {
    combinations <- combn(covariates, i, simplify = FALSE)
    all_combinations <- c(all_combinations, combinations)
  }
  
  return(all_combinations)
}

# Get all combinations of site covariates
combinations <- get_all_combinations(covariates)


# Initialize empty vectors to store AICc and AIC values
aiccs <- numeric()
aics<-numeric()


# Loop through each covariate combination and fit the model and calculate AIC/AICc
for (covariates in combinations) {
  formula <- as.formula(paste("~ effort ~", paste(covariates, collapse = "+")))
  fm <- pcount(formula, sample.unmarkedFrame_obs , mixture = "ZIP", K = 500)
  
  # Calculate AICc
  aicc <- AICc(fm)
  aiccs <- c(aiccs, aicc)
  AIC 
  # Calculate AICs
  aic <- AIC(fm)
  aics <- c(aics, aic)
}

# Create a data frame to store results
results <- data.frame(
  Covariates = sapply(combinations, paste, collapse = ", "),
  AICc = aiccs,
  AIC=aics)

# the 'results' data frame contains AIC/AICc  values for each model combination
write.csv(results,"/Users/13193/OneDrive - The University of South Dakota/Desktop/Chapter3/NMIXTURE/AIC/BAOR_ZIP500.csv")



