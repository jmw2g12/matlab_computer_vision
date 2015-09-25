#OpenCV Command Line Functions for Cascade Classifier Training

Generating Samples
------------------
Once all your positive and negative images have been created, make a new cascade training directory and put the positives and negatives within two folders. You will need two info files, one for positive and one for negative. The negative one simply lists the negative images, use this command (replacing values within the <> symbols):

ls <neg_folder_name> | sed ’s/^/<neg_folder_name>\//g’ > negs.info

For the positive info file, you need to append the filename with object coordinates. If the positive images contain only the object then use this command, ensuring you preserve the spaces when substituting your values in:

ls <pos_folder_name> | sed ’s/^/<pos_folder_name>\//g’ | sed ’s/$/ 1 0 0 <img_width> <img_height>/g’ > pos.info

Make another directory where the classifier files will be stored. Now you’re ready to call **opencv_createsamples**. Here is a breakdown of the arguments:

**-vec**: This specifies a filename for your resultant .vec file which stores the samples in a format used by OpenCV’s train cascade function.

**-info**: This is where you give it the .info file created above.

**-num**: The number of samples you want created. I usually give it an arbitrarily large number as it finishes cleanly if it runs out of images.

**-w**: This is the width of the samples you require.

**-h**: This is the height of the samples you require.

If you find that instead of generating samples, a window appears showing you samples then it’s likely that the -vec argument specifies a .vec file already created and the command perceives this as a wish to view it rather than overwrite it. If you wish to view the samples then call opencv_createsamples specifying only -vec, -w and -h arguments.

Training the Cascade
--------------------
The next step is running the training function, **opencv_traincascade**. Remember that the values you choose for the number of stages and false positive levels should reflect the size of your sample set.
Here are a breakdown of the arguments:

**-data**: The empty directory where your classifier will be stored.

**-vec**: The .vec file created in the previous step.

**-numPos**: The number of positive samples you wish to use at each stage of the training. A higher number is better for accuracy although it will mean the training takes longer.

**-numNeg**: The number of negative samples you wish to use at each stage of the training.

**-numStages**: The number of stages the cascade runs each section of the image through. Each stage is a tree of haar-features with the leaf nodes containing a probability that if a picture matches these features then they should be classed as positive.

**-precalcValBufSize**: The buffer size for calculated features.

**-precalcIdxBufSize**: The buffer size for calculated features' index. The more you give this the faster the training should perform although if you try give it too much it will fail all together! I usually gave 1024 or 2048.

**-w**: The width of the samples created in the previous stage.

**-h**: The height of the samples created in the previous stage.

**-minHitRate**: The intended minimum hit rate for each stage of the cascade, 0.95-0.999 is expected.

**-maxFalseAlarmRate**: The intended maximum false positive rate for each stage of the cascade, 0.5 is regularly used. For both this parameter and the previous you can *estimate* the total rate by taking these values to the power of the number of stages.

**-maxDepth**: The maximum depth of weak trees, choosing 1 is standard.

**-maxWeakCount**: The maximum number of weak trees allowed at each stage.

The trained cascade will be stored in the output folder as an xml file. Each individual stage is also stored here so you can incrementally build stages if you have time constraints or you can revert to less stages if the classifier takes too long to run. To do this, run the same command as you did to build it but with a different number of stages and instead of running the training again, the stages will be loaded from file. Conversely, when creating multiple classifiers at once, be careful you don't specify an output folder with data already in it as it will use this data and try build on it instead of running the whole command.
