Requirements: 

Download from NVIDIA:

Video_Codec_SDK_9.1.23.zip
opencv_contrib-4.3.0.zip
opencv-4.3.0.zip
An example video file, named "20200829_045708_B8B2.mkv" 

And place then all in the root directory.


Adapted from https://github.com/opencv/opencv/issues/17649 
Downgraded cuda by 0.1 to match my machine CUDA
And as per the article, set WITH_NVCUVID=OFF
Had to modify Dockefile to install packages from default sources, as they did not provide sources.txt


The issue I still get is:
```
terminate called after throwing an instance of 'cv::Exception'
  what():  OpenCV(4.3.0) /opencv-4.3.0/modules/core/include/opencv2/core/private.cuda.hpp:115: error: (-213:The function/feature is not implemented) The called functionality is disabled for current build or platform in function 'throw_no_cuda'
```

Same issue with Dockerfile_2. To compile in this case you only need to link /usr/local/lib/liboncv_world in the ./compile/run 

https://github.com/opencv/opencv_contrib/issues/1786 
