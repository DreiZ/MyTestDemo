//
//  ZOrganizationSearchCouponVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSearchCouponVC.h"
#import "ZOriganizationCartListCell.h"

@interface ZOrganizationSearchCouponVC ()
@property (nonatomic,strong) NSString *name;

@end

@implementation ZOrganizationSearchCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
       self.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
}


#pragma mark - setdata
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationCartListCell className] title:[ZOriganizationCartListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationCartListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:progressCellConfig];
    }

    if (self.cellConfigArr.count > 0) {
        self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }else{
        self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
}

- (void)valueChange:(NSString *)text {
    [super valueChange:text];
    self.name = SafeStr(text);
    if (self.name.length > 0) {
        [self refreshData];
    }
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationCardViewModel getCardList:param completeBlock:^(BOOL isSuccess, ZOriganizationCardListNetModel *data) {
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

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationCardViewModel getCardList:param completeBlock:^(BOOL isSuccess, ZOriganizationCardListNetModel *data) {
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

- (void)refreshAllData {
    self.loading = YES;
    NSMutableDictionary *param = [self setPostCommonData];
    [param setObject:@"1" forKey:@"page"];
    [param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    [self refreshHeadData:param];
}

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
       [param setObject:[ZUserHelper sharedHelper].school.schoolID forKey:@"stores_id"];
       [param setObject:self.name forKey:@"title"];
    return param;
}

@end

