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
        if (!weakSelf.detailModel) {
            return;
        }
        ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoDesCell className] title:[ZStudentCoachInfoDesCell className] showInfoMethod:@selector(setDetailModel:) heightOfCell:[ZStudentCoachInfoDesCell z_getCellHeight:weakSelf.detailModel] cellType:ZCellTypeClass dataModel:weakSelf.detailModel];
        [weakSelf.cellConfigArr addObject:desCellConfig];

        ZCellConfig *infoTitleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"教师简介"];
        [weakSelf.cellConfigArr addObject:infoTitleCellConfig];
        
        if (ValidStr(weakSelf.detailModel.des)) {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"desc");
            model.zz_titleLeft(weakSelf.detailModel.des);
            model.zz_leftMultiLine(YES);
            model.zz_cellHeight(CGFloatIn750(62));
            model.zz_lineHidden(YES);
            
            ZCellConfig *infoCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr  addObject:infoCellConfig];
            
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
        }else{
            ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"4"];
            [weakSelf.cellConfigArr addObject:coachCellConfig];
        }
        
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"教师评价"];
        [weakSelf.cellConfigArr addObject:titleCellConfig];
        if (weakSelf.detailModel.comment_list && weakSelf.detailModel.comment_list.count > 0) {
            NSMutableArray *configArr = @[].mutableCopy;
            for (ZOrderEvaListModel *evaModel in weakSelf.detailModel.comment_list) {
                evaModel.isTeacher = YES;
                ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaListCell className] title:[ZStudentEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentEvaListCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
                [configArr addObject:evaCellConfig];
            }
            
            
            ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentDetailEvaAboutCell className] title:[ZStudentDetailEvaAboutCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZStudentDetailEvaAboutCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
            [weakSelf.cellConfigArr addObject:bottomCellConfig];
        }else{
            ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"3"];
            [weakSelf.cellConfigArr addObject:coachCellConfig];
        }
        
        if (weakSelf.detailModel.class_ids) {
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
            
            ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"教师带课"];
            [weakSelf.cellConfigArr addObject:titleCellConfig];
            
            if (ValidArray(weakSelf.detailModel.class_ids)) {
                for (int i = 0; i < weakSelf.detailModel.class_ids.count; i++) {
                    ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationLessonListCell className] title:[ZStudentOrganizationLessonListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationLessonListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:weakSelf.detailModel.class_ids[i]];
                    [weakSelf.cellConfigArr addObject:lessonCellConfig];
                }
            }else{
                ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"1"];
                [weakSelf.cellConfigArr addObject:coachCellConfig];
            }
            
        }
        if (weakSelf.detailModel.images_list) {
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
            
            ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"教师相册"];
            [weakSelf.cellConfigArr addObject:titleCellConfig];
            
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            
            if (ValidArray(weakSelf.detailModel.images_list)) {
                ZCellConfig *imagesCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentImageCollectionCell className] title:[ZStudentImageCollectionCell className] showInfoMethod:@selector(setImages:) heightOfCell:[ZStudentImageCollectionCell z_getCellHeight:weakSelf.detailModel.images_list] cellType:ZCellTypeClass dataModel:weakSelf.detailModel.images_list];
                [weakSelf.cellConfigArr addObject:imagesCellConfig];
            }else{
                ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationNoDataCell className] title:@"ZOrganizationNoDataCell" showInfoMethod:@selector(setType:) heightOfCell:[ZOrganizationNoDataCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"5"];
                [weakSelf.cellConfigArr addObject:coachCellConfig];
            }
        }
    }).zChain_block_setRefreshHeaderNet(^{
        weakSelf.loading = YES;
        [ZOriganizationTeacherViewModel getStTeacherDetail:@{@"stores_id":SafeStr(weakSelf.stores_id),@"teacher_id":SafeStr(weakSelf.teacher_id)} completeBlock:^(BOOL isSuccess, ZOriganizationTeacherAddModel *addModel) {
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
                routePushVC(ZRoute_main_teacherEvaList, @{@"stores_id":SafeStr(weakSelf.stores_id),@"teacher_id":SafeStr(weakSelf.teacher_id),@"teacher_name":SafeStr(weakSelf.detailModel.nick_name)}, nil);
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]){
            ZOriganizationLessonListModel *model = cellConfig.dataModel;
            routePushVC(ZRoute_main_orderLessonDetail, @{@"id":model.courses_id}, nil);
        }
    });
    
    self.zChain_reload_Net();
}

@end

#pragma mark - RouteHandler
@interface ZStudentTeacherDetailVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentTeacherDetailVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_main_teacherDetail;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentTeacherDetailVC *routevc = [[ZStudentTeacherDetailVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDict = request.prts;
        if ([tempDict objectForKey:@"teacher_id"]) {
            routevc.teacher_id = tempDict[@"teacher_id"];
        }
        if ([tempDict objectForKey:@"stores_id"]) {
            routevc.stores_id = tempDict[@"stores_id"];
        }
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
