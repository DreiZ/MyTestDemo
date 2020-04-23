//
//  ZOrganizationSchoolAccountListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSchoolAccountListVC.h"
#import "ZOrganizationAccountSchoolNOListCell.h"
#import "ZOriganizationAccountFilteView.h"
#import "ZAlertBeginAndEndTimeView.h"
#import "ZOriganizationViewModel.h"

@interface ZOrganizationSchoolAccountListVC ()
@property (nonatomic,strong) ZOriganizationAccountFilteView *topView;
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) NSString *start_time;
@property (nonatomic,strong) NSString *end_time;
@property (nonatomic,strong) ZStoresAccountBillListNetModel *model;

@end

@implementation ZOrganizationSchoolAccountListVC

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _param = @{}.mutableCopy;
    self.loading = YES;
    [self setTableViewGaryBack];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self.dataSources enumerateObjectsUsingBlock:^(ZStoresAccountBillListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAccountSchoolNOListCell className] title:[ZOrganizationAccountSchoolNOListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationAccountSchoolNOListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:obj];
        [self.cellConfigArr addObject:topCellConfig];
    }];
    
    
    _topView.model = self.model;
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"账户信息"];
}

- (void)setupMainView {
    [super setupMainView];
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(106));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.right.bottom.equalTo(self.view);
         make.top.equalTo(self.topView.mas_bottom).offset(CGFloatIn750(0));
    }];
}

#pragma mark - lazy loading...
- (ZOriganizationAccountFilteView *)topView {
    if (!_topView) {
        __weak typeof(self) weakSelf = self;
        _topView = [[ZOriganizationAccountFilteView alloc] init];
        _topView.handleBlock = ^(NSInteger index) {
            if ([weakSelf.type intValue] == 0) {
                [ZAlertBeginAndEndTimeView setAlertName:@"选择开始日期" subName:@"选择结束时间"  pickerMode:PGDatePickerModeDate handlerBlock:^(NSDateComponents *begin, NSDateComponents *end) {
                    DLog(@"-begin-%@-end-%@",[NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:begin] timeIntervalSince1970]],[NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:end] timeIntervalSince1970]]);
                    weakSelf.start_time = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:begin] timeIntervalSince1970]];
                    weakSelf.end_time = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:end] timeIntervalSince1970]];
                }];
            } 
        };
        if ([self.type intValue] == 1 || [self.type intValue] == 2) {
            _topView.isHandle = NO;
        }
    }
    return _topView;
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
    [ZOriganizationViewModel getMerchantsAccountDetailList:param completeBlock:^(BOOL isSuccess, ZStoresAccountBillListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            weakSelf.model = data;
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
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationViewModel getMerchantsAccountDetailList:self.param completeBlock:^(BOOL isSuccess, ZStoresAccountBillListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            weakSelf.model = data;
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
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.param setObject:SafeStr(self.stores_id) forKey:@"stores_id"];
    [self.param setObject:self.type forKey:@"type"];
    if ([self.type isEqualToString:@"0"]) {
        if (self.start_time) {
            [self.param setObject:self.start_time forKey:@"start_time"];
        }
        
        if (self.end_time) {
            [self.param setObject:self.end_time forKey:@"end_time"];
        }
    }
}
@end
