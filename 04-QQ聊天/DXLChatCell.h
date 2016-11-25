//
//  DXLChatCell.h
//  04-QQ聊天
//
//  Created by daixianglong on 16/7/25.
//  Copyright © 2016年 Dale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXLMessage.h"
@interface DXLChatCell : UITableViewCell

@property (nonatomic,strong)  DXLMessage* message;
+(instancetype)cellWithTableView:(UITableView*)tableView;
@end
