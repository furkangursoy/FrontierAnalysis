# FrontierAnalysis
Sample frontier analysis code and a dummy dataset. The purpose is to learn target value from the best observations rather than average (i.e., all) observations.

StochasticFrontierAnalysis.R contains code for importing data, building various simple Stochastic Frontier Analysis models, testing them, and visualizing its results along with the actual values and a fitted OLS line. The code contains somehow sufficient comments for explaining what each part do.

The dataset (sampledata.csv) is generated in a way that output (y) variables have a linear relationship to input (x) variables. However, the coefficients change from observation to observation within a speficied range. See sampledataGenerator.xlsx file for details on how the dataset is generated. The aim is to create a nonperfect overall linear relationship where deviations are due to the changes in coefficients (i.e., an analogy to efficiency of different firms) rather than random error. 

