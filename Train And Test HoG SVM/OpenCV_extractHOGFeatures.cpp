//////////////////////////////////////////////////////////////////////////
// Creates C++ MEX-file for OpenCV routine matchTemplate. 
// Here matchTemplate uses normalized cross correlation method to search 
// for matches between an image patch and an input image.
//
// Copyright 2014 The MathWorks, Inc.
//////////////////////////////////////////////////////////////////////////

#include "opencvmex.hpp"
#include <opencv2/opencv.hpp>

#define _DO_NOT_EXPORT
#if defined(_DO_NOT_EXPORT)
#define DllExport  
#else
#define DllExport __declspec(dllexport)
#endif

///////////////////////////////////////////////////////////////////////////
// Allows you to output vectors while using mex
///////////////////////////////////////////////////////////////////////////
mxArray * getMexArray(const std::vector<float>& v)
{
    mxArray * mx = mxCreateDoubleMatrix(1,v.size(), mxREAL);
    std::copy(v.begin(), v.end(), mxGetPr(mx));
    return mx;
}

///////////////////////////////////////////////////////////////////////////
// Check inputs
///////////////////////////////////////////////////////////////////////////
void checkInputs(int nrhs, const mxArray *prhs[])
{    
    // Check number of inputs
    if (nrhs != 1)
    {
        mexErrMsgTxt("Incorrect number of inputs. Function expects 1 input.");
    }
    
}

///////////////////////////////////////////////////////////////////////////
// Main entry point to a MEX function
///////////////////////////////////////////////////////////////////////////
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{  
	// Check inputs to mex function
    checkInputs(nrhs, prhs);
    
    int num_bins = 9;
    cv::Size win_size(57,96);
    cv::Size cell_size(3,3);
    cv::Size block_size(3,3);
    cv::Size block_stride(3,3);
    
    cv::HOGDescriptor hog(win_size,block_size,block_stride,cell_size,num_bins,1,-1,cv::HOGDescriptor::L2Hys,0.2,true,cv::HOGDescriptor::DEFAULT_NLEVELS);
    
    cv::Ptr<cv::Mat> img = ocvMxArrayToImage_uint8(prhs[0],true);
    cv::resize(*img,*img,cv::Size(57,96));
    
    std::vector<float> descriptors;

    // Put the data back into the output MATLAB array
    hog.compute(*img,descriptors);
    
    plhs[0] = getMexArray(descriptors);
}

