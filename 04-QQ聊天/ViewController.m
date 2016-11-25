//
//  ViewController.m
//  04-QQ聊天
//
//  Created by daixianglong on 16/7/25.
//  Copyright © 2016年 Dale. All rights reserved.
//

#import "ViewController.h"
#import "DXLMessage.h"
#import "DXLChatCell.h"
#import "DXLFooterView.h"
@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *messages;
@property (weak, nonatomic) IBOutlet UITextField *tf_message;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@end

@implementation ViewController


-(void)viewDidLoad {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(2, 0, 10, 5);
    self.tf_message.leftView = view;
    self.tf_message.leftViewMode = UITextFieldViewModeAlways;
    self.tableView.tableFooterView = [DXLFooterView footer];
    
    //监听keyboard广播
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadMore:) name:@"loadMore" object:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
     

//键盘相关
-(void)keyBoardWillShow:(NSNotification*)noti {
    float during = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    self.bottomConstraint.constant = rect.size.height;
    [UIView animateWithDuration:during animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)keyBoardWillHide:(NSNotification*)noti{
    float during = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    self.bottomConstraint.constant = 0;
    [UIView animateWithDuration:during animations:^{
        [self.view layoutIfNeeded];
    }];
}


    
    
    
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
     

-(NSMutableArray *)messages {
    if(_messages == nil) {
        _messages = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"messages" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *dictMessages = [[NSMutableArray alloc]initWithCapacity:20];
        DXLMessage *lastMessage = nil;
        for(NSDictionary *dict in dictArray) {
            DXLMessage *message = [DXLMessage messageWithDict:dict];
            message.hideTime = [message.time isEqualToString:lastMessage.time];
            [dictMessages addObject:message];
            lastMessage = message;
        }
        _messages = dictMessages;
    }
    return _messages;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DXLChatCell *cell = [DXLChatCell cellWithTableView:tableView];
    cell.message = self.messages[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DXLMessage *message = self.messages[indexPath.row];
    return message.cellHeight;
}

@end
