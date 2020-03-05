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

@interface ZOrganizationSchoolAccountListVC ()
@property (nonatomic,strong) ZOriganizationTopTitleView *topView;
@property (nonatomic,strong) UILabel *accountLabel;
@property (nonatomic,strong) UILabel *accountDetailLabel;

@end

@implementation ZOrganizationSchoolAccountListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
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
    [super setupMainView];
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
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
         make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
         make.bottom.equalTo(bottomView.mas_top).offset(-CGFloatIn750(0));
         make.top.equalTo(self.topView.mas_bottom).offset(CGFloatIn750(0));
    }];
}

#pragma mark - lazy loading...
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

@end
