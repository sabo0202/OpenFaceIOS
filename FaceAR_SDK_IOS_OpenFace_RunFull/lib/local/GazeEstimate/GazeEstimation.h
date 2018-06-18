#ifndef __GAZEESTIMATION_h_
#define __GAZEESTIMATION_h_

#include "LandmarkCoreIncludes.h"

#include "LandmarkDetectorModel.h"

#include "opencv2/core/core.hpp"

namespace GazeEstimate
{
    
void EstimateGaze(const LandmarkDetector::CLNF& clnf_model, cv::Point3f& gaze_absolute, float fx, float fy, float cx, float cy, bool left_eye);
    
void DrawGaze(cv::Mat img, const LandmarkDetector::CLNF& clnf_model, cv::Point3f gazeVecAxisLeft, cv::Point3f gazeVecAxisRight, float fx, float fy, float cx, float cy);
    
cv::Point3f GetPupilPosition(cv::Mat_<double> eyeLdmks3d);
    
cv::Vec2f GetGazeAngle(cv::Point3f& gaze_vector_1, cv::Point3f& gaze_vector_2);
    
}
#endif
