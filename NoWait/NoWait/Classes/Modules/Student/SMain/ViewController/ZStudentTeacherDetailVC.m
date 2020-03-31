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
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZStudentEvaListCell.h"
#import "ZStudentDetailEvaAboutCell.h"
#import "ZStudentOrganizationLessonListCell.h"
#import "ZStudentImageCollectionCell.h"
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
    
    [self refreshInfoData];
    [self refreshData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    if (!self.detailModel) {
        return;
    }
    ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoDesCell className] title:[ZStudentCoachInfoDesCell className] showInfoMethod:@selector(setDetailModel:) heightOfCell:[ZStudentCoachInfoDesCell z_getCellHeight:self.detailModel] cellType:ZCellTypeClass dataModel:self.detailModel];
    [self.cellConfigArr addObject:desCellConfig];

    {
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"教练简介"];
        [self.cellConfigArr addObject:titleCellConfig];
        
    }
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = self.detailModel.des;
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth;
        model.singleCellHeight = CGFloatIn750(60);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.leftContentSpace = CGFloatIn750(0);
        model.rightContentSpace = CGFloatIn750(0);
        model.cellHeight = CGFloatIn750(62);
        model.rightFont = [UIFont fontContent];
        model.rightColor = [UIColor colorTextBlack];
        model.rightDarkColor =  [UIColor colorTextBlackDark];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    
    if (self.dataSources && self.dataSources.count > 0) {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"教练评价"];
        [self.cellConfigArr addObject:titleCellConfig];
        
        NSMutableArray *configArr = @[].mutableCopy;
        for (ZOrderEvaListModel *evaModel in self.dataSources) {
            ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaListCell className] title:[ZStudentEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentEvaListCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
            [configArr addObject:evaCellConfig];
        }
        
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentDetailEvaAboutCell className] title:[ZStudentDetailEvaAboutCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZStudentDetailEvaAboutCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
        [self.cellConfigArr addObject:bottomCellConfig];
    }
    
    if (self.detailModel.class_ids && self.detailModel.class_ids.count > 0) {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"老师带课"];
        [self.cellConfigArr addObject:titleCellConfig];
        
        for (int i = 0; i < self.detailModel.class_ids.count; i++) {
            ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationLessonListCell className] title:[ZStudentOrganizationLessonListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationLessonListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.detailModel.class_ids[i]];
            [self.cellConfigArr addObject:lessonCellConfig];
        }
    }
    if (self.detailModel.images_list && self.detailModel.images_list.count > 0) {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"教练相册"];
        [self.cellConfigArr addObject:titleCellConfig];
        
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        
        ZCellConfig *imagesCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentImageCollectionCell className] title:[ZStudentImageCollectionCell className] showInfoMethod:@selector(setImages:) heightOfCell:[ZStudentImageCollectionCell z_getCellHeight:self.detailModel.images_list] cellType:ZCellTypeClass dataModel:self.detailModel.images_list];
        [self.cellConfigArr addObject:imagesCellConfig];
    }
    
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"教师详情"];
}


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig
{
    
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZStudentImageCollectionCell"]){
        ZStudentImageCollectionCell *lcell = (ZStudentImageCollectionCell *)cell;
        lcell.menuBlock = ^(NSInteger index) {
            NSArray *stemparr = @[@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd18jm09cuj30u017x7wh.jpg",
              @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gd18eptwlij318z0u0198.jpg",
              @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gd17vgbvgfj30u011eq9i.jpg",
            @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gd17qv01jnj30u01927az.jpg",
            @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd17mjs214j30rs15o4qp.jpg",
            @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd17hdmtn9j30u0142ang.jpg",
            @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gd17c994y0j30u011ignb.jpg",
            @"http://wx2.sinaimg.cn/mw600/007erPXFgy1gcei2kksvkj30rs15o1kx.jpg",
            @"http://wx3.sinaimg.cn/mw600/44f2ef1bgy1gd1746o74cj20ku0q1gqz.jpg"
            ];
            [[ZPhotoManager sharedManager] showBrowser:stemparr withIndex:2];
        };
    }else if ([cellConfig.title isEqualToString:@"ZStudentDetailEvaAboutCell"]){
        ZStudentDetailEvaAboutCell *lcell = (ZStudentDetailEvaAboutCell *)cell;
        lcell.handleBlock = ^(ZCellConfig *cellconfig) {
            [weakSelf refreshMoreData];
        };
    }
//    else if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailIntroCell"]){
//        ZStudentOrganizationDetailIntroCell *lcell = (ZStudentOrganizationDetailIntroCell *)cell;
//        lcell.handleBlock = ^(NSInteger index) {
//            if (index == 1) {
//                ZStudentOrganizationMapAddressVC *avc = [[ZStudentOrganizationMapAddressVC alloc] init];
//                [weakSelf.navigationController pushViewController:avc animated:YES];
//            }else if (index == 2){
//                [ZOrganizationCouponListView setAlertWithTitle:@"优惠" ouponList:@[] handlerBlock:^(NSInteger index) {
//
//                }];
//            }
//        };
//    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    
}


#pragma mark - refresha

- (void)refreshInfoData {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationTeacherViewModel getStTeacherDetail:@{@"stores_id":SafeStr(self.stores_id),@"teacher_id":SafeStr(self.teacher_id)} completeBlock:^(BOOL isSuccess, ZOriganizationTeacherAddModel *addModel) {
        if (isSuccess) {
            weakSelf.detailModel = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:SafeStr(self.teacher_id) forKey:@"teacher_id"];
    [param setObject:SafeStr(self.stores_id) forKey:@"stores_id"];
    [param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [param setObject:@"3" forKey:@"page_size"];
    __weak typeof(self) weakSelf = self;
    [ZOriganizationOrderViewModel getTeacherCommentListList:param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}


- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:SafeStr(self.teacher_id) forKey:@"teacher_id"];
    [param setObject:SafeStr(self.stores_id) forKey:@"stores_id"];
    [param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [param setObject:@"3" forKey:@"page_size"];
    __weak typeof(self) weakSelf = self;
    [ZOriganizationOrderViewModel getTeacherCommentListList:param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

@end

