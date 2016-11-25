//
//  DXLMessage.h
//  04-QQ聊天
//
//  Created by daixianglong on 16/7/25.
//  Copyright © 2016年 Dale. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DXLMessageTypeMe =0,
    DXLMessageTypeOther =1
} DXLMessageType;

@interface DXLMessage : NSObject
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,assign) DXLMessageType type;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign,getter=isHideTime) BOOL hideTime;

+(instancetype)messageWithDict:(NSDictionary*)dict;
@end
