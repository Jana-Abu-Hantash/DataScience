# Obesity Prediction Model

# Project Overview
This project delves into the utilization of data science methodologies to construct a predictive model aimed at understanding and forecasting obesity trends. Leveraging a dataset encompassing various physical and behavioral characteristics relevant to obesity, the project aims to uncover underlying patterns and insights to predict obesity levels in individuals based on various predictors like physical measurements and lifestyle choices.

## Introduction
The primary objective is to create a model that portrays the complexity of obesity and aids in early intervention and planning of better health approaches. This involves a methodical investigation of the obesity dataset, detailed data preprocessing, exploratory data analysis, feature selection, model building, and validation of the predictive model.

## Problem Statement
The project is centered on predicting obesity levels in individuals based on a wide array of variables, aiming to understand the factors contributing to obesity and develop a predictive model that accurately determines an individual’s obesity level.

## Dataset
The dataset includes individual participants with each row representing unique data. Key variables include age, gender, height, weight, family history of overweight, eating habits, and physical activity. The outcome variable is the obesity level categorized into distinct classes from Insufficient Weight to Obesity Type III.

## Tools and Methodologies
- **R**: Main software for statistical computing and graphics.
- **dplyr and tidyr**: For data manipulation.
- **ggplot2**: For data visualization.
- **caret and randomForest**: For machine learning and predictive modeling.

## Feature Selection and Model Training
Feature selection was performed using visual analysis and Recursive Feature Elimination (RFE). The models were trained using a subset of the data with a focus on Random Forest (RF), K-Nearest Neighbors (KNN), Support Vector Machines (SVM), and Linear Discriminant Analysis (LDA).

## Model Evaluation
The models were compared using accuracy and Kappa statistics, with Random Forest emerging as the chosen model due to its superior predictive accuracy and adaptability.

---

## Application Overview

In addition to the data analysis and predictive modeling, our project includes a Shiny application developed in R to provide an interactive interface for obesity prediction. The application allows users to input their data and receive predictions regarding their obesity levels based on the model we've developed.

## Application Features

- **Interactive Interface**: Users can interact with the application, inputting their data across various physical and lifestyle parameters.
- **Real-Time Prediction**: Leveraging the trained model, the application provides real-time obesity level predictions.
- **Visual Feedback**: The application includes visual elements to enhance user understanding and engagement.

## Running the Application

To run the application locally, you will need to have R and the Shiny package installed. Follow these steps:

1. Ensure that R is installed on your system.
2. Install the Shiny package in R using `install.packages("shiny")`.
3. Additional packages required include `data.table` and `randomForest`. Install these using `install.packages()`.
4. Run the application by setting the working directory to the folder containing the 'app2.R' script and executing `shiny::runApp()`.

## Usage

- Upon running the application, navigate through the input tabs to enter relevant data such as age, height, weight, family history, eating habits, and physical activity.
- After inputting the data, submit it to receive the obesity level prediction based on the predictive model.
- Use the application to understand how different lifestyle and physical aspects come together to affect obesity levels.
