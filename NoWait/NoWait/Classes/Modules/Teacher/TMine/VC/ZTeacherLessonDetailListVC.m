//
//  ZTeacherLessonDetailListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherLessonDetailListVC.h"
#import "ZOriganizationLessonViewModel.h"
#import "ZLessonTimeTableCollectionCell.h"
#import "ZLessonWeekHandlerView.h"
#import "ZLessonWeekSectionView.h"

@interface ZTeacherLessonDetailListVC ()

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) ZLessonWeekHandlerView *weekTitleView;
@property (nonatomic,strong) ZLessonWeekSectionView *sectionView;
@property (nonatomic,strong) ZOriganizationLessonWeekListNetModel *model;
@property (nonatomic,assign) NSInteger index;
@end

@implementation ZTeacherLessonDetailListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshCurriculumList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.loading = YES;
    
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
        _weekTitleView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                weakSelf.index --;
            }else{
                weakSelf.index++;
            }
            [weakSelf refreshCurriculumList];
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
        
        routePushVC(ZRoute_mine_signDetail, @{@"courses_class_id":model.courses_class_id, @"student_id":SafeStr(model.student_id)}, nil);
    }else{
        ZOriganizationLessonListModel *model = cellConfig.dataModel;
        
        ZOriganizationClassDetailModel *detailModel = [[ZOriganizationClassDetailModel alloc] init];
        detailModel.courses_name = model.courses_name;
        detailModel.classID = model.courses_class_id;
        detailModel.name = model.name;
        detailModel.status = model.status;
        
        routePushVC(ZRoute_mine_teacherClassDetail, detailModel, nil);
    }
    
}

- (void)refreshCurriculumList {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:[NSString stringWithFormat:@"%ld",self.index] forKey:@"week_page"];
    if (ValidStr(self.teacher_id)) {
        [param setObject:SafeStr(self.teacher_id) forKey:@"teacher_id"];
    }
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

@end

#pragma mark - RouteHandler
@interface ZTeacherLessonDetailListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZTeacherLessonDetailListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_teacherDetailList;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZTeacherLessonDetailListVC *routevc = [[ZTeacherLessonDetailListVC alloc] init];
    routevc.teacher_id = request.prts;
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
