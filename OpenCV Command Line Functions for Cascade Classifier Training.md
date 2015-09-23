#OpenCV Command Line Functions for Cascade Classifier Training

Generating Samples
------------------
Once all your positive and negative images have been created, make a new cascade training directory and put the positives and negatives within two folders. You will need two info files, one for positive and one for negative. The negative one simply lists the negative images, use this command (replacing values within the <> symbols):

ls <neg_folder_name> | sed ’s/^/<neg_folder_name>\//g’ > negs.info

For the positive info file, you need to append the filename with object coordinates. If the positive images contain only the object then use this command, ensuring you preserve the spaces when substituting your values in:

ls <pos_folder_name> | sed ’s/^/<pos_folder_name>\//g’ | sed ’s/$/ 1 0 0 <img_width> <img_height>/g’ > pos.info

Make another directory where the classifier files will be stored. Now you’re ready to call opencv_createsamples. Here is a breakdown of the arguments:

-vec: This specifies a filename for your resultant .vec file which stores the samples in a format used by OpenCV’s train cascade function.
-info: This is where you give it the .info file created above.
-num: The number of samples you want created. I usually give it an arbitrarily large number as it finishes cleanly if it runs out of images.
-w: This is the width of the samples you require.
-h: This is the height of the samples you require.

If you find that instead of generating samples, a window appears showing you samples then it’s likely that the -vec argument specifies a .vec file already created and the command perceives this as a wish to view it rather than overwrite it.

Training the Cascade
--------------------
