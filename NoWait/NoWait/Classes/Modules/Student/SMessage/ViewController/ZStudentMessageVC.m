//
//  ZStudentMessageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMessageVC.h"
#import "ZStudentMessageListCell.h"

#import "ZStudentMessageDetailVC.h"
#import "ZMessageCell.h"
#import "ZMineModel.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZStudentMessageSendListVC.h"
#import "ZIMManager.h"
#import "ZSessionListViewController.h"

@interface ZStudentMessageVC ()
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) UIButton *navLeftBtn;

@end
@implementation ZStudentMessageVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshData];
}

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"消息"), @"tabBarMessage", @"tabBarMessage_highlighted");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loading = YES;
    [self setTableViewGaryBack];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

- (void)setDataSource {
    [super setDataSource];
    _param = @{}.mutableCopy;
    if (ValidStr([ZUserHelper sharedHelper].user_id)) {
        self.emptyDataStr = @"您还没有收到过消息";
    }else{
        self.emptyDataStr = @"您还没有登录";
    }
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (id data in self.dataSources) {
        ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageCell className] title:[ZMessageCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZMessageCell z_getCellHeight:data] cellType:ZCellTypeClass dataModel:data];
        [self.cellConfigArr addObject:messageCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"消息"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]];
}

- (void)setupMainView {
    [super setupMainView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(118), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"消息" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontSmall]];
        [_navLeftBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        ViewRadius(_navLeftBtn, CGFloatIn750(25));
        [_navLeftBtn bk_whenTapped:^{
            
            [[ZIMManager shareManager] loginIMComplete:^(BOOL isSuccess) {
                ZSessionListViewController *lvc = [[ZSessionListViewController alloc] init];
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            }];
        }];
    }
    return _navLeftBtn;
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZMessageCell"]) {
        ZMessageCell *lcell = (ZMessageCell *)cell;
        lcell.handleBlock = ^(ZMineMessageModel * message) {
            if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
                ZStudentMessageSendListVC *svc = [[ZStudentMessageSendListVC alloc] init];
                svc.model = message;
                [self.navigationController pushViewController:svc animated:YES];
            }
        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
//    if ([cellConfig.title isEqualToString:@"ZStudentMessageListCell"]) {
//        ZStudentMessageDetailVC *dvc = [[ZStudentMessageDetailVC alloc] init];
//        [self.navigationController pushViewController:dvc animated:YES];
//    }
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self setPostCommonData];
    [self refreshHeadData:self.param];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
        [ZOriganizationStudentViewModel getSendsMessageList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                [weakSelf.dataSources removeAllObjects];
                [weakSelf.dataSources addObjectsFromArray:data.list];
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
                
                [weakSelf.iTableView tt_endRefreshing];
                if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                    [weakSelf.iTableView tt_removeLoadMoreFooter];
                }else{
                    [weakSelf.iTableView tt_endLoadMore];
                }
            }else{
                [weakSelf.iTableView reloadData];
                [weakSelf.iTableView tt_endRefreshing];
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }
        }];
    }else{
        [ZOriganizationStudentViewModel getMessageList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                [weakSelf.dataSources removeAllObjects];
                [weakSelf.dataSources addObjectsFromArray:data.list];
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
                
                [weakSelf.iTableView tt_endRefreshing];
                if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                    [weakSelf.iTableView tt_removeLoadMoreFooter];
                }else{
                    [weakSelf.iTableView tt_endLoadMore];
                }
            }else{
                [weakSelf.iTableView reloadData];
                [weakSelf.iTableView tt_endRefreshing];
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }
        }];
    }
    
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    [self setPostCommonData];
    __weak typeof(self) weakSelf = self;
    if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
        [ZOriganizationStudentViewModel getSendsMessageList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                [weakSelf.dataSources addObjectsFromArray:data.list];
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
                
                [weakSelf.iTableView tt_endRefreshing];
                if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                    [weakSelf.iTableView tt_removeLoadMoreFooter];
                }else{
                    [weakSelf.iTableView tt_endLoadMore];
                }
            }else{
                [weakSelf.iTableView reloadData];
                [weakSelf.iTableView tt_endRefreshing];
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }
        }];
    }else{
        [ZOriganizationStudentViewModel getMessageList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                [weakSelf.dataSources addObjectsFromArray:data.list];
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
                
                [weakSelf.iTableView tt_endRefreshing];
                if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                    [weakSelf.iTableView tt_removeLoadMoreFooter];
                }else{
                    [weakSelf.iTableView tt_endLoadMore];
                }
            }else{
                [weakSelf.iTableView reloadData];
                [weakSelf.iTableView tt_endRefreshing];
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }
        }];
    }
}


- (void)setPostCommonData {
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];

}
@end

