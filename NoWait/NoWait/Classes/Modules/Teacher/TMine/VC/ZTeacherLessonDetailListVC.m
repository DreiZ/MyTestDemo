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

@end

@implementation ZTeacherLessonDetailListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.loading = YES;
    [self initCellConfigArr];
    [self.iCollectionView reloadData];
}


- (void)setDataSource {
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    [super setDataSource];
    
    self.edgeInsets = UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(24), CGFloatIn750(20), CGFloatIn750(24));
    self.minimumLineSpacing = CGFloatIn750(10);
    self.minimumInteritemSpacing = CGFloatIn750(10);
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
    for (int i = 0; i < 30; i++) {
        ZOriganizationLessonListModel *limo = [[ZOriganizationLessonListModel alloc] init];
        limo.time = @"11:21~12:12";
        limo.course_name = @"感受感受";
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZLessonTimeTableCollectionCell className] title:[ZLessonTimeTableCollectionCell className] showInfoMethod:@selector(setModel:) sizeOfCell:CGSizeMake((KScreenWidth - CGFloatIn750(76) - CGFloatIn750(30) - CGFloatIn750(60))/7.0f, (KScreenWidth - CGFloatIn750(76) - CGFloatIn750(30) - CGFloatIn750(60))/7.0f) cellType:ZCellTypeClass dataModel:limo];
        [self.cellConfigArr addObject:cellConfig];
    }

}

#pragma mark - view
-(ZLessonWeekHandlerView *)weekTitleView {
    if (!_weekTitleView) {
        _weekTitleView = [[ZLessonWeekHandlerView alloc] init];
        _weekTitleView.handleBlock = ^(NSInteger index) {
            
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

- (void)refreshCurriculumList {
    NSMutableDictionary *param = @{@"is_today":@"0"}.mutableCopy;
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getCurriculumList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonScheduleListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iCollectionView reloadData];
        }else{
            [weakSelf.iCollectionView reloadData];
        }
    }];
}
@end

