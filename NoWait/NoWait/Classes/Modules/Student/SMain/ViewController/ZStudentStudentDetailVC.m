//
//  ZStudentStudentDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStudentDetailVC.h"
#import "ZStudentStudentInfoDesCell.h"
#import "ZStudentCoachInfoTitleCell.h"
#import "ZStudentImageCollectionCell.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZOrganizationNoDataCell.h"

@interface ZStudentStudentDetailVC ()
@property (nonatomic,strong) ZOriganizationStudentAddModel *addModel;

@end

@implementation ZStudentStudentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_block_setRefreshHeaderNet(^{
        weakSelf.loading = YES;
        [ZOriganizationStudentViewModel getStoresStudentDetail:@{@"student_id":SafeStr(weakSelf.student_id),@"stores_id":SafeStr(weakSelf.stores_id)} completeBlock:^(BOOL isSuccess, ZOriganizationStudentAddModel *addModel) {
            weakSelf.loading = NO;
            if (isSuccess) {
                weakSelf.addModel = addModel;
                
                weakSelf.zChain_reload_ui();
            }
        }];
    });
    
    self.zChain_setNavTitle(@"学员详情");
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        if (!weakSelf.addModel) {
            return;
        }
        ZCellConfig *infoCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStudentInfoDesCell className] title:[ZStudentStudentInfoDesCell className] showInfoMethod:@selector(setAddModel:) heightOfCell:[ZStudentStudentInfoDesCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:weakSelf.addModel];
        [weakSelf.cellConfigArr addObject:infoCellConfig];

        ZCellConfig *descTitleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"学员简介"];
        [weakSelf.cellConfigArr addObject:descTitleCellConfig];
        
        if (ValidStr(weakSelf.addModel.specialty_desc)) {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"desc");
            model.zz_titleLeft(weakSelf.addModel.specialty_desc);
            model.zz_leftMultiLine(YES);
            model.zz_cellHeight(CGFloatIn750(62));
            
            ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr  addObject:desCellConfig];
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
        }else{
            ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"4"];
            [weakSelf.cellConfigArr addObject:coachCellConfig];
        }
        
        ZCellConfig *imageTitleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"学员相册"];
        [weakSelf.cellConfigArr addObject:imageTitleCellConfig];
        
        if (ValidArray(weakSelf.addModel.images_list)) {
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            ZCellConfig *imageCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentImageCollectionCell className] title:[ZStudentImageCollectionCell className] showInfoMethod:@selector(setImages:) heightOfCell:[ZStudentImageCollectionCell z_getCellHeight:weakSelf.addModel.images_list] cellType:ZCellTypeClass dataModel:weakSelf.addModel.images_list];
            [weakSelf.cellConfigArr addObject:imageCellConfig];
        }else{
            ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"5"];
            [weakSelf.cellConfigArr addObject:coachCellConfig];
        }
        
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentImageCollectionCell"]){
            ZStudentImageCollectionCell *lcell = (ZStudentImageCollectionCell *)cell;
            lcell.menuBlock = ^(NSInteger index) {
                [[ZImagePickerManager sharedManager] showBrowser:weakSelf.addModel.images_list withIndex:index];
            };
        }
    });
    
    self.zChain_reload_Net();
}
@end

#pragma mark - RouteHandler
@interface ZStudentStudentDetailVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentStudentDetailVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_main_studentDetail;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentStudentDetailVC *routevc = [[ZStudentStudentDetailVC alloc] init];
    if (request.prts) {
        routevc.student_id = request.prts;
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
