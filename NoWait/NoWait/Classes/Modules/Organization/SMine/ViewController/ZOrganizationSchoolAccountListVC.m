//
//  ZOrganizationSchoolAccountListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSchoolAccountListVC.h"
#import "ZOrganizationAccountSchoolListCell.h"
#import "ZOriganizationTopTitleView.h"

@interface ZOrganizationSchoolAccountListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) ZOriganizationTopTitleView *topView;
@property (nonatomic,strong) UILabel *accountLabel;
@property (nonatomic,strong) UILabel *accountDetailLabel;


@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZOrganizationSchoolAccountListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self initCellConfigArr];
    [self setupMainView];
    [self.iTableView reloadData];
}

- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAccountSchoolListCell className] title:[ZOrganizationAccountSchoolListCell className] showInfoMethod:nil heightOfCell:[ZOrganizationAccountSchoolListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"账户信息"];
}

- (void)setupMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    
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
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
         make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
         make.bottom.equalTo(bottomView.mas_top).offset(-CGFloatIn750(0));
         make.top.equalTo(self.topView.mas_bottom).offset(CGFloatIn750(0));
    }];
}



#pragma mark - lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _iTableView;
}

- (ZOriganizationTopTitleView *)topView {
    if (!_topView) {
        _topView = [[ZOriganizationTopTitleView alloc] init];
        _topView.titleArr = @[@"转账金额",@"质押金",@"手续费",@"到账金额"];
    }
    return _topView;
}

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _accountLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _accountLabel.text = @"收款信息：023509230598023";
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
        _accountDetailLabel.text = @"账户信息：阿搜狗还是狗效果";
        _accountDetailLabel.numberOfLines = 1;
        _accountDetailLabel.textAlignment = NSTextAlignmentLeft;
        [_accountDetailLabel setFont:[UIFont fontContent]];
    }
    return _accountDetailLabel;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    
    return cell;
}

#pragma mark - tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"openTime"]) {
        
    }
}

#pragma mark - vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isHidenNaviBar = NO;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end












