
library(rtmpt)

# SOLUTIONS TO THE EXERCISES #

## 1 ##
### EQN ###
EQN_file <- "./ITE_EQN"


## 2 ##
### MDL ###
MDL_file <- "./ITE_MDL"


## 3 ##
ITE_ertmpt_model <- to_ertmpt_model(mdl_file = MDL_file)
ITE_ertmpt_model_labeled <- to_ertmpt_model(eqn_file = EQN_file)

ITE_drtmpt_model <- to_drtmpt_model(mdl_file = MDL_file)
ITE_drtmpt_model_labeled <- to_drtmpt_model(eqn_file = EQN_file)


## 4.1 ##
test_model <- theta2const(model = ITE_ertmpt_model, names = "g", constants = 0.5)
test_model <- tau2zero(model = test_model, names = c("Fn", "Fr"), outcomes = c("plus", "plus"), values = 0)


## 4.2 ##
test_model <- w2const(model = ITE_drtmpt_model, names = c("Ku", "Kk"), constants = 0.5)
test_model <- v2v(model = test_model, names = c("Fn", "Fr"), keep_consts = FALSE)


## 5 ##
### exponential ###
ITE_ertmpt_model <- delta2delta(model = ITE_ertmpt_model, trees = 0:7, categories = seq(1, 15, by = 2), mappings = 1)
ITE_ertmpt_model_labeled <- delta2delta(ITE_ertmpt_model_labeled, c("UNF", "UNT", "URF", "URT", "KNF", "KNT", "KRF", "KRT"),
                                        rep("true", 8), 1) 

### diffusion ###
ITE_drtmpt_model <- delta2delta(model = ITE_drtmpt_model, trees = 0:7, categories = seq(1, 15, by = 2), mappings = 1)
ITE_drtmpt_model_labeled <- delta2delta(ITE_drtmpt_model_labeled, c("UNF", "UNT", "URF", "URT", "KNF", "KNT", "KRF", "KRT"),
                                        rep("true", 8), 1) 


## 6 ##
### exponential ###
e_data <- to_ertmpt_data(raw_data = "./ITE_labeled.txt", model = ITE_ertmpt_model_labeled)

### diffusion ###
d_data <- to_drtmpt_data(raw_data = "./ITE_labeled.txt", model = ITE_drtmpt_model_labeled)


## 7 ##
e_fit <- fit_ertmpt(model = ITE_ertmpt_model_labeled, data = e_data)
### or load: ###
load("e_fit.RData")

summary(e_fit)
