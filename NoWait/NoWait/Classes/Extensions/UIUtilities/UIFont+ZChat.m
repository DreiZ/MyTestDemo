//
//  UIFont+ZChat.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/15.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "UIFont+ZChat.h"

@implementation UIFont (ZChat)

+ (UIFont *) fontNavBarTitle
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(32)];
}

+ (UIFont *)fontMax1Title
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(38)];
}

+ (UIFont *)fontMaxTitle
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(32)];
}


+ (UIFont *)fontTitle
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(32)];
}

+ (UIFont *)fontContent
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(28)];
}

+ (UIFont *)fontSmall
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(24)];
}

+ (UIFont *)fontMin
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(20)];
}

+ (UIFont *) fontConversationUsername
{
    return [UIFont systemFontOfSize:17.0f];
}

+ (UIFont *) fontConversationDetail
{
    return [UIFont systemFontOfSize:14.0f];
}

+ (UIFont *) fontConversationTime
{
    return [UIFont systemFontOfSize:12.5f];
}

+ (UIFont *) fontFriendsUsername
{
    return [UIFont systemFontOfSize:17.0f];
}

+ (UIFont *) fontMineNikename
{
    return [UIFont systemFontOfSize:17.0f];
}

+ (UIFont *) fontMineUsername
{
    return [UIFont systemFontOfSize:14.0f];
}

+ (UIFont *) fontSettingHeaderAndFooterTitle
{
    return [UIFont systemFontOfSize:14.0f];
}

+ (UIFont *)fontTextMessageText
{
    CGFloat size = [[NSUserDefaults standardUserDefaults] doubleForKey:@"CHAT_FONT_SIZE"];
    if (size == 0) {
        size = 16.0f;
    }
    return [UIFont systemFontOfSize:size];
}

@end
