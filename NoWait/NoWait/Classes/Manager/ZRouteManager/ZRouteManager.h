//
//  ZRouteManager.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2019/1/4.
//  Copyright © 2019 承希-开发. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZBaseNetworkBannerModel;

@interface ZRouteManager : NSObject
+ (void)pushToVC:(ZBaseNetworkBannerModel *)model;
@end

