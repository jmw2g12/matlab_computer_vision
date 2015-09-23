#Train and Test HOG SVM

Introduction
------------
There are two flavours to this program, one uses Matlab’s extractHOGFeatures function whereas the other uses OpenCV’s compute function via the Mex-function wrapper, OpenCV_extractHOGFeatures. Both functions do similar things but the data they return will vary.

For both functions the sets are split into two, one half as the training set and the other as the testing set. If you want all the images to be used for training then simply using Matlab’s fitcsvm function would be a better solution.

Using the Training Function
---------------------------
This function takes as arguments two directories containing just .png files, the first of which will be the positives and the second, the negatives. The positives should be of just the object and the images in both directories should be the same size.

About the Classifier
--------------------
From the classifier object returned from this function, the important fields are the ‘beta’ and the ‘bias’. The beta is a vector of linear predictor coefficients and the bias specifies the distance a score can be from the hyperplane in order to be classified.

Using the OpenCV Trained Classifier
-----------------------------------
First a HOGDescriptor object must be created using the window, block and cell size, block stride and number of ‘bins’ or orientations used by the training function. Currently the values are as follows:

Window size: 57,96

Block size: 3,3

Block stride: 3,3

Cell size: 3,3

Number of bins: 9

Next, the bias and beta values have to be inserted in, add the bias value to the end of the beta vector then use the setSVMDetector member function with the beta/bias vector as the argument. To run the classifier over an image, call detectMultiScale. 

Using the Matlab Trained Classifier
-----------------------------------
To run the classifier over an image, first obtain the HOG features using extractHOGFeatures function. Secondly, use the predict function giving the classifier model and the HoG features as arguments. It will return the predicted class with 1 being a positive and 0 being a negative. You can give this function multiple images at once by giving multiple rows of features. The output will be an equal number of rows of classification values, each corresponding with the same row from the input.
