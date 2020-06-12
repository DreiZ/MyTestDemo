//
//  ZOrganizationTeachingScheduleVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeachingScheduleVC.h"
#import "ZOrganizationTeachingScheduleNoVC.h"
#import "ZOrganizationLessonTopSearchView.h"
#import "ZOrganizationSearchTeachingScheduleVC.h"

@interface ZOrganizationTeachingScheduleVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) ZOrganizationLessonTopSearchView *searchBtn;

@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

@implementation ZOrganizationTeachingScheduleVC

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
    [self.navigationItem setTitle:@"排课管理"];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"全部", @"未排课", @"待补课"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        __weak typeof(self) weakSelf = self;
        _vcArr = @[].mutableCopy;
        for (int i = 0; i < self.titleArr.count; i++) {
            ZOrganizationTeachingScheduleNoVC *nvc = [[ZOrganizationTeachingScheduleNoVC alloc] init];
            nvc.stores_courses_id = self.stores_courses_id;
            nvc.type = i;
            nvc.lessonModel = self.lessonModel;
            nvc.editChangeBlock = ^(BOOL isEdit) {
                if (isEdit) {
                    [weakSelf.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:weakSelf.navLeftBtn]];
                }else{
                    [weakSelf.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]]];
                }
            };
            
            [_vcArr addObject:nvc];
        };
    }
    return _vcArr;
}

- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontContent]];
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            ZOrganizationTeachingScheduleNoVC *nvc = weakSelf.vcArr[weakSelf.selectIndex];
            if (nvc) {
                nvc.isEdit = NO;
                [weakSelf.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]]];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}

- (ZOrganizationLessonTopSearchView *)searchBtn {
    if (!_searchBtn) {
        __weak typeof(self) weakSelf = self;
        _searchBtn = [[ZOrganizationLessonTopSearchView alloc] init];
        _searchBtn.title = @"搜索学员";
        _searchBtn.handleBlock = ^{
            ZOrganizationSearchTeachingScheduleVC *svc = [[ZOrganizationSearchTeachingScheduleVC alloc] init];
            svc.title = @"搜索学员";
            svc.stores_courses_id = weakSelf.stores_courses_id;
            svc.type = weakSelf.selectIndex;
            svc.lessonModel = weakSelf.lessonModel;
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
    if (self.selectIndex == 0) {
        _searchBtn.title = @"搜索未排课学员";
    }else {
        _searchBtn.title = @"搜索待补课学员";
    }
    
    BOOL isEdit = NO;
    ZOrganizationTeachingScheduleNoVC *vc = self.vcArr[self.selectIndex];
    if (vc) {
        isEdit = vc.isEdit;
    }
    
    if (isEdit) {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]];
    }else{
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]]];
    }
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
