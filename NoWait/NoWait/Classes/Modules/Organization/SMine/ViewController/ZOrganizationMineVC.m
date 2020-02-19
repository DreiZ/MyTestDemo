//
//  ZOrganizationMineVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineVC.h"
#import "ZOrganizationMineHeaderView.h"
#import "ZOriganizationClubSelectedCell.h"
#import "ZOriganizationStatisticsCell.h"
#import "ZOrganizationMenuCell.h"

#import "ZOrganizationCampusManagementVC.h"
#import "ZOrganizationLessonAddVC.h"

#import "ZStudentMineEvaListVC.h"
#import "ZStudentMineOrderListVC.h"
#import "ZStudentMineCardListVC.h"
#import "ZStudentMineSignListVC.h"
#import "ZStudentMineSettingVC.h"


#define kHeaderHeight (CGFloatIn750(316)+kStatusBarHeight)

@interface ZOrganizationMineVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) ZOrganizationMineHeaderView *headerView;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@property (nonatomic,strong) NSMutableArray *topchannelList;
@property (nonatomic,strong) NSMutableArray *lessonList;

@end

@implementation ZOrganizationMineVC

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"我的"), @"", @"");
        self.statusBarStyle = UIStatusBarStyleLightContent;
        self.analyzeTitle = @"个人主页";
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //更新用户信息
//        [[ZUserHelper sharedHelper] updateUserInfoWithCompleteBlock:^(BOOL isSuccess) {
//            if (!isSuccess) {
//                [[ZLaunchManager sharedInstance] showSaveUserInfo];
//            }
//        }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self setupMainView];
    [self setCellData];
}

- (void)setData {
    _topchannelList = @[].mutableCopy;
    _lessonList = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
//    NSArray *list = @[@[@"评价",@"mineOrderEva"],@[@"订单",@"mineOrderChannel"],@[@"卡券",@"mineOrderCard"],@[@"签课",@"mineOrderLesson"]];
//    NSArray *channlArr = @[@"eva", @"order", @"card", @"lesson"];
//    for (int i = 0; i < list.count; i++) {
//        ZStudentMenuItemModel *model = [[ZStudentMenuItemModel alloc] init];
//        model.name = list[i][0];
//        model.imageName = list[i][1];
//        model.channel_id = channlArr[i];
//        [_topchannelList addObject:model];
//
//        [_lessonList addSafeObject:[[ZStudentLessonModel alloc] init]];
//    }
}

- (void)setupMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.view addSubview:self.iTableView];
    
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_left).offset(20);
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
    
    [self.iTableView setContentInset:UIEdgeInsetsMake(kHeaderHeight+kStatusBarHeight, 0, 0, 0)];
    [self.iTableView addSubview:self.headerView];
}

#pragma mark - lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        
    }
    return _iTableView;
}

- (ZOrganizationMineHeaderView *)headerView {
    if (!_headerView) {
        __weak typeof(self) weakSelf = self;
        _headerView = [[ZOrganizationMineHeaderView alloc] initWithFrame:CGRectMake(0, -kHeaderHeight-kStatusBarHeight, KScreenWidth, kHeaderHeight+kStatusBarHeight)];
        _headerView.topHandleBlock = ^(NSInteger index) {
            [self.navigationController popViewControllerAnimated:YES];
//            if (index == 1) {
//                ZStudentMineSettingVC *svc = [[ZStudentMineSettingVC alloc] init];
//                [weakSelf.navigationController pushViewController:svc animated:YES];
//            }
        };
    }
    return _headerView;
}


