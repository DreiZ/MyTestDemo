//
//  ZOrganizationCardMainVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardMainVC.h"
#import "ZOrganizationCardListVC.h"
#import "ZOrganizationCardAddVC.h"
#import "ZOrganizationCardSendVC.h"
#import "ZOrganizationSearchCouponVC.h"
#import "ZOrganizationLessonTopSearchView.h"



@interface ZOrganizationCardMainVC ()
@property (nonatomic,strong) ZOrganizationLessonTopSearchView *searchBtn;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

@implementation ZOrganizationCardMainVC

- (void)loadView
{
    [super loadView];
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgation];
    
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.view addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(78));
        make.top.equalTo(self.view.mas_top);
        make.left.right.equalTo(self.view);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.sendBtn];
    [self.bottomView addSubview:self.addBtn];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView.mas_centerX);
    }];

    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.top.bottom.equalTo(self.bottomView);
         make.left.equalTo(self.bottomView.mas_centerX);
    }];

    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
    [self.bottomView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(self.bottomView.mas_centerX);
         make.centerY.equalTo(self.bottomView.mas_centerY);
         make.height.mas_equalTo(CGFloatIn750(26));
         make.width.mas_equalTo(2);
    }];

    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.equalTo(self.view);
         make.height.mas_equalTo(CGFloatIn750(88));
         make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
    }];
}


#pragma mark - setView & setdata
- (void)initData {
    self.automaticallyCalculatesItemWidths = YES;
    self.titleColorSelected = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    self.titleColorNormal = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleSizeSelected = CGFloatIn750(28);
    self.titleSizeNormal = CGFloatIn750(28);
    self.progressWidth = CGFloatIn750(30);
    self.progressViewIsNaughty = YES;
    self.scrollEnable = YES;
}

- (void)setNavgation {
    [self.navigationItem setTitle:@"卡券管理"];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"可用卡券", @"停用卡券"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        for (int i = 0; i < self.titleArr.count; i++) {
            ZOrganizationCardListVC *lvc =[[ZOrganizationCardListVC alloc] init];
            lvc.status = [NSString stringWithFormat:@"%d",i+1];
            [_vcArr addObject:lvc];
        }
    }
    return _vcArr;
}


- (ZOrganizationLessonTopSearchView *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [[ZOrganizationLessonTopSearchView alloc] init];
        _searchBtn.title = @"搜索卡券";
        __weak typeof(self) weakSelf = self;
        _searchBtn.handleBlock = ^{
            ZOrganizationSearchCouponVC *svc = [[ZOrganizationSearchCouponVC alloc] init];
            svc.title = @"搜索卡券";
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
    }
    return _searchBtn;
}


- (UIButton *)addBtn {
    if (!_addBtn) {
        __weak typeof(self) weakSelf = self;
        _addBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_addBtn setTitle:@"添加卡券" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_addBtn.titleLabel setFont:[UIFont fontContent]];
        [_addBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_addBtn bk_addEventHandler:^(id sender) {
            ZOrganizationCardAddVC *avc = [[ZOrganizationCardAddVC alloc] init];
            [weakSelf.navigationController pushViewController:avc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}


- (UIButton *)sendBtn {
    if (!_sendBtn) {
        __weak typeof(self) weakSelf = self;
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_sendBtn setTitle:@"赠送卡券" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:[UIFont fontContent]];
        [_sendBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_sendBtn bk_addEventHandler:^(id sender) {
            ZOrganizationCardSendVC *svc = [[ZOrganizationCardSendVC alloc] init];
            [weakSelf.navigationController pushViewController:svc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.layer.masksToBounds = YES;
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }
    return _bottomView;
}


#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.vcArr.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return self.vcArr[index];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titleArr[index];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, CGFloatIn750(78), KScreenWidth, CGFloatIn750(106));
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGFloatIn750(106 + 78);
    return CGRectMake(0, originY, KScreenWidth, KScreenHeight - originY-kTopHeight-CGFloatIn750(88)-safeAreaBottom());
}

@end




