//
//  ZStudentMineSettingSafeVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingSafeVC.h"
#import "ZStudentDetailModel.h"

#import "ZAccountChangePasswordVC.h"
#import "ZAccountChangePhoneVC.h"

@interface ZStudentMineSettingSafeVC ()
@end
@implementation ZStudentMineSettingSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenNaviBar = NO;
    
    __weak typeof(self) weakSelf = self;
    
    self.zChain_setNavTitle(@"账号与安全").zChain_setTableViewGary();
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        NSArray <NSArray *>*titleArr = @[@[@"修改密码", @"rightBlackArrowN", @"已设置",@"changePassword"]];
        for (int i = 0; i < titleArr.count; i++) {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(titleArr[i][3])
            .zz_titleLeft(titleArr[i][0])
            .zz_imageRight(titleArr[i][1])
            .zz_titleRight(titleArr[i][2])
            .zz_fontLeft([UIFont fontContent])
            .zz_cellHeight(CGFloatIn750(110))
            .zz_lineHidden(NO)
            .zz_imageRightHeight(CGFloatIn750(14));
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr addObject:menuCellConfig];
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"changePassword"]) {
            ZAccountChangePasswordVC *pvc = [[ZAccountChangePasswordVC alloc] init];
            [weakSelf.navigationController pushViewController:pvc animated:YES];
        }
    });
    
    self.zChain_reload_ui();
}
@end

#pragma mark - RouteHandler
@interface ZStudentMineSettingSafeVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentMineSettingSafeVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_settingSafe;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentMineSettingSafeVC *routevc = [[ZStudentMineSettingSafeVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
