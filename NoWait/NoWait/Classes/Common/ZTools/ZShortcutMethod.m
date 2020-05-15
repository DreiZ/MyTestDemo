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
static NSInteger color_index = 0;

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

UIColor *randomColor(void) {
    NSArray *temp = @[@"f7e155",@"ff7674",@"48e8a1",@"ffc15c",@"4dd599",
    @"ff9900",@"fccfba",@"b7ae8f",@"abb0b9",@"f1939c",@"f26b1f",@"F7C173",@"B89485",
    @"70A3FF",@"FFD111",@"FFB100",@"FFB100",@"FFB100",@"ADB9FF",@"CAD3C3",@"BACF65",
    @"CC3951",@"7282AE",@"66C18C",@"C8ADC4",@"D0DEAA",@"317523",@"2BAE85",@"FF62C3",
    @"0EB0C9",@"A974FF",@"E08FFD",@"6F48E8",@"813C85",@"CE5E8A",@"ED556A",
    @"2B73AF",@"61649F",@"E77C8E",@"FFA0C7"];
    if (color_index >= temp.count) {
        color_index = 0;
    }
    UIColor *tempColor = [UIColor colorWithHexString:temp[color_index]];
    color_index++;
    return tempColor;
}


UIColor *randomColorWithNum(NSInteger index) {
    NSArray *temp = @[@"f7e155",@"ff7674",@"48e8a1",@"ffc15c",@"4dd599",
    @"ff9900",@"fccfba",@"b7ae8f",@"abb0b9",@"f1939c",@"f26b1f",@"F7C173",@"B89485",
    @"70A3FF",@"FFD111",@"FFB100",@"FFB100",@"FFB100",@"ADB9FF",@"CAD3C3",@"BACF65",
    @"CC3951",@"7282AE",@"66C18C",@"C8ADC4",@"D0DEAA",@"317523",@"2BAE85",@"FF62C3",
    @"0EB0C9",@"A974FF",@"E08FFD",@"6F48E8",@"813C85",@"CE5E8A",@"ED556A",
    @"2B73AF",@"61649F",@"E77C8E",@"FFA0C7"];
    index = index % temp.count;
    UIColor *tempColor = [UIColor colorWithHexString:temp[index]];
  
    return tempColor;
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

NSString *getJSONStr(id data) {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
