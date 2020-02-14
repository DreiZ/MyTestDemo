//
//  ZStudentOrganizationLessonDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationLessonDetailVC.h"
#import "ZVideoPlayerManager.h"
#import "ZCellConfig.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentLessonDetailMainCell.h"
#import "ZStudentLessonDetailBannerCell.h"
#import "ZStudentLessonDetailOrgazaitionNameCell.h"

#import "ZStudentLessonEvaView.h"
#import "ZStudentLessonDetailView.h"
#import "ZStudentLessonNoticeView.h"

#import "ZStudentLessonSelectMainView.h"
#import "ZMenuSelectdView.h"

#import "ZStudentLessonSureOrderVC.h"
#import "ZStudentLessonSubscribeSureOrderVC.h"

@interface ZStudentOrganizationLessonDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIScrollView *subScrollView;
@property (nonatomic,strong) ZMenuSelectdView *menuSelectedView;
@property (nonatomic,strong) UIButton *bottomBtn;

@property (nonatomic,strong) ZStudentLessonDetailView *iDetilView;
@property (nonatomic,strong) ZStudentLessonNoticeView *iNoticeView;
@property (nonatomic,strong) ZStudentLessonEvaView *iEvaView;
@property (nonatomic,strong) ZStudentLessonSelectMainView *selectView;


@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray <NSArray *>*cellConfigArr;
@end
@implementation ZStudentOrganizationLessonDetailVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self initCellConfigArr];
    [self setupMainView];
}

#pragma mark - setdata & setview
- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    {
        NSMutableArray *section1Arr = @[].mutableCopy;
        
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
        [section1Arr addObject:spacCellConfig];
        
        ZCellConfig *bannerCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailBannerCell className] title:[ZStudentLessonDetailBannerCell className] showInfoMethod:nil heightOfCell:[ZStudentLessonDetailBannerCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [section1Arr addObject:bannerCellConfig];
        
        ZCellConfig *orgCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailOrgazaitionNameCell className] title:[ZStudentLessonDetailOrgazaitionNameCell className] showInfoMethod:nil heightOfCell:[ZStudentLessonDetailOrgazaitionNameCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [section1Arr addObject:orgCellConfig];
        [section1Arr addObject:spacCellConfig];

        [self.cellConfigArr addObject:section1Arr];
    }

    {
        NSMutableArray *section2Arr = @[].mutableCopy;
        ZCellConfig *mainCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailMainCell className] title:[ZStudentLessonDetailMainCell className] showInfoMethod:nil heightOfCell:[ZStudentLessonDetailMainCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [section2Arr addObject:mainCellConfig];
        [self.cellConfigArr addObject:section2Arr];
        
        
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"课程详情"];
}

- (void)setupMainView {
    self.view.backgroundColor = KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(100));
        make.top.equalTo(self.view.mas_top).offset(1);
    }];
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(100));
    }];
}

#pragma mark -- lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.showsHorizontalScrollIndicator = NO;
        _iTableView.showsVerticalScrollIndicator = NO;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.backgroundColor = KAdaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
    }
    return _iTableView;
}


- (ZMenuSelectdView *)menuSelectedView {
    if (!_menuSelectedView) {
        __weak typeof(self) weakSelf = self;
        _menuSelectedView = [[ZMenuSelectdView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatIn750(98)) withTitleArr:@[@"详情", @"须知", @"评价"] topIndex:@"0"];
        _menuSelectedView.selectBlock = ^(NSInteger index) {
            [weakSelf.subScrollView setContentOffset:CGPointMake(KScreenWidth*index, 0)];
//            [weakSelf refreshTypeData:index];
        };
    }
    return _menuSelectedView;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"立即预约" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(38)]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            [weakSelf.selectView showSelectViewWithType:ZLessonBuyTypeBuyBeginLesson];
        }];
    }
    return _bottomBtn;
}


