//
//  ZShortcutMethod.h
//  ZChat
//
//  Created by ZZZ on 2017/7/6.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 为ViewController添加navController
 */
UINavigationController *addNavigationController(UIViewController *viewController);

/**
 * 初始化tabBarItem
 */
void initTabBarItem(UITabBarItem *tabBarItem, NSString *tilte, NSString *image, NSString *imageHL);


CGFloat CGFloatIn640(CGFloat value);

CGFloat CGFloatIn750(CGFloat value);
