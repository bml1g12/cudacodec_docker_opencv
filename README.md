Requirements: 

Download from NVIDIA:

Video_Codec_SDK_9.1.23.zip
opencv_contrib-4.3.0.zip
opencv-4.3.0.zip


Adapted from https://github.com/opencv/opencv/issues/17649 
Downgraded cuda by 0.1 to match my machine CUDA
And as per the article, set WITH_NVCUVID=OFF
Had to modify Dockefile to install packages from default sources, as they did not provide sources.txt


The issue I still get is:
```
terminate called after throwing an instance of 'cv::Exception'
  what():  OpenCV(4.3.0) /opencv-4.3.0/modules/core/include/opencv2/core/private.cuda.hpp:115: error: (-213:The function/feature is not implemented) The called functionality is disabled for current build or platform in function 'throw_no_cuda'
```

https://github.com/opencv/opencv_contrib/issues/1786 