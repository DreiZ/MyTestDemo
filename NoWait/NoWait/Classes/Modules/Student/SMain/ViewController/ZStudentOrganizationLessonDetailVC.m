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
#import "ZStudentOrganizationDetailIVideoCell.h"
//#import "ZStudentLessonDetailBannerCell.h"

#import "ZStudentLessonEvaView.h"
#import "ZStudentLessonDetailView.h"
#import "ZStudentLessonNoticeView.h"

#import "ZMenuSelectdView.h"

@interface ZStudentOrganizationLessonDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIScrollView *subScrollView;
@property (nonatomic,strong) ZMenuSelectdView *menuSelectedView;


@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray <NSArray *>*cellConfigArr;
@end
@implementation ZStudentOrganizationLessonDetailVC

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
        
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KBackColor];
        [section1Arr addObject:spacCellConfig];
        
//        ZCellConfig *bannerCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailBannerCell className] title:[ZStudentLessonDetailBannerCell className] showInfoMethod:nil heightOfCell:[ZStudentLessonDetailBannerCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
//        [section1Arr addObject:bannerCellConfig];

        [self.cellConfigArr addObject:section1Arr];
    }
//
//    {
//        NSMutableArray *section2Arr = @[].mutableCopy;
//        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KBackColor];
//        [section2Arr addObject:spacCellConfig];
//        [self.cellConfigArr addObject:section2Arr];
//    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"课程详情"];
}

- (void)setupMainView {
    self.view.backgroundColor = KBackColor;
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(100));
        make.top.equalTo(self.view.mas_top).offset(1);
    }];
}

#pragma mark lazy loading...
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
        _iTableView.backgroundColor = KBackColor;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
    }
    return _iTableView;
}


- (ZMenuSelectdView *)menuSelectedView {
    if (!_menuSelectedView) {
        __weak typeof(self) weakSelf = self;
        _menuSelectedView = [[ZMenuSelectdView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatIn750(98)) withTitleArr:@[@"体重", @"饮食", @"运动"] topIndex:@"0"];
        _menuSelectedView.selectBlock = ^(NSInteger index) {
            [weakSelf.subScrollView setContentOffset:CGPointMake(KScreenWidth*index, 0)];
//            [weakSelf refreshTypeData:index];
        };
    }
    return _menuSelectedView;
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
    if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
//        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
        
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
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr[indexPath.section] objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailIVideoCell"]) {
       
    }
}

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
@end

