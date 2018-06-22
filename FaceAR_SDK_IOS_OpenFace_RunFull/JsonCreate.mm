//
//  JsonCreate.m
//  FaceAR_SDK_IOS_OpenFace_RunFull
//
//  Created by SHO on 2018/06/21.
//  Copyright © 2018年 Keegan Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonCreate.h"

@implementation JsonCreate {
    NSMutableDictionary *dataDic;
    NSMutableDictionary *gazeDir0Dic;
    NSMutableDictionary *gazeDir1Dic;
    NSMutableDictionary *gazeAglDic;
    NSString *jsonStr;

}


- (instancetype)initWithJson:(GazeInfo)gaze {
    self = [super init];

    dataDic = [[NSMutableDictionary alloc] init];
    
    gazeDir0Dic = [[NSMutableDictionary alloc] init];
    gazeDir1Dic = [[NSMutableDictionary alloc] init];
    gazeAglDic = [[NSMutableDictionary alloc] init];
    
    [dataDic setObject:gazeDir0Dic forKey:@"gazeDirection0"];
    [dataDic setObject:gazeDir1Dic forKey:@"gazeDirection1"];
    [dataDic setObject:gazeAglDic forKey:@"gazeAngle"];
    
    [gazeDir0Dic setObject:[NSString stringWithFormat:@"%.3f", gaze.Direction0.x] forKey:@"gazeDirection0.x"];
    [gazeDir0Dic setObject:[NSString stringWithFormat:@"%.3f", gaze.Direction0.y] forKey:@"gazeDirection0.y"];
    [gazeDir0Dic setObject:[NSString stringWithFormat:@"%.3f", gaze.Direction0.z] forKey:@"gazeDirection0.z"];
    
    [gazeDir1Dic setObject:[NSString stringWithFormat:@"%.3f", gaze.Direction1.x] forKey:@"gazeDirection1.x"];
    [gazeDir1Dic setObject:[NSString stringWithFormat:@"%.3f", gaze.Direction1.y] forKey:@"gazeDirection1.y"];
    [gazeDir1Dic setObject:[NSString stringWithFormat:@"%.3f", gaze.Direction1.z] forKey:@"gazeDirection1.z"];
    
    [gazeAglDic setObject:[NSString stringWithFormat:@"%.3f", gaze.Angle.x] forKey:@"gazeAngle.x"];
    [gazeAglDic setObject:[NSString stringWithFormat:@"%.3f", gaze.Angle.y] forKey:@"gazeAngle.y"];
    [gazeAglDic setObject:[NSString stringWithFormat:@"%.3f", gaze.Angle.z] forKey:@"gazeAngle.z"];
    
    return self;
}


-(NSString *)updateJson:(GazeInfo)gaze {
    
    //NSString *jsonStr;
    
    gazeDir0Dic[@"gazeDirection0.x"] = [NSString stringWithFormat:@"%.3f", gaze.Direction0.x];
    gazeDir0Dic[@"gazeDirection0.y"] = [NSString stringWithFormat:@"%.3f", gaze.Direction0.y];
    gazeDir0Dic[@"gazeDirection0.z"] = [NSString stringWithFormat:@"%.3f", gaze.Direction0.z];
    gazeDir1Dic[@"gazeDirection1.x"] = [NSString stringWithFormat:@"%.3f", gaze.Direction1.x];
    gazeDir1Dic[@"gazeDirection1.y"] = [NSString stringWithFormat:@"%.3f", gaze.Direction1.y];
    gazeDir1Dic[@"gazeDirection1.z"] = [NSString stringWithFormat:@"%.3f", gaze.Direction1.z];
    gazeAglDic[@"gazeAngle.x"] = [NSString stringWithFormat:@"%.3f", gaze.Angle.x];
    gazeAglDic[@"gazeAngle.y"] = [NSString stringWithFormat:@"%.3f", gaze.Angle.y];
    gazeAglDic[@"gazeAngle.z"] = [NSString stringWithFormat:@"%.3f", gaze.Angle.z];
    
    if([NSJSONSerialization isValidJSONObject:dataDic]){
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:&error];
        
        if (! data) {
            NSLog(@"Got an error: %@", error);
        }
        else {
            jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"%@", jsonStr);
        }
    }
    return jsonStr;
}

@end
