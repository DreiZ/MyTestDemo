//
//  ZCircleViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleViewController.h"
#import "ZCircleRecommendVC.h"
#import "ZCircleFinderVC.h"
#import "ZCircleHeaderView.h"
#import "ZCircleMineVC.h"
#import "ZCircleMineCollectionVC.h"
#import "ZCircleSearchVC.h"
#import "ZCircleReleaseVC.h"


@interface ZCircleViewController ()

@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,strong) UIButton *releaseBtn;

@property (nonatomic,strong) ZCircleHeaderView *headView;

@end

@implementation ZCircleViewController

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"发现"), @"tabBarFinder", @"tabBarFinder_highlighted");
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMainView];
}

- (void)setMainView {
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(128));
        make.top.equalTo(self.menuView.mas_bottom);
    }];
    
    [self.view addSubview:self.releaseBtn];
    [self.releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(CGFloatIn750(88));
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight - CGFloatIn750(44));
    }];
    
    [self setSelectIndex:self.selectIndex];
}

#pragma mark - setView & setdata
- (void)initData {
    self.automaticallyCalculatesItemWidths = YES;
    self.titleColorSelected = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    self.titleColorNormal = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    self.titleSizeSelected = CGFloatIn750(32);
    self.titleSizeNormal = CGFloatIn750(28);
    self.menuViewContentMargin = CGFloatIn750(20);
    self.automaticallyCalculatesItemWidths = NO;
    self.progressWidth = CGFloatIn750(30);
    self.menuItemWidth = CGFloatIn750(160);
    self.progressColor = [UIColor colorMain];
    self.progressHeight = 3;
    self.progressViewIsNaughty = YES;
    self.scrollEnable = YES;
    self.selectIndex = 1;
}

- (void)setNavgation {
    [self.navigationItem setTitle:@"发现"];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"关注", @"推荐"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        ZCircleRecommendVC *rvc = [[ZCircleRecommendVC alloc] init];
        rvc.isAttention = YES;
        [_vcArr addObject:rvc];
        ZCircleRecommendVC *fvc = [[ZCircleRecommendVC alloc] init];
        [_vcArr addObject:fvc];
    }
    return _vcArr;
}

- (ZCircleHeaderView *)headView {
    if (!_headView) {
        __weak typeof(self) weakSelf = self;
        _headView = [[ZCircleHeaderView alloc] init];
        _headView.handleBlock = ^(NSInteger index) {
            if (index == 1) {
//                ZCircleMineVC *mvc = [[ZCircleMineVC alloc] init];
//                [weakSelf.navigationController pushViewController:mvc animated:YES];
                ZCircleMineCollectionVC *cvc = [[ZCircleMineCollectionVC alloc] init];
                [weakSelf.navigationController pushViewController:cvc animated:YES];
            }else {
//                ZCircleMineCollectionVC *cvc = [[ZCircleMineCollectionVC alloc] init];
//                cvc.account = @"1100005";
////                cvc.account = @"8100007";
//                [weakSelf.navigationController pushViewController:cvc animated:YES];
                ZCircleSearchVC *mvc = [[ZCircleSearchVC alloc] init];
                [weakSelf.navigationController pushViewController:mvc animated:YES];
            }
        };
    }
    return _headView;
}

- (UIButton *)releaseBtn {
    if (!_releaseBtn) {
        _releaseBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_releaseBtn setImage:[UIImage imageNamed:@"finderRelease"] forState:UIControlStateNormal];
        [_releaseBtn bk_addEventHandler:^(id sender) {
            ZCircleReleaseVC *rvc = [[ZCircleReleaseVC alloc] init];
            [self.navigationController pushViewController:rvc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _releaseBtn;
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
    return CGRectMake(0, safeAreaTop(), KScreenWidth, CGFloatIn750(80));
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGFloatIn750(80)+CGFloatIn750(128);
    return CGRectMake(0, originY+ safeAreaTop(), KScreenWidth, KScreenHeight - originY-TABBAR_HEIGHT-safeAreaTop()-safeAreaBottom());
}
@end
