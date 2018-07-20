//
//  WebSocket.m
//  FaceAR_SDK_IOS_OpenFace_RunFull
//
//  Created by SHO on 2018/06/22.
//  Copyright © 2018年 Keegan Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebSocket.h"

@interface WebSocket ()
@end

@implementation WebSocket {
    
    SRWebSocket *webSocket;
    NSString *jsonStr, *op, *topic, *type;

    NSMutableDictionary *dataDic;
    NSMutableDictionary *msg;
    NSMutableDictionary *linear;
    NSMutableDictionary *angular;

}

//ソケットの接続とディクショナリの初期設定
- (instancetype)initJsonConnect:(NSString *)strUrl gaze__:(GazeInfo)gaze {
    
    //文字列の設定
    op = [NSString stringWithFormat:@"publish"];
    topic = [NSString stringWithFormat:@"/cmd_vel"];
    type = [NSString stringWithFormat:@"geometry_msgs/Twist"];
    
    //ディクショナリ
    dataDic  = [[NSMutableDictionary alloc] init];
    msg = [[NSMutableDictionary alloc] init];
    linear = [[NSMutableDictionary alloc] init];
    angular = [[NSMutableDictionary alloc] init];
    
    [dataDic setObject:op forKey:@"op"];
    [dataDic setObject:topic forKey:@"topic"];
    [dataDic setObject:msg forKey:@"msg"];
    [msg setObject:linear forKey:@"linear"];
    [msg setObject:angular forKey:@"angular"];
    
    [linear setObject:[NSNumber numberWithFloat:0.0] forKey:@"x"];
    [linear setObject:[NSNumber numberWithFloat:0.0] forKey:@"y"];
    [linear setObject:[NSNumber numberWithFloat:0.0] forKey:@"z"];
    
    [angular setObject:[NSNumber numberWithFloat:0.0] forKey:@"x"];
    [angular setObject:[NSNumber numberWithFloat:0.0] forKey:@"y"];
    [angular setObject:[NSNumber numberWithFloat:gaze.Angle.x - gaze.HeadPose(4)] forKey:@"z"];

    //ソケット
    [webSocket close];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"ws://%@:9090/", strUrl]];
    webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:url]];
    webSocket.delegate = self;
    [webSocket open];
    
    return self;
}

- (NSString *)updateJsonSend:(GazeInfo)gaze {

    [angular setObject:[NSNumber numberWithFloat:gaze.Angle.x - gaze.HeadPose(4)] forKey:@"z"];

    if([NSJSONSerialization isValidJSONObject:dataDic]){
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:&error];
        
        if (! data) {
            NSLog(@"Got an error: %@", error);
        }
        else {
            jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }
    [webSocket send:jsonStr];
    
    return jsonStr;
}

/*
- (NSString *)updateJsonSend:(GazeInfo)gaze {
    
    [webSocket send:@"{\"id\":\"1\"}"];
    
    [webSocket send:jsonStr];
    
    return returnStr;
}
*/


//サーバに接続したとき
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    //[webSocket send:@"Nexus 7を発送しました"];
}

//サーバからメッセージを受信したとき
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    //returnStr = [NSString stringWithFormat:@"didReceiveMessage: %@\n", message];
    //NSLog(@"didReceiveMessage: %@\n", [message description]);
    //[webSocket send:jsonString];
}

@end

