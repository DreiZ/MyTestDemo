//
//  ZRewardCenterVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardCenterVC.h"
#import "ZRewardCenterTopCell.h"
#import "ZRewardCenterDetailCell.h"
#import "ZBaseLineCell.h"
#import "ZTableViewListCell.h"

#import "ZInvitationFriendVC.h"
#import "ZReflectMoneyVC.h"
#import "ZReflectListLogVC.h"
#import "ZRewardDetailsListVC.h"
#import "ZRewardMyTeamListVC.h"
#import "ZRewardRankingVC.h"

#import "ZRewardCenterViewModel.h"

@interface ZRewardCenterVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) ZRewardInfoModel *infoModel;

@end

@implementation ZRewardCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
    [self setTableViewRefreshHeader];
    [self refreshData];
}


- (void)setNavigation {
    [self.navigationItem setTitle:@"奖励中心"];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]];
}


- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_navLeftBtn setTitle:@"" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor blackColor], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontMaxTitle]];
        [_navLeftBtn setImage:[UIImage imageNamed:@"navleftBack"]  forState:UIControlStateNormal];
        [_navLeftBtn bk_whenTapped:^{
             
               NSArray *viewControllers = self.navigationController.viewControllers;
               NSArray *reversedArray = [[viewControllers reverseObjectEnumerator] allObjects];
               
               ZViewController *target;
               for (ZViewController *controller in reversedArray) {
                   if ([controller isKindOfClass:[NSClassFromString(@"ZStudentLessonDetailVC") class]]) {
                       target = controller;
                       break;
                   }else if ([controller isKindOfClass:[NSClassFromString(@"ZStudentOrganizationDetailDesVC") class]]){
                       target = controller;
                   }
               }
               
               if (target) {
                   [weakSelf.navigationController popToViewController:target animated:YES];
                   return;
               }
               [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _navLeftBtn;
}

#pragma mark - cellconfig init
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZRewardCenterTopCell className] title:[ZRewardCenterTopCell className] showInfoMethod:nil heightOfCell:[ZRewardCenterTopCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:topCellConfig];
    
    ZCellConfig *detailCellConfig = [ZCellConfig cellConfigWithClassName:[ZRewardCenterDetailCell className] title:[ZRewardCenterDetailCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZRewardCenterDetailCell z_getCellHeight:self.infoModel] cellType:ZCellTypeClass dataModel:self.infoModel];
    [self.cellConfigArr addObject:detailCellConfig];
    
    NSArray *tempArr = @[@[@"sign_teacher",@"team", @"我的团队"],
                         @[@"eva_teacher",@"rank", @"奖励排行"],
                         @[@"eva_teacher",@"detail", @"奖励说明"]];
    NSMutableArray *configArr = @[].mutableCopy;
    for (NSArray *tArr in tempArr) {
        ZLineCellModel *model = [[ZLineCellModel alloc] init];
        model.leftImage = tArr[0];
        model.leftTitle = tArr[2];
        model.cellTitle = tArr[1];
        model.leftContentSpace = CGFloatIn750(50);
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(96);
        model.leftFont = [UIFont fontContent];
        model.leftImageH = CGFloatIn750(50);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [configArr addObject:menuCellConfig];
    }
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];
}

#pragma mark - tableView datasource
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZTableViewListCell"]) {
        ZTableViewListCell *lcell = (ZTableViewListCell *)cell;
        lcell.handleBlock = ^(ZCellConfig * lcellConfig) {
            if ([lcellConfig.title isEqualToString:@"team"]) {
                ZRewardMyTeamListVC *fvc = [[ZRewardMyTeamListVC alloc] init];
                [self.navigationController pushViewController:fvc animated:YES];
            }else if ([lcellConfig.title isEqualToString:@"rank"]) {
                ZRewardRankingVC *fvc = [[ZRewardRankingVC alloc] init];
                [self.navigationController pushViewController:fvc animated:YES];
            }else if ([lcellConfig.title isEqualToString:@"detail"]) {
                
            }
        };
    }else if ([cellConfig.title isEqualToString:@"ZRewardCenterTopCell"]) {
        ZRewardCenterTopCell *lcell = (ZRewardCenterTopCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            ZInvitationFriendVC *fvc = [[ZInvitationFriendVC alloc] init];
            fvc.model = weakSelf.infoModel;
            [self.navigationController pushViewController:fvc animated:YES];
        };
    }else if ([cellConfig.title isEqualToString:@"ZRewardCenterDetailCell"]) {
        ZRewardCenterDetailCell *lcell = (ZRewardCenterDetailCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                ZReflectMoneyVC *fvc = [[ZReflectMoneyVC alloc] init];
                [self.navigationController pushViewController:fvc animated:YES];
            }else if(index == 1){
                ZReflectListLogVC *fvc = [[ZReflectListLogVC alloc] init];
                [self.navigationController pushViewController:fvc animated:YES];
            }else if(index == 2){
                ZRewardDetailsListVC *fvc = [[ZRewardDetailsListVC alloc] init];
                [self.navigationController pushViewController:fvc animated:YES];
            }
        };
    }
}

#pragma mark - refresh data
- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    [ZRewardCenterViewModel rewardCenterInfo:@{} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess) {
            weakSelf.infoModel = data;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end
