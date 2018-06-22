//
//  JsonCreate.h
//  FaceAR_SDK_IOS_OpenFace_RunFull
//
//  Created by SHO on 2018/06/21.
//  Copyright © 2018年 Keegan Ren. All rights reserved.
//

#ifndef JsonCreate_h
#define JsonCreate_h

#endif /* JsonCreate_h */

#include "FaceARDetectIOS.h"
//#import "WebSocket.h"


@interface JsonCreate : NSObject

-(instancetype)initWithJson:(GazeInfo)gaze;

-(NSString *)updateJson:(GazeInfo)gaze;


@end
