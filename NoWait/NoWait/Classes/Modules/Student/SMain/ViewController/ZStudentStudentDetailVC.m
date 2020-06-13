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


@interface ZStudentStudentDetailVC ()
@property (nonatomic,strong) ZOriganizationStudentAddModel *addModel;

@end

@implementation ZStudentStudentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_block_setRefreshHeaderNet(^{
        self.loading = YES;
        [ZOriganizationStudentViewModel getStoresStudentDetail:@{@"student_id":SafeStr(self.student_id),@"stores_id":SafeStr(self.stores_id)} completeBlock:^(BOOL isSuccess, ZOriganizationStudentAddModel *addModel) {
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
        if (!self.addModel) {
            return;
        }
        ZCellConfig *infoCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStudentInfoDesCell className] title:[ZStudentStudentInfoDesCell className] showInfoMethod:@selector(setAddModel:) heightOfCell:[ZStudentStudentInfoDesCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.addModel];
        [self.cellConfigArr addObject:infoCellConfig];

        ZCellConfig *descTitleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"学员介绍"];
        [self.cellConfigArr addObject:descTitleCellConfig];
        
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"desc");
        model.zz_titleLeft(self.addModel.specialty_desc);
        model.zz_leftMultiLine(YES);
        model.zz_cellHeight(CGFloatIn750(62));
        
        ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr  addObject:desCellConfig];
        
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
        ZCellConfig *imageTitleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"学员相册"];
        [self.cellConfigArr addObject:imageTitleCellConfig];
            
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        ZCellConfig *imageCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentImageCollectionCell className] title:[ZStudentImageCollectionCell className] showInfoMethod:@selector(setImages:) heightOfCell:[ZStudentImageCollectionCell z_getCellHeight:self.addModel.images_list] cellType:ZCellTypeClass dataModel:self.addModel.images_list];
        [self.cellConfigArr addObject:imageCellConfig];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentImageCollectionCell"]){
            ZStudentImageCollectionCell *lcell = (ZStudentImageCollectionCell *)cell;
            lcell.menuBlock = ^(NSInteger index) {
                [[ZPhotoManager sharedManager] showBrowser:weakSelf.addModel.images_list withIndex:index];
            };
        }
    });
    
    self.zChain_reload_Net();
}
@end
