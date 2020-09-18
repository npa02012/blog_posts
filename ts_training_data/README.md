## Time Series Training Data

When I am creating these models, I identify each set of data with a FIRST\_PRED\_DAY tag, i.e. the training data consisting of the first 100 days of data is identified with FIRST\_PRED\_DAY = 101.  
  
Here are two things to consider as you are creating this data:

* How much training data should I create? In this example problem, we could potentially make over 19.86M rows of training data (993 * 20000). In the Walmart Sales competition, pushing the training data towards the maximum possible size improved the validation score in my model and on several public kernels. On the otherhand, this technique worsened my validation score in the Coorporacion Favorita competition. The worse results may have been due to a lack of model hyperparameter tuning or over-fitting as the in-training validation set was too similar to the training set. In either case, I recommend trying both ends of the training-size spectrum.  
* Consider keeping the FIRST\_PRED\_DAY's of the training set as the same weekday as the final test FIRST\_PRED\_DAY. In this example, the final test set has a FIRST\_PRED\_DAY of 1001. Let's say this falls on a Monday. If we want our training sets to have a FIRST\_PRED\_DAY that also falls on a Monday, we will have to use values such as 994, 987, 980, and so forth. Clearly, this method captures weekly seasonality and is worth investigating - especially if memory/system constraits limit potential training size.  