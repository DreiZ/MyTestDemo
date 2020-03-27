//
//  ZShortcutMethod.c
//  ZChat
//
//  Created by ZZZ on 2017/7/6.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#import "ZShortcutMethod.h"
#import "ZNavigationController.h"
#import "NSString+LLExtension.h"

ZNavigationController *addNavigationController(UIViewController *viewController)
{
    ZNavigationController *navC = [[ZNavigationController alloc] initWithRootViewController:viewController];
    return navC;
}


void initTabBarItem(UITabBarItem *tabBarItem, NSString *tilte, NSString *image, NSString *imageHL) {
    [tabBarItem setTitle:tilte];
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontMaxTitle]} forState:UIControlStateSelected];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark])} forState:UIControlStateSelected];
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


CGFloat safeAreaTop()
{
    CGFloat top = 0;
    CGFloat safeTop = 0 ;
    if(@available(iOS 11.0, *)) {
        safeTop = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
    }
    CGFloat height = safeTop > 0 ? safeTop : 20.0;  //顶部安全区为0时，不是刘海屏 ，则加上状态栏高度.
    top = height;
    
    return top;
}

CGFloat safeAreaBottom()
{
    CGFloat safeBottom = 0 ;
    if(@available(iOS 11.0, *)) {
        safeBottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    
    return safeBottom;
}


NSString *imageFullUrl(NSString *url) {
    if (!ValidStr(url)) {
        return @"";
    }
    if ([url isValidUrl]) {
        return url;
    }
    return [NSString stringWithFormat:@"%@/%@",URL_file,url];
}

ZCellConfig *getEmptyCellWithHeight(CGFloat height){
    ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:height cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
    return cellConfig;
}

ZCellConfig *getGrayEmptyCellWithHeight(CGFloat height){
    ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:height cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
    return cellConfig;
}
