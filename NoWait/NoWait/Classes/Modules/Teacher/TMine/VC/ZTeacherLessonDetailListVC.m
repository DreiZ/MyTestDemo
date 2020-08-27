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
#import "ZStudentAddOutlineClassVC.h"
#import "ZAlertView.h"
#import "ZOriganizationTeachingScheduleViewModel.h"

@interface ZTeacherLessonDetailListVC ()
@property (nonatomic,strong) UIButton *rightNavBtn;

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
    if ([[ZUserHelper sharedHelper].user.type isEqualToString:@"1"]) {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn]];
    }
}

- (UIButton *)rightNavBtn {
    if (!_rightNavBtn) {
//        __weak typeof(self) weakSelf = self;
        _rightNavBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(120), CGFloatIn750(50))];
        [_rightNavBtn setTitle:@"添加课程" forState:UIControlStateNormal];
        [_rightNavBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_rightNavBtn.titleLabel setFont:[UIFont fontMin]];
        _rightNavBtn.backgroundColor = [UIColor colorMain];
        _rightNavBtn.layer.cornerRadius = CGFloatIn750(25);
        [_rightNavBtn bk_addEventHandler:^(id sender) {
            ZStudentAddOutlineClassVC *cvc = [[ZStudentAddOutlineClassVC alloc] init];
            [self.navigationController pushViewController:cvc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightNavBtn;
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
- (void)zz_collectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZLessonTimeTableCollectionCell"]) {
        ZLessonTimeTableCollectionCell *lcell = (ZLessonTimeTableCollectionCell *)cell;
        lcell.handleBlock = ^(ZOriganizationLessonListModel * model) {
            [ZAlertView setAlertWithTitle:@"小提醒" subTitle:[NSString stringWithFormat:@"将%@从课表中移除？",model.course_name] leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    [self delLessonWithID:model.note_id];
                }
            }];
        };
    }
}

- (void)zz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZLessonTimeTableCollectionCell"]) {
        if ([[ZUserHelper sharedHelper].user.type intValue] == 1) {
            ZOriganizationLessonListModel *model = cellConfig.dataModel;
            if (model) {
                routePushVC(ZRoute_mine_signDetail, @{@"courses_class_id":model.courses_class_id, @"student_id":SafeStr(model.student_id)}, nil);
            }
            
        }else{
            ZOriganizationLessonListModel *model = cellConfig.dataModel;
            if (model) {
                routePushVC(ZRoute_mine_teacherClassDetail, @{@"id":SafeStr(model.courses_class_id)}, nil);
            }
            
        }
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


- (void)delLessonWithID:(NSString *)lessonID {
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationTeachingScheduleViewModel delStudentCourseClass:@{@"note_id":SafeStr(lessonID)} completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [weakSelf refreshCurriculumList];
            [TLUIUtility showSuccessHint:message];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
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
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]] && [request.prts objectForKey:@"id"]) {
        routevc.teacher_id = request.prts[@"id"];
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
