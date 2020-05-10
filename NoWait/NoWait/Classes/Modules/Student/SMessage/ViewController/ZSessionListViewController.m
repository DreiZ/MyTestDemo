//
//  ZSessionListViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSessionListViewController.h"

#import "ZSessionViewController.h"
#import "ZContactViewController.h"

@interface ZSessionListViewController ()

@end

@implementation ZSessionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSession)];
    self.navigationItem.rightBarButtonItem = item;
}


- (void)onSelectedRecent:(NIMRecentSession *)recent
             atIndexPath:(NSIndexPath *)indexPath
{
    ZSessionViewController *vc = [[ZSessionViewController alloc] initWithSession:recent.session];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addSession
{
    ZContactViewController *vc = [[ZContactViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSAttributedString *)contentForRecentSession:(NIMRecentSession *)recent {
    NIMMessage *lastMessage = recent.lastMessage;
    NSString *text = @"";
    switch (lastMessage.messageType) {
        case NIMMessageTypeText:
            text = lastMessage.text;
            break;
        case NIMMessageTypeAudio:
            text = @"[语音]";
            break;
        case NIMMessageTypeImage:
            text = @"[图片]";
            break;
        case NIMMessageTypeVideo:
            text = @"[视频]";
            break;
        case NIMMessageTypeLocation:
            text = @"[位置]";
            break;
        case NIMMessageTypeNotification:{
//            return [self notificationMessageContent:lastMessage];
            text = @"系统通知";
            break;
        }
        case NIMMessageTypeFile:
            text = @"[文件]";
            break;
        case NIMMessageTypeTip:
            text = lastMessage.text;
            break;
        case NIMMessageTypeRobot:
            text = @"机器人消息";
            break;
        default:
            text = @"[未知消息]";
    }
    return [super contentForRecentSession:recent];
}
@end
