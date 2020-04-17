//
//  ZOrganizationSchoolAccountDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSchoolAccountDetailVC.h"
#import "ZOrganizationAccountSchoolListCell.h"
#import "ZOriganizationViewModel.h"

@interface ZOrganizationSchoolAccountDetailVC ()
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) UILabel *accountLabel;
@property (nonatomic,strong) UILabel *accountDetailLabel;
@property (nonatomic,strong) ZStoresAccountDetaliListNetModel *model;

@end

@implementation ZOrganizationSchoolAccountDetailVC

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
    
    [self.dataSources enumerateObjectsUsingBlock:^(ZStoresAccountDetaliListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAccountSchoolListCell className] title:[ZOrganizationAccountSchoolListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationAccountSchoolListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:obj];
        [self.cellConfigArr addObject:topCellConfig];
    }];
    
    self.accountLabel.text = [NSString stringWithFormat:@"收款账户：%@",self.model.cart_number];
    self.accountDetailLabel.text = [NSString stringWithFormat:@"账户信息：%@",self.model.mechanism_name];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"已打款"];//已打款详情
}

- (void)setupMainView {
    [super setupMainView];
     
     UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
     bottomView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
     UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
     bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
     [bottomView addSubview:bottomLineView];
     [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.equalTo(bottomView);
         make.centerY.equalTo(bottomView.mas_centerY);
         make.height.mas_equalTo(0.5);
     }];
 
     [bottomView addSubview:self.accountLabel];
     [bottomView addSubview:self.accountDetailLabel];
     [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(30));
         make.centerY.equalTo(bottomView.mas_bottom).multipliedBy(1/4.0);
     }];
 
     [self.accountDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(30));
         make.centerY.equalTo(bottomView.mas_bottom).multipliedBy(3/4.0);
     }];
 
     [self.view addSubview:bottomView];
     [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.equalTo(self.view);
         make.height.mas_equalTo(CGFloatIn750(182));
         make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(40));
     }];
    
     [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.bottom.equalTo(bottomView.mas_top).offset(CGFloatIn750(0));
         make.left.right.top.equalTo(self.view);
     }];
}

#pragma mark - lazy loading
- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _accountLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _accountLabel.text = @"收款账户：";
        _accountLabel.numberOfLines = 1;
        _accountLabel.textAlignment = NSTextAlignmentLeft;
        [_accountLabel setFont:[UIFont fontContent]];
    }
    return _accountLabel;
}

- (UILabel *)accountDetailLabel {
    if (!_accountDetailLabel) {
        _accountDetailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _accountDetailLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _accountDetailLabel.text = @"账户信息：";
        _accountDetailLabel.numberOfLines = 1;
        _accountDetailLabel.textAlignment = NSTextAlignmentLeft;
        [_accountDetailLabel setFont:[UIFont fontContent]];
    }
    return _accountDetailLabel;
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
    [ZOriganizationViewModel getMerchantsAccountList:param completeBlock:^(BOOL isSuccess, ZStoresAccountDetaliListNetModel *data) {
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
    [ZOriganizationViewModel getMerchantsAccountList:self.param completeBlock:^(BOOL isSuccess, ZStoresAccountDetaliListNetModel *data) {
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
}
@end

