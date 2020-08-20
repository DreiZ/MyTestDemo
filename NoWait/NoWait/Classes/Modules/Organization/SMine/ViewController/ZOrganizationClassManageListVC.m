//
//  ZOrganizationClassManageListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassManageListVC.h"
#import "ZOrganizationClassManageListCell.h"
#import "ZAlertView.h"

#import "ZOrganizationClassManageDetailVC.h"
#import "ZOriganizationClassViewModel.h"

@interface ZOrganizationClassManageListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) NSString *total;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UILabel *totalLabel;
@end

@implementation ZOrganizationClassManageListVC

#pragma mark vc delegate-------------------
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"班级列表")
    .zChain_updateDataSource(^{
        self.total = @"0";
        self.loading = YES;
        self.param = @{}.mutableCopy;
    }).zChain_addEmptyDataDelegate()
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMoreData];
    }).zChain_block_setRefreshHeaderNet(^{
        [weakSelf refreshData];
    }).zChain_resetMainView(^{
        self.iTableView.tableHeaderView = self.headView;
        self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        self.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        self.totalLabel.text = [NSString stringWithFormat:@"共%@个班级",self.total];
        for (int i = 0; i < weakSelf.dataSources.count; i++) {
            ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationClassManageListCell className] title:[ZOrganizationClassManageListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationClassManageListCell z_getCellHeight:weakSelf.dataSources[i]] cellType:ZCellTypeClass dataModel:weakSelf.dataSources[i]];
            [weakSelf.cellConfigArr addObject:progressCellConfig];
        }
        
        if (weakSelf.cellConfigArr.count == 0) {
            weakSelf.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
            weakSelf.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        }else{
            weakSelf.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
            weakSelf.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZOrganizationClassManageListCell"]) {
            ZOriganizationClassListModel *model = cellConfig.dataModel;
            ZOrganizationClassManageListCell *lcell = (ZOrganizationClassManageListCell *)cell;
            lcell.handleBlock = ^(NSInteger index) {
                if (index == 0) {
                    [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"确定删除班级？" leftBtnTitle:@"取消" rightBtnTitle:@"删除" handlerBlock:^(NSInteger index) {
                        if (index == 1) {
                            [weakSelf deleteClass:model];
                        }
                    }];
                }else if (index == 1){
                    ZOriganizationClassListModel *model = cellConfig.dataModel;
                    
                    ZOrganizationClassManageDetailVC *dvc = [[ZOrganizationClassManageDetailVC alloc] init];
                    dvc.model.courses_name = model.courses_name;
                    dvc.model.classID = model.classID;
                    dvc.model.name = model.name;
                    dvc.model.nums = model.nums;
                    dvc.model.status = model.status;
                    dvc.model.teacher_id = model.teacher_id;
                    dvc.model.teacher_image = model.teacher_image;
                    dvc.model.teacher_name = model.teacher_name;
                    dvc.model.type = model.type;
                    [weakSelf.navigationController pushViewController:dvc animated:YES];
                }
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZOrganizationClassManageListCell"]) {
            ZOriganizationClassListModel *model = cellConfig.dataModel;
            
            ZOrganizationClassManageDetailVC *dvc = [[ZOrganizationClassManageDetailVC alloc] init];
            dvc.model.courses_name = model.courses_name;
            dvc.model.classID = model.classID;
            dvc.model.name = model.name;
            dvc.model.nums = model.nums;
            dvc.model.status = model.status;
            dvc.model.teacher_id = model.teacher_id;
            dvc.model.teacher_image = model.teacher_image;
            dvc.model.teacher_name = model.teacher_name;
            dvc.model.type = model.type;
            [weakSelf.navigationController pushViewController:dvc animated:YES];
        }
    });
}

-(UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(64))];
        _headView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        _totalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _totalLabel.textColor = [UIColor colorMain];
        _totalLabel.text = @"";
        _totalLabel.numberOfLines = 0;
        _totalLabel.textAlignment = NSTextAlignmentLeft;
        [_totalLabel setFont:[UIFont fontContent]];
        [_headView addSubview:_totalLabel];
        [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headView.mas_left).offset(CGFloatIn750(36));
            make.bottom.equalTo(self.headView.mas_bottom);
        }];
    }
    return _headView;
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self setPostCommonData];
    [self refreshHeadData:_param];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            weakSelf.total = data.total;
            
            weakSelf.zChain_reload_ui();
            
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

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getClassList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            weakSelf.total = data.total;
            weakSelf.zChain_reload_ui();
            
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

- (void)refreshAllData {
    self.loading = YES;
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [_param setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    [_param setObject:SafeStr(self.type) forKey:@"status"];
}

- (void)deleteClass:(ZOriganizationClassListModel*)model {
    __weak typeof(self) weakSelf = self;
 
    [TLUIUtility showLoading:@""];
    [ZOriganizationClassViewModel deleteClass:@{@"stores_id":SafeStr([ZUserHelper sharedHelper].school.schoolID),@"id":SafeStr(model.classID)} completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf refreshAllData];
        }else{
            [TLUIUtility showErrorHint:message];
        };
    }];
}

- (void)openClass:(ZOriganizationClassListModel*)model {
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationClassViewModel openClass:@{@"stores_id":SafeStr([ZUserHelper sharedHelper].school.schoolID),@"id":SafeStr(model.classID)} completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf refreshAllData];
        }else{
            [TLUIUtility showErrorHint:message];
        };
    }];
}
@end
