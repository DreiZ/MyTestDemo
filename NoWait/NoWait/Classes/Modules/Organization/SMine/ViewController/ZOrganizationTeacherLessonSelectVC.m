//
//  ZOrganizationTeacherLessonSelectVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeacherLessonSelectVC.h"
#import "ZOrganizationTeacherLessonSelectCell.h"
#import "ZOriganizationLessonViewModel.h"

@interface ZOrganizationTeacherLessonSelectVC ()
@property (nonatomic,strong) UIButton *navRightBtn;
@property (nonatomic,strong) UIButton *navLeftBtn;

@end

@implementation ZOrganizationTeacherLessonSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self refreshData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    for (int i = 0; i < self.dataSources.count; i++) {
        [self checkModel:self.dataSources[i]];
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTeacherLessonSelectCell className] title:[ZOrganizationTeacherLessonSelectCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationTeacherLessonSelectCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:progressCellConfig];
    }
}

- (void)checkModel:(ZOriganizationLessonListModel *)model {
    if (ValidArray(self.lessonList)) {
        for (ZOriganizationLessonListModel *tmodel in self.lessonList) {
            if ([tmodel.lessonID isEqualToString:model.lessonID]) {
                model.teacherPirce = tmodel.teacherPirce;
                model.isSelected = YES;
            }
        }
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"课程选择"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]];
}

#pragma mark lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontContent]];
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}

- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        __weak typeof(self) weakSelf = self;
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        _navRightBtn.layer.masksToBounds = YES;
        _navRightBtn.layer.cornerRadius = CGFloatIn750(25);
        _navRightBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_navRightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont fontSmall]];
        [_navRightBtn bk_addEventHandler:^(id sender) {
            NSMutableArray *temp = [weakSelf getSelect];
            if (temp && temp.count > 0) {
                if (weakSelf.handleBlock) {
                    weakSelf.handleBlock(temp, YES);
                }
                for (int i = 0; i < temp.count; i++) {
                    ZOriganizationLessonListModel *model = temp[i];
                    if (ValidStr(model.teacherPirce) && [model.teacherPirce doubleValue] < 1) {
                        [TLUIUtility showInfoHint:@"教师带课价格不可小于1元"];
                        return;
                    }
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [TLUIUtility showErrorHint:@"您还没有选择课程"];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navRightBtn;
}
#pragma mark - tableview delegate
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOrganizationTeacherLessonSelectCell"]) {
        ZOriganizationLessonListModel *model;
        for (int i = 0; i < self.dataSources.count; i++) {
            if (indexPath.row == i) {
                model = self.dataSources[i];
            }
        }
        
        ZOrganizationTeacherLessonSelectCell *lcell = (ZOrganizationTeacherLessonSelectCell *)cell;
        lcell.handleBlock = ^(NSString *text) {
            model.teacherPirce = text;
        };
        
        lcell.selectedBlock = ^{
            ZOriganizationLessonListModel *model;
            for (int i = 0; i < weakSelf.dataSources.count; i++) {
                if (indexPath.row == i) {
                    model = weakSelf.dataSources[i];
                }
            }
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
//    __weak typeof(self) weakSelf = self;
//    if ([cellConfig.title isEqualToString:@"ZOrganizationTeacherLessonSelectCell"]) {
//
//    }
}


- (NSMutableArray<ZOriganizationLessonListModel *> *)getSelect{
    NSMutableArray *list = @[].mutableCopy;
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationLessonListModel *model = self.dataSources[i];
        if (model.isSelected) {
            [list addObject:model];
        }
    }
    return list;
}
//
//- (void)handleAll{
//    if ([self getSelect].count == self.dataSources.count) {
//        for (int i = 0; i < self.dataSources.count; i++) {
//            ZOriganizationStudentListModel *model = self.dataSources[i];
//            model.isSelected = NO;
//        }
//        [self.navLeftBtn setTitle:@"全选" forState:UIControlStateNormal];
//    }else{
//        for (int i = 0; i < self.dataSources.count; i++) {
//            ZOriganizationStudentListModel *model = self.dataSources[i];
//            model.isSelected = YES;
//        }
//        [self.navLeftBtn setTitle:@"全不选" forState:UIControlStateNormal];
//    }
//
//    [self initCellConfigArr];
//    [self.iTableView reloadData];
//}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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


- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
       [param setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
       [param setObject:@"0" forKey:@"status"];
    return param;
}
@end
