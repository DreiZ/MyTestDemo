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
    return HexColor(0x4dd599);
}

+ (UIColor *)colorMainSub {
    return HexAColor(0x4dd599, 0.2);
}

+ (UIColor *)colorMainLight {
    return HexAColor(0x4dd599, 0.2);
}

//导航栏颜色
+ (UIColor *)colorNavBG {
    return  HexAColor(0xffffff, 1.0);
}

+ (UIColor *)colorNavBGFont {
    return HexAColor(0x000000, 1.0);
}


#pragma mark - 白色
+ (UIColor *)colorWhite {
    return HexAColor(0xffffff, 1.0);
}

#pragma mark - 按钮#
+ (UIColor *)colorRedForButton {
    return RGBColor(228, 68, 71);
}

+ (UIColor *)colorRedForButtonHL {
    return RGBColor(205, 62, 64);
}


#pragma mark - 黑色
+ (UIColor *)colorBlack {
    return HexAColor(0x000000, 1.0);
}


#pragma mark - 红色
+ (UIColor *)colorRedDefault {
    return HexAColor(0xf74444, 1.0);
}

+ (UIColor *)colorRedForLabel {
    return HexAColor(0xfb5710, 1.0);
}

+ (UIColor *)colorRedForLabelSub{
    return HexAColor(0xfb5710, 0.2);
}

#pragma mark - 绿色
+ (UIColor *)colorGreenDefault {
    return HexAColor(0x02bb00, 1.0);
}

+ (UIColor *)colorGreenHL {
    return HexAColor(0x2E8B2E, 1.0);
}

#pragma mark - 蓝色
+ (UIColor *)colorBlueMoment {
    return HexAColor(0x4A638D, 1.0);
}

#pragma mark - 黄色
+ (UIColor *)colorOrangeMoment {
    return HexAColor(0xF49015, 1.0);
}

+ (UIColor *)colorOrangeBack {
    return HexAColor(0xF49015, 0.3);
}

#pragma mark - 黑色
+ (UIColor *)colorBlackForNavBar {
    return HexAColor(0x141414, 1.0);
}



#pragma mark - # 字体
+ (UIColor *)colorTextBlack {
    return HexAColor(0x2d2d2d, 1.0);
}

+ (UIColor *)colorTextGray {
    return HexAColor(0x848488, 1.0);
}

+ (UIColor *)colorTextGray1 {
    return HexAColor(0xc8c8c8, 1.0);
}

+ (UIColor *)colorTextBlackDark {
    return HexAColor(0xc8c8c8, 1.0);
}

+ (UIColor *)colorTextGrayDark {
    return HexAColor(0x666666, 1.0);
}

+ (UIColor *)colorTextGray1Dark {
    return HexAColor(0x333333, 1.0);
}

#pragma mark - 灰色
+ (UIColor *)colorGrayBG {
    return HexAColor(0xf6f6f6, 1.0);
}

+ (UIColor *)colorGrayContentBG {
    return HexAColor(0xc8c8cf, 1.0);
}


+ (UIColor *)colorGrayLine {
    return HexAColor(0xf6f6f6, 1.0);
}

+ (UIColor *)colorGrayBGDark {
    return HexAColor(0x2e2e2e, 1.0);
}

+ (UIColor *)colorGrayContentBGDark {
    return HexAColor(0x28282f, 1.0);
}

+ (UIColor *)colorBlackBGDark {
    return HexAColor(0x1a1a1a, 1.0);
}

@end
