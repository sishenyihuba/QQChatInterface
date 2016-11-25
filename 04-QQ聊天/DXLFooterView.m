//
//  DXLFooterView.m
//  04-QQ聊天
//
//  Created by daixianglong on 16/7/28.
//  Copyright © 2016年 Dale. All rights reserved.
//

#import "DXLFooterView.h"

@interface DXLFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;
@property (weak, nonatomic) IBOutlet UIView *loadMoreView;

@end

@implementation DXLFooterView


+(instancetype)footer {
    return [[[NSBundle mainBundle]loadNibNamed:@"DXLFooterView" owner:nil options:nil]lastObject];
}

- (IBAction)loadMore:(id)sender {
//    self.loadMoreButton.hidden = YES;
//    self.loadMoreView.hidden = NO;
//    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"loadMore" object:nil];
    NSLog(@"=----");
}

-(void)endLoading {
    self.loadMoreButton.hidden = NO;
    self.loadMoreView.hidden = YES;
}
@end
