//
//  UIColor+ZChat.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/15.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZShortcutMethod.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZChat)

//主题色
+ (UIColor *)colorMain;
+ (UIColor *)colorMainSub;

//导航栏颜色
+ (UIColor *)colorNavBG;
+ (UIColor *)colorNavBGFont;

#pragma mark - 白色
+ (UIColor *)colorWhite;

#pragma mark - # 字体
+ (UIColor *)colorTextBlack;
+ (UIColor *)colorTextGray;
+ (UIColor *)colorTextGray1;
 

#pragma mark - 灰色
+ (UIColor *)colorGrayBG;           // 浅灰色默认背景
+ (UIColor *)colorGrayCharcoalBG;   // 较深灰色背景（聊天窗口, 朋友圈用）
+ (UIColor *)colorGrayLine;
+ (UIColor *)colorGrayForChatBar;
+ (UIColor *)colorGrayForMoment;



#pragma mark - 绿色
+ (UIColor *)colorGreenDefault;
+ (UIColor *)colorGreenHL;


#pragma mark - 蓝色
+ (UIColor *)colorBlueMoment;


#pragma mark - 黑色
+ (UIColor *)colorBlackForNavBar;
+ (UIColor *)colorBlackBG;
+ (UIColor *)colorBlackAlphaScannerBG;
+ (UIColor *)colorBlackForAddMenu;
+ (UIColor *)colorBlackForAddMenuHL;

#pragma mark - 红色
+ (UIColor *)colorRedForButton;
+ (UIColor *)colorRedForButtonHL;

@end

NS_ASSUME_NONNULL_END
