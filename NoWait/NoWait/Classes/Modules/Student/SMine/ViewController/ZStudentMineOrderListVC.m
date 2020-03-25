//
//  ZStudentMineOrderListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderListVC.h"
#import "ZStudentMineOrderBuyListVC.h"

#import "ZOrganizationLessonTopSearchView.h"
#import "ZOrganizationSearchVC.h"

@interface ZStudentMineOrderListVC ()
@property (nonatomic,strong) ZOrganizationLessonTopSearchView *searchBtn;

@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

@implementation ZStudentMineOrderListVC

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
    [self.navigationItem setTitle:@"我的订单"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"全部", @"待付款", @"待评价", @"已完成"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        for (int i = 0; i < self.titleArr.count; i++) {
            ZStudentMineOrderBuyListVC *lvc =[[ZStudentMineOrderBuyListVC alloc] init];
            switch (i) {
                case 0:
                    lvc.type = ZStudentOrderTypeOrderForReceived;
                    break;
                case 1:
                    lvc.type = ZStudentOrderTypeForPay;
                    break;
                case 2:
                    lvc.type = ZStudentOrderTypeHadPay;
                    break;
                case 3:
                    lvc.type = ZStudentOrderTypeHadEva;
                    break;
                      
                default:
                    break;
            }
            [_vcArr addObject:lvc];
        }
    }
    return _vcArr;
}


- (ZOrganizationLessonTopSearchView *)searchBtn {
    if (!_searchBtn) {
        __weak typeof(self) weakSelf = self;
        _searchBtn = [[ZOrganizationLessonTopSearchView alloc] init];
        _searchBtn.title = @"搜索订单";
        _searchBtn.handleBlock = ^{
            ZOrganizationSearchVC *svc = [[ZOrganizationSearchVC alloc] init];
            svc.title = @"搜索订单";
            svc.searchType = ZSearchTypeStudentOrder;
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
