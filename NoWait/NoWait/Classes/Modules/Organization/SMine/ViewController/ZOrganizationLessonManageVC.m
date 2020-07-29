//
//  ZOrganizationLessonManageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonManageVC.h"
#import "ZOrganizationLessonManageListVC.h"

#import "ZOrganizationLessonTopSearchView.h"

@interface ZOrganizationLessonManageVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) ZOrganizationLessonTopSearchView *searchBtn;

@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

@implementation ZOrganizationLessonManageVC

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
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];

    [self.navigationItem setRightBarButtonItem:item];
    [self.navigationItem setTitle:@"课程管理"];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"全部", @"开放", @"未开放", @"审核失败"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        for (int i = 0; i < self.titleArr.count; i++) {
            ZOrganizationLessonManageListVC *lvc =[[ZOrganizationLessonManageListVC alloc] init];
            if (self.stores_id) {
                lvc.stores_id = self.stores_id;
            }
            switch (i) {
                case 0:
                    lvc.type = ZOrganizationLessonTypeAll;
                    break;
                case 1:
                    lvc.type = ZOrganizationLessonTypeOpen;
                break;
                case 2:
                    lvc.type = ZOrganizationLessonTypeClose;
                break;
                case 3:
                    lvc.type = ZOrganizationLessonTypeExamineFail;
                break;
                    
                default:
                    break;
            }
            [_vcArr addObject:lvc];
        }
    }
    return _vcArr;
}


- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(106), CGFloatIn750(48))];
        [_navLeftBtn setTitle:@"新增课程" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontContent]];
//        [_navLeftBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
//        ViewRadius(_navLeftBtn, CGFloatIn750(24));
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            routePushVC(ZRoute_org_lessonAdd, nil, nil);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}

- (ZOrganizationLessonTopSearchView *)searchBtn {
    if (!_searchBtn) {
        __weak typeof(self) weakSelf = self;
        _searchBtn = [[ZOrganizationLessonTopSearchView alloc] init];
        _searchBtn.title = @"搜索课程名称";
        _searchBtn.handleBlock = ^{
            routePushVC(ZRoute_org_lessonSearch, @{@"navTitle":@"搜索课程名称",@"stores_id":[ZUserHelper sharedHelper].school.schoolID}, nil);
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
    return CGRectMake(0, CGFloatIn750(78), KScreenWidth, CGFloatIn750(106));
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGFloatIn750(106 + 78);
    return CGRectMake(0, originY, KScreenWidth, KScreenHeight - originY-kTopHeight);
}

@end

#pragma mark - RouteHandler
@interface ZOrganizationLessonManageVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationLessonManageVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_lessonManage;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationLessonManageVC *routevc = [[ZOrganizationLessonManageVC alloc] init];
    routevc.stores_id = request.prts;
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end

