//
//  ZMineSwitchRoleVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/29.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineSwitchRoleVC.h"
#import "ZStudentMineSettingSwitchUserCell.h"

#import "ZStudentMineSwitchAccountLoginVC.h"
#import "ZLoginViewModel.h"

@interface ZMineSwitchRoleVC ()

@end

@implementation ZMineSwitchRoleVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"切换身份")
    .zChain_block_setRefreshHeaderNet(^{
        [ZLoginViewModel getUserRolesWithBlock:^(BOOL isSuccess, ZUserRolesListNetModel *data) {
            if (isSuccess && data) {
                [weakSelf.dataSources removeAllObjects];
                [weakSelf.dataSources addObjectsFromArray:data.list];
                if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
                
            }
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        ZLineCellModel *titleModel = ZLineCellModel.zz_lineCellModel_create(@"title");
        titleModel.zz_titleLeft(@"切换身份")
        .zz_fontLeft([UIFont boldSystemFontOfSize:CGFloatIn750(52)])
        .zz_marginLeft(CGFloatIn750(50))
        .zz_cellHeight(CGFloatIn750(126))
        .zz_lineHidden(YES);
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:titleModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:titleModel] cellType:ZCellTypeClass dataModel:titleModel];
        [weakSelf.cellConfigArr addObject:titleCellConfig];
        
        for (int i = 0; i < weakSelf.dataSources.count; i++) {
            ZUserRolesListModel *user = weakSelf.dataSources[i];
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.cellTitle = @"user";
            if ([user.type isEqualToString:[ZUserHelper sharedHelper].user.type]) {
                model.isSelected = YES;
            }else{
                model.isSelected = NO;
            }
            model.data = weakSelf.dataSources[i];
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingSwitchUserCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineSettingSwitchUserCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr addObject:menuCellConfig];
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"user"]){
             ZBaseSingleCellModel *cellModel = (ZBaseSingleCellModel *)cellConfig.dataModel;
            
            ZUserRolesListModel *user = cellModel.data;
            if (![user.type isEqualToString:[ZUserHelper sharedHelper].user.type]) {
                ZStudentMineSwitchAccountLoginVC *lvc = [[ZStudentMineSwitchAccountLoginVC alloc] init];
                lvc.model = cellModel.data;
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            }
        }
    });
    
    self.zChain_reload_ui();
}


#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    self.zChain_reload_ui();
}
@end

#pragma mark - RouteHandler
@interface ZMineSwitchRoleVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZMineSwitchRoleVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_switchRole;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZMineSwitchRoleVC *routevc = [[ZMineSwitchRoleVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
