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
#import "ZTableViewListCell.h"
#import "ZStudentMineLessonTimetableCell.h"

#import "ZStudentMineEvaListVC.h"
#import "ZStudentMineOrderListVC.h"
#import "ZStudentMineCardListVC.h"
#import "ZStudentMineSignListVC.h"
#import "ZStudentMineSettingVC.h"

#import "ZMineSwitchRoleVC.h"

#define kHeaderHeight (CGFloatIn750(270))

@interface ZStudentMineVC ()
@property (nonatomic,strong) ZOrganizationMineHeaderView *headerView;

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
     [self.headerView updateData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainView];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setDataSource {
    
    [super setDataSource];
    _lessonList = @[].mutableCopy;
    
    for (int i = 0; i < 5; i++) {
        
        [_lessonList addSafeObject:[[ZStudentLessonModel alloc] init]];
    }
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
    
    if ([cellConfig.title isEqualToString:@"ZTableViewListCell"]){
        ZTableViewListCell *lcell = (ZTableViewListCell *)cell;
        lcell.handleBlock = ^(ZCellConfig *scellConfig) {
            if ([scellConfig.title isEqualToString:@"eva"]) {
                ZStudentMineEvaListVC *elvc = [[ZStudentMineEvaListVC alloc] init];
                [weakSelf.navigationController pushViewController:elvc animated:YES];
            }else if ([scellConfig.title isEqualToString:@"order"]){
                ZStudentMineOrderListVC *elvc = [[ZStudentMineOrderListVC alloc] init];
                [weakSelf.navigationController pushViewController:elvc animated:YES];
            }else if ([scellConfig.title isEqualToString:@"card"]) {
                ZStudentMineCardListVC *lvc = [[ZStudentMineCardListVC alloc] init];
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            }else if ([scellConfig.title isEqualToString:@"refund"]) {
                ZStudentMineSignListVC *lvc = [[ZStudentMineSignListVC alloc] init];
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            }else if ([scellConfig.title isEqualToString:@"sign"]) {
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
    NSArray *tempArr = @[@[isDarkModel() ? @"stores_order_dark":@"stores_order",@"order", @"我的订单", @"rightBlackArrowN"],
                         @[isDarkModel() ? @"sign_teacher_dark":@"sign_teacher_dark",@"sign", @"我的签课", @"rightBlackArrowN"],
                         @[isDarkModel() ? @"stores_card_dark":@"stores_card",@"card", @"我的卡券", @"rightBlackArrowN"],
                         @[isDarkModel() ? @"eva_teacher_dark":@"eva_teacher",@"eva", @"我的评价", @"rightBlackArrowN"],
                         @[isDarkModel() ? @"refund_money_dark":@"refund_money",@"refund", @"我的退款", @"rightBlackArrowN"]];
    NSMutableArray *configArr = @[].mutableCopy;
    for (NSArray *tArr in tempArr) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftImage = tArr[0];
        model.leftTitle = tArr[2];
        model.rightImage = tArr[3];
        model.cellTitle = tArr[1];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(96);
        model.leftFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [configArr addObject:menuCellConfig];
    }
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];

    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineLessonProgressCell className] title:[ZStudentMineLessonProgressCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentMineLessonProgressCell z_getCellHeight:_lessonList] cellType:ZCellTypeClass dataModel:_lessonList];
    [self.cellConfigArr addObject:progressCellConfig];
    
    ZCellConfig *timeCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineLessonTimetableCell className] title:[ZStudentMineLessonTimetableCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentMineLessonTimetableCell z_getCellHeight:_lessonList] cellType:ZCellTypeClass dataModel:_lessonList];
    [self.cellConfigArr addObject:timeCellConfig];
    
    
    
    [self.iTableView reloadData];
}
@end
