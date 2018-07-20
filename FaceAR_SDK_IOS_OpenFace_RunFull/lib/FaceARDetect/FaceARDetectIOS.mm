//
//  FaceARDetectIOS.m
//  FaceAR_SDK_IOS_OpenFace_RunFull
//
//  Created by Keegan Ren on 7/5/16.
//  Copyright © 2016 Keegan Ren. All rights reserved.
//

#import "FaceARDetectIOS.h"

LandmarkDetector::FaceModelParameters det_parameters;
// The modules that are being used for tracking
LandmarkDetector::CLNF clnf_model;

@implementation FaceARDetectIOS


//bool inits_FaceAR();
-(id) init
{
    self = [super init];
    NSString *location = [[NSBundle mainBundle] resourcePath];
    det_parameters.init();
    det_parameters.model_location = [location UTF8String] + std::string("/model/main_clnf_general.txt");
    det_parameters.face_detector_location = [location UTF8String] + std::string("/classifiers/haarcascade_frontalface_alt.xml");
    
    std::cout << "model_location = " << det_parameters.model_location << std::endl;
    std::cout << "face_detector_location = " << det_parameters.face_detector_location << std::endl;
    
    clnf_model.model_location_clnf = [location UTF8String] + std::string("/model/main_clnf_general.txt");
    clnf_model.face_detector_location_clnf = [location UTF8String] + std::string("/classifiers/haarcascade_frontalface_alt.xml");
    clnf_model.inits();
    
    return self;
}

// Visualising the results
cv::Vec6d visualise_tracking(cv::Mat& captured_image, cv::Mat_<float>& depth_image, const LandmarkDetector::CLNF& face_model, const LandmarkDetector::FaceModelParameters& det_parameters, int frame_count, double fx, double fy, double cx, double cy)
//-(BOOL) visualise_tracking:(cv::Mat)captured_image depth_image_:(cv::Mat)depth_image face_model_:(const LandmarkDetector::CLNF)face_model det_parameters_:(const LandmarkDetector::FaceModelParameters)det_parameters frame_count_:(int)frame_count fx_:(double)fx fy_:(double)fy cx_:(double)cx cy_:(double)cy
{
    
    // Drawing the facial landmarks on the face and the bounding box around it if tracking is successful and initialised
    cv::Vec6d HeadPose = {0, 0, 0, 0, 0, 0};
    
    double detection_certainty = face_model.detection_certainty;
    //bool detection_success = face_model.detection_success;
    
    double visualisation_boundary = 0.2;
    
    cv::Mat outputImage = cv::Mat::zeros(captured_image.cols, captured_image.rows, CV_8UC3);
    
    // Only draw if the reliability is reasonable, the value is slightly ad-hoc
    if (detection_certainty < visualisation_boundary)
    {
        //LandmarkDetector::Draw(outputImage, face_model);
        LandmarkDetector::Draw(captured_image, face_model);
        
        double vis_certainty = detection_certainty;
        if (vis_certainty > 1)
            vis_certainty = 1;
        if (vis_certainty < -1)
            vis_certainty = -1;
        
        vis_certainty = (vis_certainty + 1) / (visualisation_boundary + 1);
        
        // A rough heuristic for box around the face width
        int thickness = (int)std::ceil(2.0* ((double)captured_image.cols) / 640.0);
        
        cv::Vec6d pose_estimate_to_draw = LandmarkDetector::GetCorrectedPoseWorld(face_model, fx, fy, cx, cy);
        HeadPose = pose_estimate_to_draw;
        
        // Draw it in reddish if uncertain, blueish if certain
        LandmarkDetector::DrawBox(captured_image, pose_estimate_to_draw, cv::Scalar((1 - vis_certainty)*255.0, 0, vis_certainty * 255), thickness, fx, fy, cx, cy);
        
    }
    
    return HeadPose;
}


//bool run_FaceAR(cv::Mat &captured_image, int frame_count, float fx, float fy, float cx, float cy);
-(GazeInfo) run_FaceAR:(cv::Mat)captured_image frame__:(int)frame_count fx__:(double)fx fy__:(double)fy cx__:(double)cx cy__:(double)cy
{
    GazeInfo gaze = {{0, 0, -1}, {0, 0, -1}, {0, 0, 0}};
    
    // Reading the images
    cv::Mat_<float> depth_image;
    cv::Mat_<uchar> grayscale_image;
    
    if(captured_image.channels() == 3)
    {
        cv::cvtColor(captured_image, grayscale_image, CV_BGR2GRAY);
    }
    else
    {
        grayscale_image = captured_image.clone();
    }
    
    // The actual facial landmark detection / tracking
    bool detection_success = LandmarkDetector::DetectLandmarksInVideo(grayscale_image, depth_image, clnf_model, det_parameters);
    //bool detection_success = LandmarkDetector::DetectLandmarksInImage(grayscale_image, depth_image, clnf_model, det_parameters);
    
    // Visualising the results
    // Drawing the facial landmarks on the face and the bounding box around it if tracking is successful and initialised
    double detection_certainty = clnf_model.detection_certainty;
    
    gaze.HeadPose = visualise_tracking(captured_image, depth_image, clnf_model, det_parameters, frame_count, fx, fy, cx, cy);
    gaze.HeadPose(3) = gaze.HeadPose(3) * 180.0 / 3.14159;
    gaze.HeadPose(4) = gaze.HeadPose(4) * 180.0 / 3.14159;
    gaze.HeadPose(5) = gaze.HeadPose(5) * 180.0 / 3.14159;

    //////////////////////////////////////////////////////////////////////
    /// gaze EstimateGaze
    //////////////////////////////////////////////////////////////////////
    if (det_parameters.track_gaze && detection_success && clnf_model.eye_model)
    {
        GazeEstimate::EstimateGaze(clnf_model, gaze.Direction0, fx, fy, cx, cy, true);
        GazeEstimate::EstimateGaze(clnf_model, gaze.Direction1, fx, fy, cx, cy, false);
        gaze.Angle = GazeEstimate::GetGazeAngle(gaze.Direction0, gaze.Direction1);
        
        GazeEstimate::DrawGaze(captured_image, clnf_model, gaze.Direction0, gaze.Direction1, fx, fy, cx, cy);
    }
    
    return gaze;
}

//bool reset_FaceAR();
-(BOOL) reset_FaceAR
{
    clnf_model.Reset();
    
    return true;
}

//bool clear_FaceAR();
-(BOOL) clear_FaceAR
{
    clnf_model.Reset();
    
    return true;
}


@end
