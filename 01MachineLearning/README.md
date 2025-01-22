# Machine Learning

## Software Setup

For machine learning, we will require a basic python environment with a number of specific packages that will be loaded when necessary. Please follow the instructions in this [document](../01_setup.pdf). 

## Basic Course

This material is considered to be a pre-requisite for the ML-PREP project. All lectures are based on my CSU course, held in 2023

- [Web page](https://sites.google.com/view/csu2023/home)
- [GitHub repository](https://github.com/markasch/CSU-IMU-2023)

Please read and understand the following lectures, then attempt to reproduce the examples and exercises.

### Introduction 

**Lectures**
 
1. [Big data](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/01Lectures/00a_bigdata.pdf) 
2. [Statistics for ML](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/01Lectures/00b_learn_stat.pdf)
3. [Cross-validation](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/01Lectures/00_resample.pdf) (this will be reviewed in the Advanced Course)

**Examples and Exercises**

1. Exploratory data analysis on [diabetes clinical data](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/02Examples/EDA_diabetes)
2. EDA dashboard on Penguins data using `plotly` and `quarto` - [notebook](dashboard/db_layout.ipynb), rendered [markdown](dashboard/db_layout/db_layout.md).


### Supervised ML

**Lectures**

*Regression*: 

1. [Linear regression](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/01Lectures/01_super_lr.pdf).
2. [Other regression methods](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/01Lectures/02_super_SelectRegul.pdf).

*Classification*:

3. [k-NN classifier](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/01Lectures/03_super_knn.pdf).
4. [Linear classification methods](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/01Lectures/03_super_class.pdf).
5. [SVM classifier](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/01Lectures/04_super_SVM.pdf).
6. [Decision trees, bagging, boosting and random forests](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/01Lectures/05_super_CART.pdf).
7. [Feed-forward neural networks](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/01Lectures/06_super_NN.pdf). 


**Examples and Exercises**

1. [Linear regression](https://github.com/intro-stat-learning/ISLP_labs/blob/stable/Ch03-linreg-lab.ipynb) from [ISLP](https://www.statlearning.com/resources-python).
2. [Classification](https://github.com/intro-stat-learning/ISLP_labs/blob/stable/Ch04-classification-lab.ipynb) from [ISLP](https://www.statlearning.com/resources-python).
3. [SVM](https://github.com/intro-stat-learning/ISLP_labs/blob/stable/Ch04-classification-lab.ipynb) from [ISLP](https://www.statlearning.com/resources-python).
4. [Bagging and boosting (trees)](https://github.com/intro-stat-learning/ISLP_labs/blob/stable/Ch08-baggboost-lab.ipynb) from [ISLP](https://www.statlearning.com/resources-python).
5. [Neural networks](https://github.com/intro-stat-learning/ISLP_labs/blob/stable/Ch10-deeplearning-lab.ipynb) from [ISLP](https://www.statlearning.com/resources-python).
6. [Numerous examples](https://github.com/markasch/CSU-IMU-2023/tree/main/02advanced-course/02Examples) using PyTorch - see sections: PyTorch, Machine Learning for SciML, Surrogate Modeling (SUMO)
7. Comparison between simple and multiple regression on a database with quantitative and categorical variables, with generation of a surrogate model → [data](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/02Examples/mlreg_concrete/ConcreteStrength.csv), [notebook](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/02Examples/mlreg_concrete/mlreg_concrete.md)
8. [Cross-validation for a random forest classifier](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/02Examples/CV/CV_RF_sklearn.ipynb)

### Unsupervised ML

**Lectures**
 
1. [PCA](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/01Lectures/07_unsup_PCA.pdf).
2. [k-means, hierarchical clustering](https://github.com/intro-stat-learning/ISLP_labs/blob/stable/Ch12-unsup-lab.ipynb).


**Examples and Exercises**

1. [k-means](https://github.com/markasch/CSU-IMU-2023/blob/main/01basic-course/02Examples/k_means/k_means_skl.ipynb)
2. [PCA, k-means, clustering](https://github.com/intro-stat-learning/ISLP_labs/blob/v2/Ch12-unsup-lab.ipynb) from [ISLP](https://www.statlearning.com/resources-python)

---


## Advanced Course

Here we will address a number of practical issues that are important for ML implementation.

- Model choice: which method should I use for my problem?
  - Bias-Variance tradeoff.
  - Interpretability and explainability.
- Model tuning and validation: how can I be sure of the accuracy and robustness of my method?
- Evaluation metrics and predictive power: which metrics measure the predictive power best?
   - Dangers of $R^2$ and $p$-values. 
   - Predicted vs. observed
   - Confidence intervals
- Causality vs Correlation.
  - Shapley values

The material for this part is under construction and will be updated regularly.

### Lecture notes

- Lecture [notes](./02_ML_advanced.pdf) with details and links to training material.


### Examples

- Nested cross-validation [notebook](./Examples/nested_CV.ipynb)
- Finalizing, saving and reusing a cross-validated model [notebook](./Examples/final_model.ipynb)



