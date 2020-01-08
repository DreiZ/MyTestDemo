//
//  ZStudentOrganizationDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailVC.h"
#import "ZStudentOrganizationDetailDesVC.h"
#import "ZStudentOrganizationDetailCoachVC.h"
#import "ZStudentOrganizationDetailQualificationVC.h"

@interface ZStudentOrganizationDetailVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) ZStudentOrganizationDetailQualificationVC *qualificationVC;
@property (nonatomic,strong) ZStudentOrganizationDetailDesVC *desVC;
@property (nonatomic,strong) ZStudentOrganizationDetailCoachVC *coachVC;
@property (nonatomic,strong) ZStudentOrganizationDetailCoachVC *studentVC;

@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

@implementation ZStudentOrganizationDetailVC

- (void)loadView
{
    [super loadView];
    
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgation];
}


#pragma mark - setView & setdata
- (void)initData {
    
    self.automaticallyCalculatesItemWidths = YES;
    self.titleColorSelected = KMainColor;
    self.titleColorNormal = KFont6Color;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleSizeSelected = CGFloatIn750(28);
    self.titleSizeNormal = CGFloatIn750(28);
    self.progressWidth = CGFloatIn750(140);
    self.progressViewIsNaughty = YES;
    self.scrollEnable = YES;
}

- (void)setNavgation {
    self.isHidenNaviBar = NO;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];

    [self.navigationItem setLeftBarButtonItem:item];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - lazying --
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"环境", @"资质", @"教练", @"学员"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        [_vcArr addObject:self.desVC];
        [_vcArr addObject:self.qualificationVC];
        [_vcArr addObject:self.coachVC];
        [_vcArr addObject:self.studentVC];
    }
    return _vcArr;
}


- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_navLeftBtn setTitle:@"财源俱乐部" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:KFont2Color forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(36)]];
        [_navLeftBtn setImage:[UIImage imageNamed:@"mineLessonLeft"] forState:UIControlStateNormal];
        [_navLeftBtn bk_whenTapped:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _navLeftBtn;
}

-(ZStudentOrganizationDetailDesVC *)desVC {
    if (!_desVC) {
        _desVC = [[ZStudentOrganizationDetailDesVC alloc] init];
    }
    
    return _desVC;
}


-(ZStudentOrganizationDetailQualificationVC *)qualificationVC {
    if (!_qualificationVC) {
        _qualificationVC = [[ZStudentOrganizationDetailQualificationVC alloc] init];
    }
    
    return _qualificationVC;
}


-(ZStudentOrganizationDetailCoachVC *)coachVC {
    if (!_coachVC) {
        _coachVC = [[ZStudentOrganizationDetailCoachVC alloc] init];
    }
    
    return _coachVC;
}

-(ZStudentOrganizationDetailCoachVC *)studentVC {
    if (!_studentVC) {
        _studentVC = [[ZStudentOrganizationDetailCoachVC alloc] init];
    }
    
    return _studentVC;
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
    return CGRectMake(0, originY, KScreenWidth, KScreenHeight - originY);
}


@end
