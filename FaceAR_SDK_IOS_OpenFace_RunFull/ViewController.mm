//
//  ViewController.m
//  FaceAR_SDK_IOS_OpenFace_RunFull
//
//  Created by Keegan Ren on 7/5/16.
//  Copyright © 2016 Keegan Ren. All rights reserved.
//

#import "ViewController.h"

///// opencv
#import <opencv2/opencv.hpp>
///// C++
#include <iostream>
///// user
#include "FaceARDetectIOS.h"
//



@interface ViewController ()

@end

@implementation ViewController {
    FaceARDetectIOS *facear;
    int frame_count;
    GazeInfo gaze;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];

    // Do any additional setup after loading the view, typically from a nib.
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:self.videoView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    
    ///////////////////
    //    facear =[[FaceARDetectIOS alloc] init];
    
}

- (IBAction)startButtonPressed:(id)sender
{
    [self.videoCamera start];
}

- (void)processImage:(cv::Mat &)image
{
    cv::Mat blackImage(image.cols,image.rows,CV_8UC3);
    cv::Mat captureImage(image.cols,image.rows,CV_8UC3);
    cv::cvtColor(image, captureImage, cv::COLOR_BGRA2BGR);
    if(captureImage.empty()){
        std::cout << "captureImage empty" << std::endl;
    }
    else
    {
        float fx, fy, cx, cy;
        cx = 1.0*captureImage.cols / 2.0;
        cy = 1.0*captureImage.rows / 2.0;
        
        fx = 500 * (captureImage.cols / 640.0);
        fy = 500 * (captureImage.rows / 480.0);
        
        fx = (fx + fy) / 2.0;
        fy = fx;
        
        //[[FaceARDetectIOS alloc] run_FaceAR:captureImage frame__:frame_count fx__:fx fy__:fy cx__:cx cy__:cy gazeInfo__:gaze];
        gaze = [[FaceARDetectIOS alloc] run_FaceAR:captureImage frame__:frame_count fx__:fx fy__:fy cx__:cx cy__:cy];
        frame_count = frame_count + 1;
    }
    cv::cvtColor(captureImage, image, cv::COLOR_BGRA2RGB);
    //cv::cvtColor(blackImage, image, cv::COLOR_BGRA2RGB);
    NSLog(@"[左目の視線方向ベクトル]\n "@"%.3f\n" @"%.3f\n" @"%.3f\n", gaze.Direction0.x, gaze.Direction0.y, gaze.Direction0.z);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
