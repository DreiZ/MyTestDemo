//
//  ZStudentMineOrderListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderListVC.h"
#import "ZStudentMineOrderSubscribeListVC.h"
#import "ZStudentMineOrderBuyListVC.h"


@interface ZStudentMineOrderListVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *subscribeBtn;
@property (nonatomic,strong) UIButton *buyBtn;
@property (nonatomic,strong) ZStudentMineOrderBuyListVC *buyVC;
@property (nonatomic,strong) ZStudentMineOrderSubscribeListVC *subscribeListVC;

@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

@implementation ZStudentMineOrderListVC

- (void)loadView
{
    [super loadView];
    
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgation];
    self.view.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    
    [self.view addSubview:self.subscribeBtn];
    [self.subscribeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(88));
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(220));
        make.right.equalTo(self.view.mas_right);
    }];
    
    [self.view addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(88));
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(120));
        make.right.equalTo(self.view.mas_right);
    }];
}


#pragma mark - setView & setdata
- (void)initData {
    
    self.automaticallyCalculatesItemWidths = YES;
    self.titleColorSelected = KMainColor;
    self.titleColorNormal = KFont6Color;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleSizeSelected = CGFloatIn750(32);
    self.titleSizeNormal = CGFloatIn750(32);
    self.progressWidth = CGFloatIn750(140);
    self.progressViewIsNaughty = YES;
    self.scrollEnable = YES;
}

- (void)setNavgation {
    [self.navigationItem setTitle:@"订单"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"体验订单", @"购买订单"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        [_vcArr addObject:self.subscribeListVC];
        [_vcArr addObject:self.buyVC];
    }
    return _vcArr;
}

-(ZStudentMineOrderBuyListVC *)buyVC  {
    if (!_buyVC) {
        _buyVC = [[ZStudentMineOrderBuyListVC alloc] init];
    }
    
    return _buyVC;
}


-(ZStudentMineOrderSubscribeListVC *)subscribeListVC {
    if (!_subscribeListVC) {
        _subscribeListVC = [[ZStudentMineOrderSubscribeListVC alloc] init];
    }
    
    return _subscribeListVC;
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
    return CGRectMake(0, 0, KScreenWidth, CGFloatIn750(100));
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGFloatIn750(100);
    return CGRectMake(0, originY, KScreenWidth, KScreenHeight - originY-kStatusBarHeight);
}

@end



