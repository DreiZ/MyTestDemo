//
//  ZStudentMineVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineVC.h"
#import "ZOrganizationMineHeaderView.h"

#import "ZMineMenuCell.h"
#import "ZStudentMineAdverCell.h"
#import "ZStudentMineLessonProgressCell.h"

#import "ZStudentMineEvaListVC.h"
#import "ZStudentMineOrderListVC.h"
#import "ZStudentMineCardListVC.h"
#import "ZStudentMineSignListVC.h"
#import "ZStudentMineSettingVC.h"

#import "ZMineSwitchRoleVC.h"

#define kHeaderHeight (CGFloatIn750(270))

@interface ZStudentMineVC ()
@property (nonatomic,strong) ZOrganizationMineHeaderView *headerView;

@property (nonatomic,strong) NSMutableArray *topchannelList;
@property (nonatomic,strong) NSMutableArray *lessonList;

@end

@implementation ZStudentMineVC

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
    
    [self setTableViewGaryBack];
    [self setupMainView];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setDataSource {
    
    [super setDataSource];
    _topchannelList = @[].mutableCopy;
    _lessonList = @[].mutableCopy;
    
    NSArray *list = @[@[@"评价",@"mineOrderEva"],@[@"订单",@"mineOrderChannel"],@[@"卡券",@"mineOrderCard"],@[@"签课",@"mineOrderLesson"]];
    NSArray *channlArr = @[@"eva", @"order", @"card", @"lesson"];
    for (int i = 0; i < list.count; i++) {
        ZStudentMenuItemModel *model = [[ZStudentMenuItemModel alloc] init];
        model.name = list[i][0];
        model.imageName = list[i][1];
        model.channel_id = channlArr[i];
        [_topchannelList addObject:model];
        
        [_lessonList addSafeObject:[[ZStudentLessonModel alloc] init]];
    }
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
    
    [self.iTableView setContentInset:UIEdgeInsetsMake(kHeaderHeight+kStatusBarHeight, 0, 0, 0)];
    [self.iTableView addSubview:self.headerView];
}

#pragma mark - lazy loading...
- (ZOrganizationMineHeaderView *)headerView {
    if (!_headerView) {
        __weak typeof(self) weakSelf = self;
        _headerView = [[ZOrganizationMineHeaderView alloc] initWithFrame:CGRectMake(0, -kHeaderHeight-kStatusBarHeight, KScreenWidth, kHeaderHeight+kStatusBarHeight)];
        _headerView.topHandleBlock = ^(NSInteger index) {
            if (index == 1) {
                ZStudentMineSettingVC *svc = [[ZStudentMineSettingVC alloc] init];
                [weakSelf.navigationController pushViewController:svc animated:YES];
            }else if (index == 3){
                ZMineSwitchRoleVC *avc = [[ZMineSwitchRoleVC alloc] init];
                [weakSelf.navigationController pushViewController:avc animated:YES];
            }
        };
    }
    return _headerView;
}


#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    
    if ([cellConfig.title isEqualToString:@"ZMineMenuCell"]){
        ZMineMenuCell *lcell = (ZMineMenuCell *)cell;
        lcell.menuBlock = ^(ZStudentMenuItemModel * model) {
            if ([model.channel_id isEqualToString:@"eva"]) {
                ZStudentMineEvaListVC *elvc = [[ZStudentMineEvaListVC alloc] init];
                [weakSelf.navigationController pushViewController:elvc animated:YES];
            }else if ([model.channel_id isEqualToString:@"order"]){
                ZStudentMineOrderListVC *elvc = [[ZStudentMineOrderListVC alloc] init];
                [weakSelf.navigationController pushViewController:elvc animated:YES];

            }else if ([model.channel_id isEqualToString:@"card"]) {
                ZStudentMineCardListVC *lvc = [[ZStudentMineCardListVC alloc] init];
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            }else if ([model.channel_id isEqualToString:@"lesson"]) {
                ZStudentMineSignListVC *lvc = [[ZStudentMineSignListVC alloc] init];
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            }
        };
    }
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


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *channelCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineMenuCell className] title:[ZMineMenuCell className] showInfoMethod:@selector(setTopChannelList:) heightOfCell:[ZMineMenuCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:_topchannelList];
    [self.cellConfigArr addObject:channelCellConfig];
    
//    ZCellConfig *adverCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineAdverCell className] title:[ZStudentMineAdverCell className] showInfoMethod:nil heightOfCell:[ZStudentMineAdverCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
//    [self.cellConfigArr addObject:adverCellConfig];
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineLessonProgressCell className] title:[ZStudentMineLessonProgressCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentMineLessonProgressCell z_getCellHeight:_lessonList] cellType:ZCellTypeClass dataModel:_lessonList];
       [self.cellConfigArr addObject:progressCellConfig];
    
    
    [self.iTableView reloadData];
}
@end
