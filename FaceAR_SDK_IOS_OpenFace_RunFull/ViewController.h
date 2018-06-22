//
//  ViewController.h
//  FaceAR_SDK_IOS_OpenFace_RunFull
//
//  Created by Keegan Ren on 7/5/16.
//  Copyright © 2016 Keegan Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

///// opencv
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/opencv.hpp>
///// C++
#include <iostream>
///// user
//#include "FaceARDetectIOS.h"
#import "WebSocket.h"
//

@interface ViewController : UIViewController<CvVideoCameraDelegate>

//- (IBAction)startButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet UIImageView *videoView;

@property (nonatomic, strong) CvVideoCamera* videoCamera;

@end
