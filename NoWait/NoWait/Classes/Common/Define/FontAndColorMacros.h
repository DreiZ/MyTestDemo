//
//  FontAndColorMacros.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZShortcutMethod.h"
#import "DarkModel.h"
#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h


#pragma mark -  间距区

//默认间距
#define KNormalSpace 12.0f

#pragma mark -  颜色区

//默认页面背景色
#define KBackColor [UIColor colorWithHexString:@"f3f3f3"]
//默认内容页面背景色
#define KContentBackColor [UIColor colorWithHexString:@"e8e8e8"]

#define KBorderColor [UIColor colorWithHexString:@"e3e3e3"] //227 227 227
//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"ededed"]

//次级字色
#define CFontColor1 [UIColor colorWithHexString:@"1f1f1f"]

//再次级字色
#define CFontColor2 [UIColor colorWithHexString:@"5c5c5c"]

//颜色
#define KClearColor [UIColor clearColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor colorWithHexString:@"ff4848"]
#define KTabBarColor [UIColor redColor]
#define KFont2Color [UIColor colorWithHexString:@"222222"]  //30 30 30
#define KFont3Color [UIColor colorWithHexString:@"333333"]  //30 30 30
#define KFont6Color [UIColor colorWithHexString:@"666666"]  //102 102 102
#define KFont9Color [UIColor colorWithHexString:@"999999"]  //153 153 153
#define KFont8Color [UIColor colorWithHexString:@"888888"]  //153 153 153
#define KFontCColor KLineColor   //204 204 204
#define KLineColor [UIColor colorWithHexString:@"cccccc"]   //204 204 204
#define KBackLightColor [UIColor colorWithHexString:@"f2f2f2"]   //242 242 242
#define kHN_OrangeHColor [UIColor colorWithHexString:@"eb7400"]
#define KYellowColor [UIColor colorWithHexString:@"ffcc00"]
#define KGreenColor [UIColor colorWithHexString:@"007553"]
#define KBlueBackColor [UIColor colorWithHexString:@"2337fc"] //背景蓝色

#define K1aBackColor [UIColor colorWithHexString:@"1a1a1a"] //背景色 darkModel
#pragma mark -  字体区
#define FFont1 [UIFont systemFontOfSize:12.0f]
#define FFontTitle [UIFont systemFontOfSize:CGFloatIn750(32)]
#define FFontContent [UIFont systemFontOfSize:CGFloatIn750(28)]
#define FFontSubContent [UIFont systemFontOfSize:CGFloatIn750(24)]
#define FFontSupplement [UIFont systemFontOfSize:CGFloatIn750(20)]

//颜色dark mode&正常
//#define KAdaptAndDarkColor(adaptColor,darkColor)
#define KAdaptAndDarkColor(adapt,dark) [DarkModel adaptColor:adapt darkColor:dark]

#define KIsDarkModel [DarkModel isDarkMode]

#endif /* FontAndColorMacros_h */
