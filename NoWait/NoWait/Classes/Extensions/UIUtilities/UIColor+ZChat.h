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

#pragma mark - 绿色
+ (UIColor *)colorGreenDefault;
+ (UIColor *)colorGreenHL;


#pragma mark - 蓝色
+ (UIColor *)colorBlueMoment;

#pragma mark - 黄色
+ (UIColor *)colorOrangeMoment;

#pragma mark - 黑色
+ (UIColor *)colorBlackForNavBar;

#pragma mark - 红色
+ (UIColor *)colorRedForButton;
+ (UIColor *)colorRedForButtonHL;


#pragma mark - 白色
+ (UIColor *)colorWhite;

+ (UIColor *)colorBlack;
#pragma mark - 红色
+ (UIColor *)colorRedDefault;

#pragma mark - # 字体
+ (UIColor *)colorTextBlack;
+ (UIColor *)colorTextGray;
+ (UIColor *)colorTextGray1;

+ (UIColor *)colorTextBlackDark;
+ (UIColor *)colorTextGrayDark;
+ (UIColor *)colorTextGray1Dark;
 

#pragma mark - 灰色
+ (UIColor *)colorGrayBG;           // 浅灰色默认背景
+ (UIColor *)colorGrayContentBG;
+ (UIColor *)colorGrayLine;

+ (UIColor *)colorGrayBGDark;
+ (UIColor *)colorGrayContentBGDark;
+ (UIColor *)colorBlackBGDark;


@end

NS_ASSUME_NONNULL_END
