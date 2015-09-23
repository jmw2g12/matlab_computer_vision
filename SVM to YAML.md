#SVM to YAML

Introduction
------------
This function is used to create YAML files from ClassificationSVM objects created by the fitcsvm function in Matlab. It only uses beta, bias and scale values. This format will be accepted by programs in the mosaic_vision package.

How to Use
----------
Call this function giving the classifier object and a name for the file to be saved as. This puts the classifier’s values YAML format and saves the resultant file in your working directory.
