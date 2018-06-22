//
//  WebSocket.h
//  FaceAR_SDK_IOS_OpenFace_RunFull
//
//  Created by SHO on 2018/06/22.
//  Copyright © 2018年 Keegan Ren. All rights reserved.
//

#ifndef WebSocket_h
#define WebSocket_h


#endif /* WebSocket_h */

#import <UIKit/UIKit.h>
#include "FaceARDetectIOS.h"
#import "SRWebSocket.h"

@interface WebSocket : UIViewController <SRWebSocketDelegate> 

-(instancetype)initJsonConnect:(NSString *)strUrl gaze__:(GazeInfo)gaze;

-(NSString *)updateJsonSend:(GazeInfo)gaze;

@end
