#Get Tiles

Introduction
------------
This function is used to split images into 9 tiles. This is good for increasing the number of negatives when training classifiers.

How to Use
----------
Call this function with a path to a directory containing .png files. It creates a folder called ‘neg_tiles’ in your working directory and all new images are saved there. File names are suffixed by their x,y position from the original image, for example a.png would have 9 derivations such as a_11.png or a_32.png.

To Do
-----
Currently this function assumes images are 854 by 480. Ideally these numbers should not be hardcoded but generated based on the images size.
