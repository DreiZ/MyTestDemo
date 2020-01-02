//
//  UINavigationController+ZChat.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/15.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "UINavigationController+ZChat.h"

@implementation UINavigationController (ZChat)

+ (void)load
{
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont fontNavBarTitle]}];
    
    TLExchangeMethod(@selector(loadView), @selector(__tt_loadView));
}

- (void)__tt_loadView
{
    [self __tt_loadView];
    
    [self.navigationBar setBarTintColor:[UIColor colorBlackForNavBar]];
    [self.navigationBar setTintColor:[UIColor blackColor]];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
}

@end
