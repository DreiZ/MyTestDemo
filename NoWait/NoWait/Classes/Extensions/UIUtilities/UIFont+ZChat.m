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
    return [UIFont systemFontOfSize:CGFloatIn750(32)];
}


+ (UIFont *)fontMax2Title
{
    return [UIFont systemFontOfSize:CGFloatIn750(40)];
}

+ (UIFont *)fontMax1Title
{
    return [UIFont systemFontOfSize:CGFloatIn750(36)];
}

+ (UIFont *)fontMaxTitle
{
    return [UIFont systemFontOfSize:CGFloatIn750(32)];
}


+ (UIFont *)fontTitle
{
    return [UIFont systemFontOfSize:CGFloatIn750(32)];
}

+ (UIFont *)fontContent
{
    return [UIFont systemFontOfSize:CGFloatIn750(28)];
}

+ (UIFont *)fontSmall
{
    return [UIFont systemFontOfSize:CGFloatIn750(24)];
}

+ (UIFont *)fontMin
{
    return [UIFont systemFontOfSize:CGFloatIn750(20)];
}



+ (UIFont *)boldFontMax2Title
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(40)];
}

+ (UIFont *)boldFontMax1Title
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(36)];
}

+ (UIFont *)boldFontMaxTitle
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(32)];
}


+ (UIFont *)boldFontTitle
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(32)];
}

+ (UIFont *)boldFontContent
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(28)];
}

+ (UIFont *)boldFontSmall
{
    return [UIFont boldSystemFontOfSize:CGFloatIn750(24)];
}

+ (UIFont *)boldFontMin
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