- (ZStudentLessonSelectMainView *)selectView {
    if (!_selectView) {
        __weak typeof(self) weakSelf = self;
        _selectView = [[ZStudentLessonSelectMainView alloc] init];
        _selectView.completeBlock = ^(ZLessonBuyType type) {
            if (type == ZLessonBuyTypeBuyInitial || type == ZLessonBuyTypeBuyBeginLesson) {
                ZStudentLessonSureOrderVC *order = [[ZStudentLessonSureOrderVC alloc] init];
                [weakSelf.navigationController pushViewController:order animated:YES];
            }else{
                ZStudentLessonSubscribeSureOrderVC *order = [[ZStudentLessonSubscribeSureOrderVC alloc] init];
                [weakSelf.navigationController pushViewController:order animated:YES];
            }
        };
    }
    return _selectView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cellConfigArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr[section].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr[indexPath.section] objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZStudentLessonDetailMainCell"]){
        ZStudentLessonDetailMainCell *mainCell = (ZStudentLessonDetailMainCell *)cell;
        mainCell.mainVC = self;
        mainCell.desModel = [[ZStudentDetailDesModel alloc] init];
//        mainCell.mealData = self.mainViewModel.mainMealModel;
//        mainCell.sportModel = self.mainViewModel.sportModel;
        
        self.subScrollView = mainCell.iScrollView;
        self.iDetilView = mainCell.iDetilView;
        self.iNoticeView = mainCell.iNoticeView ;
        self.iEvaView = mainCell.iEvaView;
        self.subScrollView.delegate = self;
        
//        __weak typeof(self) weakSelf = self;
//        self.iWeightView.refreshDataBlock = ^{
//            [weakSelf refreshTypeData:0];
//        };
//
//        self.iDietView.refreshDataBlock = ^{
//            [weakSelf refreshTypeData:1];
//        };
//
//        self.iSportView.refreshDataBlock = ^{
//            [weakSelf refreshTypeData:2];
//        };
        
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.section][indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return self.menuSelectedView.height;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
//        return self.levelListView;
        return self.menuSelectedView;
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorGrayBG];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr[indexPath.section] objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailIVideoCell"]) {
       
    }
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.subScrollView]) {
        self.iDetilView.iTableView.scrollEnabled = NO;
        self.iNoticeView.iTableView.scrollEnabled = NO;
        self.iEvaView.iTableView.scrollEnabled = NO;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isEqual:self.subScrollView]) {
        self.iDetilView.iTableView.scrollEnabled = YES;
        self.iNoticeView.iTableView.scrollEnabled = YES;
        self.iEvaView.iTableView.scrollEnabled = YES;
        
        [self refreshTypeData:(long)(self.subScrollView.contentOffset.x/KScreenWidth)+1];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:self.iTableView]) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height-scrollView.size.height-0.5)) {
            self.offsetType = OffsetTypeMax;
        } else if (scrollView.contentOffset.y <= 0) {
            self.offsetType = OffsetTypeMin;
        } else {
            self.offsetType = OffsetTypeCenter;
        }
        
        if ([self.menuSelectedView.topIndex integerValue] == 0 && self.iDetilView.offsetType == OffsetTypeCenter) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height-scrollView.size.height);
        }
        
        if ([self.menuSelectedView.topIndex integerValue] == 1 && self.iNoticeView.offsetType == OffsetTypeCenter) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height-scrollView.size.height);
        }
        
        if ([self.menuSelectedView.topIndex integerValue] == 2 && self.iEvaView.offsetType == OffsetTypeCenter) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height-scrollView.size.height);
        }
        
    } else if ([scrollView isEqual:self.subScrollView]) {
        
//        [self.levelListView configAnimationOffsetX:self.subScrollView.contentOffset.x];
        [self.menuSelectedView setOffset:self.subScrollView.contentOffset.x];
    }
}



#pragma mark 刷新数据
- (void)refreshTypeData:(NSInteger)index {
//    if (index == 0) {
//        [self refreshData];
//    }else if (index == 1){
//        [self refreshDietData];
//    }else{
//        [self refreshSportData];
//    }
}
@end

