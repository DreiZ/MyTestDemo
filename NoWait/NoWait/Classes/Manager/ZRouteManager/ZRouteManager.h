//
//  ZRouteManager.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2019/1/4.
//  Copyright © 2019 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZBaseNetworkBannerModel;

@interface ZRouteManager : NSObject
+ (void)pushToVC:(ZBaseNetworkBannerModel *)model;
@end

