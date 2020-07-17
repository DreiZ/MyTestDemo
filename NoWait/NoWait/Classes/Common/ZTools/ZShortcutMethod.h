//
//  ZShortcutMethod.h
//  ZChat
//
//  Created by ZZZ on 2017/7/6.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DarkModel.h"
#import "ZCellConfig.h"

/**
 * 为ViewController添加navController
 */
UINavigationController *addNavigationController(UIViewController *viewController);

/**
 * 初始化tabBarItem
 */
void initTabBarItem(UITabBarItem *tabBarItem, NSString *tilte, NSString *image, NSString *imageHL);

UIColor *randomColor(void);

UIColor *randomColorWithNum(NSInteger index);

UIColor *adaptAndDarkColor(UIColor *adapt, UIColor *dark);

BOOL isDarkModel(void);

NSString *getJSONStr(id data);

CGFloat CGFloatIn640(CGFloat value);

CGFloat CGFloatIn750(CGFloat value);

CGFloat safeAreaTop(void);

CGFloat safeAreaBottom(void);

NSString *imageFullUrl(NSString *);

NSString *aliyunVideoFullUrl(NSString *url);

ZCellConfig *getEmptyCellWithHeight(CGFloat height);

ZCellConfig *getGrayEmptyCellWithHeight(CGFloat height);

BOOL isVideo(NSString *url);
