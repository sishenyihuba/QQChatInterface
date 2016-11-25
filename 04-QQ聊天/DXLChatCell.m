//
//  DXLChatCell.m
//  04-QQ聊天
//
//  Created by daixianglong on 16/7/25.
//  Copyright © 2016年 Dale. All rights reserved.
//

#import "DXLChatCell.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
@interface DXLChatCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *otherIconView;
@property (weak, nonatomic) IBOutlet UIButton *otherChatButton;

@end

@implementation DXLChatCell


-(void)awakeFromNib {
    self.chatButton.titleLabel.numberOfLines = 0;
    self.otherChatButton.titleLabel.numberOfLines = 0;
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"chatcell";
    DXLChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    return cell;
}

-(void)setMessage:(DXLMessage *)message {
    _message = message;
    //设置timeLabel高度
    self.timeLabel.hidden = message.isHideTime;
    self.timeLabel.text = message.time;
    if(self.timeLabel.hidden) {
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    } else {
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(21);
        }];
    }
    //设置messageButton高度
    if(message.type == DXLMessageTypeMe) {
        self.otherIconView.hidden = YES;
        self.otherChatButton.hidden = YES;
        self.iconView.hidden = NO;
        self.chatButton.hidden = NO;
        [self showChatMessage:self.iconView withChatButton:self.chatButton];
    } else {
        self.otherIconView.hidden = NO;
        self.otherChatButton.hidden = NO;
        self.iconView.hidden = YES;
        self.chatButton.hidden = YES;
        [self showChatMessage:self.otherIconView withChatButton:self.otherChatButton];
    }
    
}

-(void)showChatMessage:(UIImageView*)showImageView withChatButton:(UIButton*)showButton {
    [showButton setTitle:self.message.text forState:UIControlStateNormal];
    [self layoutIfNeeded];
    //设置button的高度为Label的高度
    [showButton updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(showButton.titleLabel.frame.size.height+30);
    }];
    [self layoutIfNeeded];
    //计算Cell高度
    CGFloat iconMax = CGRectGetMaxY(showImageView.frame);
    CGFloat textMax = CGRectGetMaxY(showButton.frame);
    self.message.cellHeight = MAX(iconMax, textMax)+ 10;
}

@end