#pragma mark - tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
//    ZOrganizationCampusManagementVC
    if ([cellConfig.title isEqualToString:@"ZMineMenuCell"]){
//        ZMineMenuCell *lcell = (ZMineMenuCell *)cell;
//        lcell.menuBlock = ^(ZStudentMenuItemModel * model) {
//            if ([model.channel_id isEqualToString:@"eva"]) {
//                ZStudentMineEvaListVC *elvc = [[ZStudentMineEvaListVC alloc] init];
//                [weakSelf.navigationController pushViewController:elvc animated:YES];
//            }else if ([model.channel_id isEqualToString:@"order"]){
//                ZStudentMineOrderListVC *elvc = [[ZStudentMineOrderListVC alloc] init];
//                [weakSelf.navigationController pushViewController:elvc animated:YES];
//
//            }else if ([model.channel_id isEqualToString:@"card"]) {
//                ZStudentMineCardListVC *lvc = [[ZStudentMineCardListVC alloc] init];
//                [weakSelf.navigationController pushViewController:lvc animated:YES];
//            }else if ([model.channel_id isEqualToString:@"lesson"]) {
//                ZStudentMineSignListVC *lvc = [[ZStudentMineSignListVC alloc] init];
//                [weakSelf.navigationController pushViewController:lvc animated:YES];
//            }
//        };
    }else if ([cellConfig.title isEqualToString:@"ZOrganizationMenuCell"]){
        ZOrganizationMenuCell *lcell = (ZOrganizationMenuCell *)cell;
        lcell.menuBlock = ^(ZBaseUnitModel * model) {
            if ([model.uid isEqualToString:@""]) {
                ZOrganizationLessonAddVC *mvc = [[ZOrganizationLessonAddVC alloc] init];
                [self.navigationController pushViewController:mvc animated:YES];
                
            }else if ([model.uid isEqualToString:@""]){
                ZOrganizationCampusManagementVC *mvc = [[ZOrganizationCampusManagementVC alloc] init];
                [self.navigationController pushViewController:mvc animated:YES];
            }
            
        };
        
    }

    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
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
//    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
//    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]) {
//        ZStudentOrganizationLessonDetailVC *lessond_vc = [[ZStudentOrganizationLessonDetailVC alloc] init];
//
//        [self.navigationController pushViewController:lessond_vc animated:YES];
//    }else if ([cellConfig.title isEqualToString:@"moreStarStudent"]){
//        ZStudentStarStudentListVC *lvc = [[ZStudentStarStudentListVC alloc] init];
//        [self.navigationController pushViewController:lvc animated:YES];
//    }else if ([cellConfig.title isEqualToString:@"moreStarCoach"]){
//        ZStudentStarCoachListVC *lvc = [[ZStudentStarCoachListVC alloc] init];
//        [self.navigationController pushViewController:lvc animated:YES];
//    }
}



#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
    if ( Offset_y < -(kTopHeight)) {
    // 拉伸后图片的高度
    CGFloat totalOffset = - Offset_y;
    // 拉伸后图片位置
    _headerView.frame = CGRectMake(0, Offset_y, KScreenWidth, totalOffset);
    }else{
      _headerView.frame = CGRectMake(0, Offset_y, KScreenWidth, kTopHeight);
    }
    
    [_headerView updateSubViewFrame];
}


- (void)setCellData {
    [_cellConfigArr removeAllObjects];
    
    NSMutableArray *channnliset = @[].mutableCopy;
    for (int i = 0; i < 20; i++) {
        ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
        model.name = @"凤凰社俱乐部";
        [channnliset addObject:model];
        if (i == 0) {
            model.isSelected = YES;
        }
    }
    ZCellConfig *channelCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationClubSelectedCell className] title:[ZOriganizationClubSelectedCell className] showInfoMethod:@selector(setChannelList:) heightOfCell:[ZOriganizationClubSelectedCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:channnliset];
    [self.cellConfigArr addObject:channelCellConfig];
    
    
    ZCellConfig *statisticsCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationStatisticsCell className] title:[ZOriganizationStatisticsCell className] showInfoMethod:nil heightOfCell:[ZOriganizationStatisticsCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:statisticsCellConfig];
    
    NSArray *menuArr = @[@[@"财务管理",@[@[@"账户",@"mineOrderEva"],
                                        @[@"订单",@"mineOrderEva"],
                                        @[@"退款",@"mineOrderEva"],
                                        @[@"卡券",@"mineOrderEva"]]],
                         @[@"人事管理",@[@[@"学员管理",@"mineOrderEva"],
                                        @[@"教师管理",@"mineOrderEva"],
                                        @[@"校区管理",@"mineOrderEva"]]],
                         @[@"后勤管理",@[@[@"相册管理",@"mineOrderEva"],
                                        @[@"班级管理",@"mineOrderEva"],
                                        @[@"排课管理",@"mineOrderEva"],
                                        @[@"课程管理",@"mineOrderEva"],
                                        @[@"评价管理",@"mineOrderEva"]]]];
    for (int i = 0; i < menuArr.count; i++) {
        ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
        model.name = menuArr[i][0];
        
        NSMutableArray *menulist = @[].mutableCopy;
        NSArray *tempArr = menuArr[i][1];
        for (int j = 0; j < tempArr.count; j++) {
            ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
            model.name = tempArr[j][0];
            model.imageName = tempArr[j][1];
            [menulist addObject:model];
        }
        
        model.units = menulist;
        
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationMenuCell className] title:[ZOrganizationMenuCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationMenuCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:progressCellConfig];
    }

    
    [self.iTableView reloadData];
}
@end

