//
//  TFTCPConnection.m
//  FaceAR_SDK_IOS_OpenFace_RunFull
//
//  Created by SHO on 2018/06/21.
//  Copyright © 2018年 Keegan Ren. All rights reserved.
//

#import "Fruit.h"

@implementation Fruit

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _name = [dictionary objectForKey:@"name"];
        _image = [dictionary objectForKey:@"image"];
    }
    return self;
}

@end
