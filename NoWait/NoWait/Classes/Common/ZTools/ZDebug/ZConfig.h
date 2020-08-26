//
//  Macro.h
//  zzz
//
//  Created by zzz on 2018/4/18.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLMacros.h"

#if DevelopSever
//打印图片名字为空的错误信息
#define LogImageNameErrorIfNil

//打印veiwDidLoad和dealloc信息
#define LogViewDidLoadAndDealloc

// 显示fps
#define LogShowFPS

//打印networking return data
#define LogNetworkReturn

//切换账号
#define SwitchAccount

#endif
