## Predicting Time Series
This post outlines basic strategies for predicting time-series problems using machine learning.  
  
Although simple, these ideas have been at the core of the model building proccesses for a majority of the top solutions in Kaggle competitions such as [M5 Walmart Sales](kaggle.com) and [Coorpacion Favorita](kaggle.com).

### Problem Type
In a typical  time-series problem, you are given N series consisting of T data points. This data can be represented in a N x (T+1) matrix, with one column reserved for a primary key to identify the nth series.  
  
To make this post easy to write and read, an example problem is provided:  

Suppose we are given 1000 days of historical sales data for 20000 items sold on a large online retail store. We are tasked with predicting sales for each item 7 days into the future. The data is represented in the 20000 x 1008 table below:

<img src="readme_figures/df_1000.png" width=600>

### Training Data

We use portions of historical sales as truth sets and the corresponding previous days as features. In the example below, we use the first 100 days of item sales as the features (grey), and the subsequent 7 days as truth values (purple):  

<img src="readme_figures/df_100.png" width=600>


We can build out many sets like this one in order to increase our total training set size:

<img src="readme_figures/df_155.png" width=600>

<img src="readme_figures/df_993.png" width=600>

When creating the training data, you will encounter several dilemmas including:  

* How much training data should be created? Above, we created 60,000 rows, and have the possibility of creating 19.86M rows (993 * 20,000).
* Should each truth set begin on the same day and match the final test set? For example, if day 1001 is a Monday, should the first day of each truth set also begin on a Monday?
* How can we feature engineer the training set?

Training data in time series is explored further in [this blog post](https://github.com/npa02012/blog_posts/tree/master/ts_training_data).

### Model Building
This post only considers using 'standard' machine learning libraries such as LightGBM, CatBoost, or randomForest. Take note that neural nets provide more flexibility with how time-series can be modeled. [Here](https://github.com/sjvasquez/web-traffic-forecasting) is one such example of using CNNs to model web-traffic data.  



