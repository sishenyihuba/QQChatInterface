//
//  DXLMessage.m
//  04-QQ聊天
//
//  Created by daixianglong on 16/7/25.
//  Copyright © 2016年 Dale. All rights reserved.
//

#import "DXLMessage.h"

@implementation DXLMessage

+(instancetype)messageWithDict:(NSDictionary *)dict {
    DXLMessage *message = [[self alloc]init];
    [message setValuesForKeysWithDictionary:dict];
    return message;
}
@end
