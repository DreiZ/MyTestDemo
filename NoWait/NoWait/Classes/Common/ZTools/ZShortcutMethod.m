//
//  ZShortcutMethod.c
//  ZChat
//
//  Created by ZZZ on 2017/7/6.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#import "ZShortcutMethod.h"
#import "ZNavigationController.h"

ZNavigationController *addNavigationController(UIViewController *viewController)
{
    ZNavigationController *navC = [[ZNavigationController alloc] initWithRootViewController:viewController];
    return navC;
}


void initTabBarItem(UITabBarItem *tabBarItem, NSString *tilte, NSString *image, NSString *imageHL) {
    [tabBarItem setTitle:tilte];
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontMaxTitle]} forState:UIControlStateSelected];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor  colorMain]} forState:UIControlStateSelected];
    [tabBarItem setImage:[UIImage imageNamed:image]];
    [tabBarItem setSelectedImage:[[UIImage imageNamed:imageHL] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

UIColor *adaptAndDarkColor(UIColor *adapt, UIColor *dark){
    return [DarkModel adaptColor:adapt darkColor:dark];
}

BOOL isDarkModel() {
    return [DarkModel isDarkMode];
}

CGFloat CGFloatIn640(CGFloat value)
{
    return  (value/640.)*KScreenWidth;
}

CGFloat CGFloatIn750(CGFloat value)
{
    return  (value/750.)*KScreenWidth;
}
