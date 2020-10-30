#include "opencv2/opencv.hpp"
#include <chrono>  // for high_resolution_clock
#include <iostream>
#include <opencv2/cudacodec.hpp>

using namespace std;
using namespace cv;
// https://www.learnopencv.com/how-to-compile-opencv-sample-code/
// https://www.learnopencv.com/read-write-and-display-a-video-using-opencv-cpp-python/
// sudo make install # of opencv https://docs.opencv.org/master/d7/d9f/tutorial_linux_install.html
// pkg-config --cflags --libs /usr/local/lib/pkgconfig/opencv4.pc

int main(){
  //const std::string fname = "/video/directory/video.mp4";
  //cv::cuda::printShortCudaDeviceInfo(cv::cuda::getDevice());
  //cv::Ptr<cv::cudacodec::VideoReader> d_reader = cv::cudacodec::createVideoReader(fname);
  //cv::Ptr<cv::cudacodec::VideoWriter> d_writer;

  // Create a VideoCapture object and use camera to capture the video
  VideoCapture cap("20200829_045708_B8B2.mkv");

  // Check if camera opened successfully
  if(!cap.isOpened())
  {
    cout << "Error opening video stream" << endl;
    return -1;
      }

  // Default resolution of the frame is obtained.The default resolution is system dependent.
  int frame_width = cap.get(CAP_PROP_FRAME_WIDTH);
  int frame_height = cap.get(CAP_PROP_FRAME_HEIGHT);

  int current_frame = 0;

  // Define the codec and create VideoWriter object.The output is stored in 'outcpp.avi' file.
  //VideoWriter video("outcpp.mkv",cv::VideoWriter::fourcc('h','2','6','4'),10, Size(frame_width,frame_height));

  cv::Ptr<cv::cudacodec::VideoWriter> d_writer;
  const cv::String outputFilename = "output_gpu.avi";
  d_writer = cv::cudacodec::createVideoWriter(outputFilename, Size(frame_width,frame_height), 30);
  auto start = std::chrono::high_resolution_clock::now();
  while(1)
  {
    Mat frame;

    // Capture frame-by-frame
    cap >> frame;

    // If the frame is empty, break immediately
    if (frame.empty())
      break;

    // Write the frame into the file 'outcpp.avi'
    d_writer->write(frame);
    current_frame = current_frame + 1;
    // Display the resulting frame
    // imshow( "Frame", frame );

    if (current_frame == 3000)
        break;
    // Press  ESC on keyboard to  exit
    //char c = (char)waitKey(1);
    //if( c == 27 )
    //  break;
  }
  auto finish = std::chrono::high_resolution_clock::now();
  std::chrono::duration<double> elapsed = finish - start;
  // When everything done, release the video capture and write object
  cap.release();
  d_writer.release();
  cout << "elapsed time:" <<  (double)elapsed.count() << endl;
  float fps = (double)current_frame / (double)elapsed.count();
  cout << "FPS:" <<  fps << endl;
  // Closes all the windows
  destroyAllWindows();
  return 0;
}
