//
//  UIFont+ZChat.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/15.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZShortcutMethod.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (ZChat)

#pragma mark - Common
+ (UIFont *)fontNavBarTitle;
+ (UIFont *)fontMax1Title;
+ (UIFont *)fontMaxTitle;
+ (UIFont *)fontTitle;
+ (UIFont *)fontContent;
+ (UIFont *)fontSmall;
+ (UIFont *)fontMin;

#pragma mark - Conversation
+ (UIFont *)fontConversationUsername;
+ (UIFont *)fontConversationDetail;
+ (UIFont *)fontConversationTime;

#pragma mark - Friends
+ (UIFont *)fontFriendsUsername;

#pragma mark - Mine
+ (UIFont *)fontMineNikename;
+ (UIFont *)fontMineUsername;

#pragma mark - Setting
+ (UIFont *)fontSettingHeaderAndFooterTitle;


#pragma mark - Chat
+ (UIFont *)fontTextMessageText;

@end

NS_ASSUME_NONNULL_END
