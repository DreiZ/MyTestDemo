//
//  ZStudentOrganizationDetailIntroVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailIntroVC.h"
#import "ZStudentOrganizationDetailIntroListVC.h"

@interface ZStudentOrganizationDetailIntroVC ()


@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

@implementation ZStudentOrganizationDetailIntroVC

- (void)loadView
{
    [super loadView];
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isHidenNaviBar = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self setNavgation];
}


#pragma mark - setView & setdata
- (void)initData {
    
    self.automaticallyCalculatesItemWidths = YES;
    self.titleColorSelected = [UIColor colorTextBlack];
    self.titleColorNormal = [UIColor colorTextGray];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleSizeSelected = CGFloatIn750(24);
    self.titleSizeNormal = CGFloatIn750(24);
    self.progressWidth = CGFloatIn750(40);
    self.progressColor = [UIColor colorMain];
    self.progressViewIsNaughty = YES;
    self.scrollEnable = YES;
}

- (void)setNavgation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"才玩俱乐部"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"店内环境", @"商家资质", @"明星教师", @"优秀学员"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        for (NSString *text in self.titleArr) {
            ZStudentOrganizationDetailIntroListVC *lvc = [[ZStudentOrganizationDetailIntroListVC alloc] init];
            [_vcArr addObject:lvc];
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
    return CGRectMake(0, originY, KScreenWidth, KScreenHeight - originY-kTopHeight);
}

@end

