//
//  ZRewardRankingVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardRankingVC.h"
#import "ZRewardRankingCell.h"
#import "ZRewardRankingBottomView.h"
#import "ZRewardCenterViewModel.h"
#import "ZRewardModel.h"

@interface ZRewardRankingVC ()
@property (nonatomic,strong) ZRewardRankingBottomView *bottomView;
@property (nonatomic,strong) ZRewardRankingMyModel *rank;

@end

@implementation ZRewardRankingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewEmptyDataDelegate];
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
    [self refreshData];
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"奖励排行"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(120));
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

#pragma mark - lazy loading
- (ZRewardRankingBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ZRewardRankingBottomView alloc] init];
        
    }
    return _bottomView;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    __block ZRewardRankingListModel *model = nil;
    [self.dataSources enumerateObjectsUsingBlock:^(ZRewardRankingListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            model = obj;
            obj.max_amount = obj.total_amount;
        }else{
            obj.max_amount = model.total_amount;
        }
        obj.index = [NSString stringWithFormat:@"%ld",idx + 1];
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZRewardRankingCell className] title:@"ZRewardRankingCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZRewardRankingCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:obj];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }];
    
    _bottomView.rank = self.rank;
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZRewardCenterViewModel rankingList:param completeBlock:^(BOOL isSuccess, ZRewardRankingModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            weakSelf.rank = data.rank;
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

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
     [ZRewardCenterViewModel rankingList:param completeBlock:^(BOOL isSuccess, ZRewardRankingModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            weakSelf.rank = data.rank;
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

- (void)refreshAllData {
    self.loading = YES;
    NSMutableDictionary *param = [self setPostCommonData];
    [param setObject:@"1" forKey:@"page"];
    [param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    [self refreshHeadData:param];
}

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    return param;
}
@end
