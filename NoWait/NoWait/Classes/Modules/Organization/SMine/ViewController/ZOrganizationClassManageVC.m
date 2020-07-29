//
//  ZOrganizationClassManageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassManageVC.h"
#import "ZOrganizationClassManageListVC.h"

#import "ZOrganizationLessonTopSearchView.h"
#import "ZOrganizationClassManageListSearchVC.h"

@interface ZOrganizationClassManageVC ()
@property (nonatomic,strong) ZOrganizationLessonTopSearchView *searchBtn;

@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

@implementation ZOrganizationClassManageVC

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
        make.height.mas_equalTo(CGFloatIn750(70));
        make.top.equalTo(self.view.mas_top);
        make.left.right.equalTo(self.view);
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
    [self.navigationItem setTitle:@"班级管理"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"全部", @"待开班", @"已开班", @"已结班"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        for (int i = 0; i < self.titleArr.count; i++) {
            ZOrganizationClassManageListVC *lvc =[[ZOrganizationClassManageListVC alloc] init];
            lvc.type = [NSString stringWithFormat:@"%d",i];
            [_vcArr addObject:lvc];
        }
    }
    return _vcArr;
}


- (ZOrganizationLessonTopSearchView *)searchBtn {
    if (!_searchBtn) {
        __weak typeof(self) weakSelf = self;
        _searchBtn = [[ZOrganizationLessonTopSearchView alloc] init];
        _searchBtn.handleBlock = ^{
            ZOrganizationClassManageListSearchVC *svc = [[ZOrganizationClassManageListSearchVC alloc] init];
            svc.navTitle = @"搜索班级名称";
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
    }
    return _searchBtn;
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
    return CGRectMake(0, CGFloatIn750(70), KScreenWidth, CGFloatIn750(106));
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGFloatIn750(106 + 70);
    return CGRectMake(0, originY, KScreenWidth, KScreenHeight - originY-kTopHeight);
}

@end

#pragma mark - RouteHandler
@interface ZOrganizationClassManageVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationClassManageVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_classManage;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationClassManageVC *routevc = [[ZOrganizationClassManageVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
