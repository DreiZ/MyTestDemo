//
//  ZOrganizationLessonDetailListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonDetailListVC.h"
#import "ZOriganizationLessonViewModel.h"
#import "ZLessonTimeTableCollectionCell.h"
#import "ZLessonWeekHandlerView.h"
#import "ZLessonWeekSectionView.h"

#import "ZOriganizationTeacherViewModel.h"

#import "ZOriganizationModel.h"
#import "ZAlertStoresTeacherCheckBoxView.h"

@interface ZOrganizationLessonDetailListVC ()

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) ZLessonWeekHandlerView *weekTitleView;
@property (nonatomic,strong) ZLessonWeekSectionView *sectionView;
@property (nonatomic,strong) ZOriganizationLessonWeekListNetModel *model;
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) ZOriganizationTeacherListModel *listModel;
@end

@implementation ZOrganizationLessonDetailListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshCurriculumList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.loading = YES;
    self.index = 1;
    [self refreshData];
    [self setCollectionViewEmptyDataDelegate];
    [self initCellConfigArr];
    [self.iCollectionView reloadData];
}


- (void)setDataSource {
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    [super setDataSource];
    
    self.edgeInsets = UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(10), CGFloatIn750(20), CGFloatIn750(10));
    self.minimumLineSpacing = CGFloatIn750(8);
    self.minimumInteritemSpacing = CGFloatIn750(8);
    self.iCollectionView.scrollEnabled = YES;
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"本周课表"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.weekTitleView];
    [self.weekTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(94));
    }];
    
    
    [self.view addSubview:self.sectionView];
    [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weekTitleView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(92));
    }];
    
    [self.iCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.sectionView.mas_bottom);
    }];
    
    self.sectionView.date = [NSDate new];
    
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    __block NSInteger max = 0;
    [self.model.list enumerateObjectsUsingBlock:^(ZOriganizationLessonDayListNetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.list.count > max) {
            max = obj.list.count;
        }
    }];
    
    for (int i = 0; i < max; i++) {
        for (int j = 0; j < self.model.list.count; j++) {
            ZOriganizationLessonDayListNetModel *model = self.model.list[j];
            if (model.list.count > i) {
                ZOriganizationLessonListModel *listModel = model.list[i];
                ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZLessonTimeTableCollectionCell className] title:[ZLessonTimeTableCollectionCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[ZLessonTimeTableCollectionCell z_getCellSize:nil] cellType:ZCellTypeClass dataModel:listModel];
                
                [self.cellConfigArr addObject:cellConfig];
            }else{
                ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZLessonTimeTableCollectionCell className] title:[ZLessonTimeTableCollectionCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[ZLessonTimeTableCollectionCell z_getCellSize:nil] cellType:ZCellTypeClass dataModel:nil];
                [self.cellConfigArr addObject:cellConfig];
            }
        }
    }
    
    self.sectionView.date = [NSDate dateWithDaysFromNow:self.index * 7];
    self.weekTitleView.index = self.index;
}

#pragma mark - view
-(ZLessonWeekHandlerView *)weekTitleView {
    if (!_weekTitleView) {
        __weak typeof(self) weakSelf = self;
        _weekTitleView = [[ZLessonWeekHandlerView alloc] init];
        _weekTitleView.isOrganization = YES;
        _weekTitleView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                weakSelf.index --;
            }else{
                weakSelf.index++;
            }
            [weakSelf refreshCurriculumList];
        };
        
        _weekTitleView.moreBlock = ^(NSInteger index) {
            [ZAlertStoresTeacherCheckBoxView setAlertName:@"选择教师" stores_id:[ZUserHelper sharedHelper].school.schoolID handlerBlock:^(NSInteger index,ZOriganizationTeacherListModel *model) {
                if (model) {
                    weakSelf.listModel = model;
                    weakSelf.weekTitleView.title = weakSelf.listModel.teacher_name;
                    [weakSelf refreshCurriculumList];
                }
            }];
        };
    }
    return _weekTitleView;
}

- (ZLessonWeekSectionView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[ZLessonWeekSectionView alloc] init];
    }
    return _sectionView;
}

#pragma mark - tableview delegate
- (void)zz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([[ZUserHelper sharedHelper].user.type intValue] == 1) {
        ZOriganizationLessonListModel *model = cellConfig.dataModel;
        if (model) {
            routePushVC(ZRoute_mine_signDetail, @{@"courses_class_id":SafeStr(model.courses_class_id), @"student_id":SafeStr(model.student_id)}, nil);
        }
    }else{
        ZOriganizationLessonListModel *model = cellConfig.dataModel;
        if (model) {
            routePushVC(ZRoute_mine_teacherClassDetail, @{@"id":SafeStr(model.courses_class_id)}, nil);
        }
    }
    
}

- (void)refreshCurriculumList {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:[NSString stringWithFormat:@"%ld",self.index] forKey:@"week_page"];
    if (ValidStr(self.listModel.teacherID)) {
        [param setObject:SafeStr(self.listModel.teacherID) forKey:@"teacher_id"];
    }
    NSLog(@"-----%@",param);
    [ZOriganizationLessonViewModel getWeekCurriculumList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonWeekListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            weakSelf.model = data;
            [weakSelf initCellConfigArr];
            [weakSelf.iCollectionView reloadData];
        }else{
            [weakSelf.iCollectionView reloadData];
        }
    }];
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationTeacherViewModel getTeacherList:param completeBlock:^(BOOL isSuccess, ZOriganizationTeacherListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data && data.list && data.list.count > 0) {
            weakSelf.listModel = data.list[0];
            [weakSelf refreshCurriculumList];
            weakSelf.weekTitleView.title = weakSelf.listModel.teacher_name;
        }else{
            weakSelf.weekTitleView.title = @"暂无教师";
        }
    }];
}

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    [param setObject:[ZUserHelper sharedHelper].school.schoolID forKey:@"stores_id"];
//       [param setObject:@"0" forKey:@"status"];
    return param;
}

@end

#pragma mark - RouteHandler
@interface ZOrganizationLessonDetailListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationLessonDetailListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_lessonList;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationLessonDetailListVC *routevc = [[ZOrganizationLessonDetailListVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
