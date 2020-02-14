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


#pragma mark -  颜色区

//颜色dark mode&正常
//#define adaptAndDarkColor(adaptColor,darkColor)
#define KAdaptAndDarkColor(adapt,dark) [DarkModel adaptColor:adapt darkColor:dark]

#define KIsDarkModel [DarkModel isDarkMode]

#endif /* FontAndColorMacros_h */
