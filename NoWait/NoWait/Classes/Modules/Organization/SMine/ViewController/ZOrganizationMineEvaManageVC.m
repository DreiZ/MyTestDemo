//
//  ZOrganizationMineEvaManageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineEvaManageVC.h"
#import "ZOrganizationMineEvaListVC.h"


@interface ZOrganizationMineEvaManageVC ()

@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

@implementation ZOrganizationMineEvaManageVC

- (void)loadView
{
    [super loadView];
    
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgation];
    
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
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
    [self.navigationItem setTitle:@"评价管理"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"待回复", @"已回复"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        for (int i = 0; i < 2; i++) {
            ZOrganizationMineEvaListVC *evc = [[ZOrganizationMineEvaListVC alloc] init];
            [_vcArr addObject:evc];
        }
    }
    return _vcArr;
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




