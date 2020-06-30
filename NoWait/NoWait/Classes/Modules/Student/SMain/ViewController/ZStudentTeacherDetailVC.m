//
//  ZStudentTeacherDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentTeacherDetailVC.h"
#import "ZStudentCoachInfoDesCell.h"
#import "ZStudentCoachInfoTitleCell.h"
#import "ZStudentEvaListCell.h"
#import "ZStudentDetailEvaAboutCell.h"
#import "ZStudentOrganizationLessonListCell.h"
#import "ZStudentImageCollectionCell.h"
#import "ZOrganizationNoDataCell.h"

#import "ZOriganizationTeacherViewModel.h"
#import "ZOriganizationModel.h"
#import "ZStudentMineModel.h"
#import "ZOriganizationOrderViewModel.h"

#import "ZStudentExperienceLessonDetailVC.h"
#import "ZStudentTeacherDetailEvaListVC.h"

@interface ZStudentTeacherDetailVC ()
@property (nonatomic,strong) ZOriganizationTeacherAddModel *detailModel;

@end

@implementation ZStudentTeacherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"教师详情")
    .zChain_updateDataSource(^{
        self.loading = YES;
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        if (!self.detailModel) {
            return;
        }
        ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoDesCell className] title:[ZStudentCoachInfoDesCell className] showInfoMethod:@selector(setDetailModel:) heightOfCell:[ZStudentCoachInfoDesCell z_getCellHeight:self.detailModel] cellType:ZCellTypeClass dataModel:self.detailModel];
        [self.cellConfigArr addObject:desCellConfig];

        ZCellConfig *infoTitleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"教师简介"];
        [self.cellConfigArr addObject:infoTitleCellConfig];
        
        if (ValidStr(self.detailModel.des)) {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"desc");
            model.zz_titleLeft(self.detailModel.des);
            model.zz_leftMultiLine(YES);
            model.zz_cellHeight(CGFloatIn750(62));
            
            ZCellConfig *infoCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr  addObject:infoCellConfig];
            
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
        }else{
            ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"4"];
            [self.cellConfigArr addObject:coachCellConfig];
        }
        
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"教师评价"];
        [self.cellConfigArr addObject:titleCellConfig];
        if (self.detailModel.comment_list && self.detailModel.comment_list.count > 0) {
            NSMutableArray *configArr = @[].mutableCopy;
            for (ZOrderEvaListModel *evaModel in self.detailModel.comment_list) {
                evaModel.isTeacher = YES;
                ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaListCell className] title:[ZStudentEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentEvaListCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
                [configArr addObject:evaCellConfig];
            }
            
            
            ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentDetailEvaAboutCell className] title:[ZStudentDetailEvaAboutCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZStudentDetailEvaAboutCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
            [self.cellConfigArr addObject:bottomCellConfig];
        }else{
            ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"3"];
            [self.cellConfigArr addObject:coachCellConfig];
        }
        
        if (self.detailModel.class_ids) {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
            
            ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"教师带课"];
            [self.cellConfigArr addObject:titleCellConfig];
            
            if (ValidArray(self.detailModel.class_ids)) {
                for (int i = 0; i < self.detailModel.class_ids.count; i++) {
                    ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationLessonListCell className] title:[ZStudentOrganizationLessonListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationLessonListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.detailModel.class_ids[i]];
                    [self.cellConfigArr addObject:lessonCellConfig];
                }
            }else{
                ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"1"];
                [self.cellConfigArr addObject:coachCellConfig];
            }
            
        }
        if (self.detailModel.images_list) {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
            
            ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"教师相册"];
            [self.cellConfigArr addObject:titleCellConfig];
            
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            
            if (ValidArray(self.detailModel.images_list)) {
                ZCellConfig *imagesCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentImageCollectionCell className] title:[ZStudentImageCollectionCell className] showInfoMethod:@selector(setImages:) heightOfCell:[ZStudentImageCollectionCell z_getCellHeight:self.detailModel.images_list] cellType:ZCellTypeClass dataModel:self.detailModel.images_list];
                [self.cellConfigArr addObject:imagesCellConfig];
            }else{
                ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"5"];
                [self.cellConfigArr addObject:coachCellConfig];
            }
        }
    }).zChain_block_setRefreshHeaderNet(^{
        self.loading = YES;
        [ZOriganizationTeacherViewModel getStTeacherDetail:@{@"stores_id":SafeStr(self.stores_id),@"teacher_id":SafeStr(self.teacher_id)} completeBlock:^(BOOL isSuccess, ZOriganizationTeacherAddModel *addModel) {
            weakSelf.loading = NO;
            if (isSuccess) {
                weakSelf.detailModel = addModel;
                
                weakSelf.zChain_reload_ui();
            }
        }];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentImageCollectionCell"]){
            ZStudentImageCollectionCell *lcell = (ZStudentImageCollectionCell *)cell;
            lcell.menuBlock = ^(NSInteger index) {
                [[ZImagePickerManager sharedManager] showBrowser:weakSelf.detailModel.images_list withIndex:index];
            };
        }else if ([cellConfig.title isEqualToString:@"ZStudentDetailEvaAboutCell"]){
            ZStudentDetailEvaAboutCell *lcell = (ZStudentDetailEvaAboutCell *)cell;
            lcell.handleBlock = ^(ZCellConfig *cellconfig) {
                ZStudentTeacherDetailEvaListVC *evc = [[ZStudentTeacherDetailEvaListVC alloc] init];
                evc.stores_id = weakSelf.stores_id;
                evc.teacher_id = weakSelf.teacher_id;
                evc.teacher_name = weakSelf.detailModel.nick_name;
                [weakSelf.navigationController pushViewController:evc animated:YES];
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]){
            ZOriganizationLessonListModel *model = cellConfig.dataModel;
            ZStudentExperienceLessonDetailVC *dvc = [[ZStudentExperienceLessonDetailVC alloc] init];
            model.lessonID = model.courses_id;
            dvc.model = model;
            [self.navigationController pushViewController:dvc animated:YES];
        }
    });
    
    self.zChain_reload_Net();
}

@end
