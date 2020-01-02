//
//  ZNavigationController.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/26.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 导航控制器基类
 */
@interface ZNavigationController : UINavigationController
/*!
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;


@end


