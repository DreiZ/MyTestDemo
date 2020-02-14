//
//  UIColor+ZChat.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/15.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "UIColor+ZChat.h"

@implementation UIColor (ZChat)
//主题色
+ (UIColor *)colorMain {
    return RGBAColor(77, 213, 153, 1.0);
}

+ (UIColor *)colorMainSub {
    return RGBAColor(160, 160, 160, 1.0);
}

//导航栏颜色
+ (UIColor *)colorNavBG {
    return RGBAColor(255, 255, 255, 1.0);
}

+ (UIColor *)colorNavBGFont {
    return RGBAColor(0, 0, 0, 1.0);
}


#pragma mark - # 字体
+ (UIColor *)colorTextBlack {
    return RGBAColor(45.0, 45.0, 45.0, 1.0);
}

+ (UIColor *)colorTextGray {
    return RGBAColor(132.0, 132.0, 136.0, 1.0);
}

+ (UIColor *)colorTextGray1 {
    return RGBAColor(200.0, 200.0, 200.0, 1.0);
}

#pragma mark - 灰色
+ (UIColor *)colorGrayBG {
    return RGBAColor(246.0, 246.0, 246.0, 1.0);
}

+ (UIColor *)colorGrayCharcoalBG {
    return RGBAColor(235.0, 235.0, 235.0, 1.0);
}

+ (UIColor *)colorGrayLine {
    return RGBAColor(246.0, 246.0, 246.0, 1.0);
}

+ (UIColor *)colorGrayForChatBar {
    return RGBAColor(245.0, 245.0, 247.0, 1.0);
}

+ (UIColor *)colorGrayForMoment {
    return RGBAColor(243.0, 243.0, 245.0, 1.0);
}


#pragma mark - 白色
+ (UIColor *)colorWhite {
    return RGBAColor(255.0, 255.0, 255.0, 1.0f);
}


#pragma mark - 红色
+ (UIColor *)colorRedDefault {
    return RGBAColor(255.0, 72.0, 72.0, 1.0f);
}

#pragma mark - 绿色
+ (UIColor *)colorGreenDefault {
    return RGBAColor(2.0, 187.0, 0.0, 1.0f);
}

+ (UIColor *)colorGreenHL {
    return RGBAColor(46, 139, 46, 1.0f);
}

#pragma mark - 蓝色
+ (UIColor *)colorBlueMoment {
    return RGBAColor(74.0, 99.0, 141.0, 1.0);
}

#pragma mark - 黄色
+ (UIColor *)colorOrangeMoment {
    return RGBAColor(235.0 ,116.0 ,0 , 1.0);
}
#pragma mark - 黑色
+ (UIColor *)colorBlackForNavBar {
    return RGBAColor(20.0, 20.0, 20.0, 1.0);
}

+ (UIColor *)colorBlackBG {
    return RGBAColor(46.0, 46.0, 46.0, 1.0);
}


+ (UIColor *)colorBlackDarkBG {
    return RGBAColor(26.0, 26.0, 26.0, 1.0);
}


+ (UIColor *)colorBlackAlphaScannerBG {
    return [UIColor colorWithWhite:0 alpha:0.6];
}

+ (UIColor *)colorBlackForAddMenu {
    return RGBAColor(71, 70, 73, 1.0);
}

+ (UIColor *)colorBlackForAddMenuHL {
    return RGBAColor(65, 64, 67, 1.0);
}


#pragma mark - #
+ (UIColor *)colorRedForButton {
    return RGBColor(228, 68, 71);
}

+ (UIColor *)colorRedForButtonHL {
    return RGBColor(205, 62, 64);
}

@end
