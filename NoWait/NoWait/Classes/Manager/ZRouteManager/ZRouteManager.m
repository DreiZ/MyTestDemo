//
//  ZRouteManager.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2019/1/4.
//  Copyright © 2019 zhuang zhang. All rights reserved.
//

#import "ZRouteManager.h"
#import "ZBaseNetworkBackModel.h"
#import "AppDelegate+AppService.h"
#import "ZWebBridgeViewController.h"

static ZRouteManager *sharedManager;

@interface ZRouteManager ()

@end

@implementation ZRouteManager

+ (ZRouteManager *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZRouteManager alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

+ (void)pushToVC:(ZBaseNetworkBannerModel *)model {
    if (![model isKindOfClass:[ZBaseNetworkBannerModel class]]) {
        return;
    }
    if (model && model.drive) {
        if ([model.drive isEqualToString:@"url"] && model.directive) {
            ZWebBridgeViewController *wvc = [[ZWebBridgeViewController alloc] init];
            wvc.url = model.directive;
            [[[AppDelegate shareAppDelegate] getCurrentUIVC].navigationController pushViewController:wvc animated:YES];
        }
    }
}
@end
