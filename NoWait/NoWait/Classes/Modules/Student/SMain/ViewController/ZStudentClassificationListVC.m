//
//  ZStudentClassificationListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentClassificationListVC.h"
#import "ZStudentMainModel.h"
#import "ZStudentOrganizationListCell.h"
#import "ZStudentClassFiltrateSectionView.h"
#import "ZStudentMainViewModel.h"

#import "ZStudentOrganizationDetailDesVC.h"
#import "ZLocationManager.h"

@interface ZStudentClassificationListVC ()
@property (nonatomic,strong) ZStudentClassFiltrateSectionView *sectionView;
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) UIView *headView;

@end

@implementation ZStudentClassificationListVC

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_sectionView.menuView) {
        [self.sectionView.menuView hideMenuList];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(self.vcTitle)
    .zChain_addLoadMoreFooter()
    .zChain_addRefreshHeader()
    .zChain_addEmptyDataDelegate()
    .zChain_updateDataSource(^{
        weakSelf.param = @{}.mutableCopy;
        weakSelf.loading = YES;
        
        [weakSelf.param setObject:@"0" forKey:@"sort_type"];
        [weakSelf.param setObject:self.type forKey:@"category"];
    }).zChain_resetMainView(^{
        [weakSelf.view addSubview:self.sectionView];
        [weakSelf.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
        }];

        [weakSelf.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.sectionView.mas_bottom);
        }];
    }).zChain_block_setRefreshHeaderNet(^{
        weakSelf.currentPage = 1;
        weakSelf.loading = YES;
        [weakSelf setPostCommonData];
        [weakSelf refreshHeadData:weakSelf.param];
    }).zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMyMoreData];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];

        for (int i = 0; i < weakSelf.dataSources.count; i++) {
            ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationListCell className] title:@"ZStudentOrganizationListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationListCell z_getCellHeight:weakSelf.dataSources[i]] cellType:ZCellTypeClass dataModel:weakSelf.dataSources[i]];
            [weakSelf.cellConfigArr addObject:orCellCon1fig];
        }

        update(weakSelf.cellConfigArr);
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if([cellConfig.title isEqualToString:@"ZStudentOrganizationListCell"]){
           ZStudentOrganizationListCell *lcell = (ZStudentOrganizationListCell *)cell;
            lcell.moreBlock = ^(ZStoresListModel *model) {
                model.isMore = !model.isMore;
                weakSelf.zChain_reload_ui();
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentOrganizationListCell"]) {
            ZStudentOrganizationDetailDesVC *dvc = [[ZStudentOrganizationDetailDesVC alloc] init];
            dvc.listModel = cellConfig.dataModel;
            [weakSelf.navigationController pushViewController:dvc animated:YES];
        }
    });
    
    self.zChain_reload_Net();
}


#pragma mark - lazy loading
- (ZStudentClassFiltrateSectionView *)sectionView {
    if (!_sectionView) {
        __weak typeof(self) weakSelf = self;
        _sectionView = [[ZStudentClassFiltrateSectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88))];
        _sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorGrayLine]);
        _sectionView.titleSelect = ^(NSInteger index) {
            
        };
        
        _sectionView.dataBlock = ^(NSDictionary *tDict) {
            if (tDict && [tDict objectForKey:@"sort"]) {
                [weakSelf.param setObject:tDict[@"sort"] forKey:@"sort_type"];
            }else{
                [weakSelf.param setObject:@"0" forKey:@"sort_type"];
//                [weakSelf.param removeObjectForKey:@"sort"];
            }

            [weakSelf refreshData];
        };
    }
    return _sectionView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(130))];
        
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        hintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        hintLabel.text = @"此类机构正在火速入驻中，为你推荐";
        hintLabel.textAlignment = NSTextAlignmentCenter;
        [hintLabel setFont:[UIFont fontMin]];
        [_headView addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.headView);
            make.top.equalTo(self.headView.mas_top).offset(CGFloatIn750(30));
        }];
        
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        addressLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        addressLabel.text = @"附近推荐";
        addressLabel.textAlignment = NSTextAlignmentLeft;
        [addressLabel setFont:[UIFont boldFontTitle]];
        [_headView addSubview:addressLabel];
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(hintLabel.mas_bottom).offset(CGFloatIn750(30));
            make.left.equalTo(self.headView.mas_left).offset(CGFloatIn750(30));
        }];
    }
    return _headView;
}

#pragma mark - 数据处理
- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZStudentMainViewModel getIndexList:self.param completeBlock:^(BOOL isSuccess, ZStoresListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            weakSelf.zChain_reload_ui();
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
            if (weakSelf.dataSources.count == 0 && [self.param objectForKey:@"category"]) {
                weakSelf.iTableView.tableHeaderView = weakSelf.headView;
                [weakSelf.param removeObjectForKey:@"category"];
                [weakSelf.param setObject:@"3" forKey:@"sort_type"];
                weakSelf.zChain_reload_Net();
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshMyMoreData {
    self.currentPage++;
    self.loading = YES;
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZStudentMainViewModel getIndexList:self.param completeBlock:^(BOOL isSuccess, ZStoresListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
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
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    
    if ([ZLocationManager shareManager].cureUserLocation) {
        [_param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].cureUserLocation.coordinate.longitude] forKey:@"longitude"];
        [_param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].cureUserLocation.coordinate.latitude] forKey:@"latitude"];
    }
}
@end
