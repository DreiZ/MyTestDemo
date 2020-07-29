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

#import "ZAlertView.h"
#import "ZWebBridgeViewController.h"

#import "ZOriganizationModel.h"

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

+ (void)pushToVC:(ZAdverListModel *)model {
    if (![model isKindOfClass:[ZAdverListModel class]]) {
        return;
    }
    
//    广告类型：1：课程 2：校区 3：URL 4：固定页面
    if (model && model.ad_type) {
        if ([model.ad_type isEqualToString:@"3"] && model.ad_type_content) {
            ZWebBridgeViewController *wvc = [[ZWebBridgeViewController alloc] init];
            wvc.url = model.ad_type_content.url;
            wvc.navTitle = model.name;
            [[[AppDelegate shareAppDelegate] getCurrentUIVC].navigationController pushViewController:wvc animated:YES];
        }else if ([model.ad_type isEqualToString:@"1"] && model.ad_type_content) {
            ZOriganizationLessonListModel *listModel = [[ZOriganizationLessonListModel alloc] init];
            listModel.lessonID = model.ad_type_content.course;
            
            routePushVC(ZRoute_main_orderLessonDetail, listModel, nil);
        }else if ([model.ad_type isEqualToString:@"2"] && model.ad_type_content) {
            ZStoresListModel *lmodel = [[ZStoresListModel alloc] init];
            lmodel.stores_id = model.ad_type_content.stores;
            
            routePushVC(ZRoute_main_organizationDetail, lmodel, nil);

        }else if ([model.ad_type isEqualToString:@"4"] && model.ad_type_content) {
            if ([model.ad_type_content.fix isEqualToString:@"reward_center"]) {
                [[ZUserHelper sharedHelper] checkLogin:^{
                    if ([[ZUserHelper sharedHelper].user.type intValue] == 2) {
                        
                    }else{
                        routePushVC(ZRoute_mine_rewardCenter, nil, nil);
                    }
                }];
            }
        }
    }
}
@end
