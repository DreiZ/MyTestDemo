//
//  ZStudentMineEvaListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineEvaListVC.h"
#import "ZStudentMineEvaListNoVC.h"
#import "ZStudentMineEvaListHadVC.h"


@interface ZStudentMineEvaListVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *subscribeBtn;
@property (nonatomic,strong) UIButton *buyBtn;
@property (nonatomic,strong) ZStudentMineEvaListNoVC *noEvaVC;
@property (nonatomic,strong) ZStudentMineEvaListHadVC *hadEvaVC;

@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

@implementation ZStudentMineEvaListVC

- (void)loadView
{
    [super loadView];
    
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgation];
    
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
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
    self.titleColorSelected = [UIColor  colorMain];
    self.titleColorNormal = [UIColor colorTextGray];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleSizeSelected = CGFloatIn750(32);
    self.titleSizeNormal = CGFloatIn750(32);
    self.progressWidth = CGFloatIn750(140);
    self.progressViewIsNaughty = YES;
    self.scrollEnable = YES;
}

- (void)setNavgation {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];

    [self.navigationItem setTitle:@"评价"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"已评价", @"待评价"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        [_vcArr addObject:self.hadEvaVC];
        [_vcArr addObject:self.noEvaVC];
    }
    return _vcArr;
}

-(ZStudentMineEvaListNoVC *)noEvaVC  {
    if (!_noEvaVC) {
        _noEvaVC = [[ZStudentMineEvaListNoVC alloc] init];
    }
    
    return _noEvaVC;
}


-(ZStudentMineEvaListHadVC *)hadEvaVC {
    if (!_hadEvaVC) {
        _hadEvaVC = [[ZStudentMineEvaListHadVC alloc] init];
    }
    
    return _hadEvaVC;
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


