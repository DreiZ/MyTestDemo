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
#import "ZStudentOrganizationDetailVideoVC.h"

#import "ZStudentLessonSelectMainView.h"
#import "ZStudentLessonSureOrderVC.h"
#import "ZStudentLessonSubscribeSureOrderVC.h"

@interface ZStudentOrganizationDetailVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *subscribeBtn;
@property (nonatomic,strong) UIButton *buyBtn;
@property (nonatomic,strong) ZStudentOrganizationDetailQualificationVC *qualificationVC;
@property (nonatomic,strong) ZStudentOrganizationDetailDesVC *desVC;
@property (nonatomic,strong) ZStudentOrganizationDetailCoachVC *coachVC;
@property (nonatomic,strong) ZStudentOrganizationDetailVideoVC *studentVC;

@property (nonatomic,strong) ZStudentLessonSelectMainView *selectView;


@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@end

@implementation ZStudentOrganizationDetailVC

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
    
    [self setNavgation];
    
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
    self.isHidenNaviBar = NO;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
    
    [self.navigationItem setLeftBarButtonItem:item];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"环境", @"资质", @"教练", @"视频"].mutableCopy;
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
        [_navLeftBtn setTitleColor:KAdaptAndDarkColor(KBlackColor, KWhiteColor) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(36)]];
        [_navLeftBtn setImage:KIsDarkModel ? [UIImage imageNamed:@"leftWhiteArrow"] : [UIImage imageNamed:@"mineLessonLeft"] forState:UIControlStateNormal];
        [_navLeftBtn bk_whenTapped:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _navLeftBtn;
}

- (UIButton *)subscribeBtn {
    if (!_subscribeBtn) {
        __weak typeof(self) weakSelf = self;
        _subscribeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _subscribeBtn.layer.masksToBounds = YES;
        _subscribeBtn.layer.cornerRadius = CGFloatIn750(44);
        _subscribeBtn.backgroundColor = KMainColor;
        [_subscribeBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(32)]];
        [_subscribeBtn setTitle:@"体验" forState:UIControlStateNormal];
        [_subscribeBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_subscribeBtn bk_whenTapped:^{
            [weakSelf.selectView showSelectViewWithType:ZLessonBuyTypeSubscribeInitial];
        }];
    }
    return _subscribeBtn;
}


- (UIButton *)buyBtn {
    if (!_buyBtn) {
        __weak typeof(self) weakSelf = self;
        _buyBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _buyBtn.layer.masksToBounds = YES;
        _buyBtn.layer.cornerRadius = CGFloatIn750(44);
        _buyBtn.backgroundColor = KMainColor;
        [_buyBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(32)]];
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_buyBtn bk_whenTapped:^{
            [weakSelf.selectView showSelectViewWithType:ZLessonBuyTypeBuyInitial];
        }];
    }
    return _buyBtn;
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

-(ZStudentOrganizationDetailVideoVC *)studentVC {
    if (!_studentVC) {
        _studentVC = [[ZStudentOrganizationDetailVideoVC alloc] init];
    }
    
    return _studentVC;
}


- (ZStudentLessonSelectMainView *)selectView {
    if (!_selectView) {
        __weak typeof(self) weakSelf = self;
        _selectView = [[ZStudentLessonSelectMainView alloc] init];
        _selectView.completeBlock = ^(ZLessonBuyType type) {
            if (type == ZLessonBuyTypeBuyInitial || type == ZLessonBuyTypeBuyBeginLesson) {
                ZStudentLessonSureOrderVC *order = [[ZStudentLessonSureOrderVC alloc] init];
                [weakSelf.navigationController pushViewController:order animated:YES];
            }else{
                ZStudentLessonSubscribeSureOrderVC *order = [[ZStudentLessonSubscribeSureOrderVC alloc] init];
                [weakSelf.navigationController pushViewController:order animated:YES];
            }
        };
    }
    return _selectView;
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



#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    [_navLeftBtn setImage:KIsDarkModel ? [UIImage imageNamed:@"leftWhiteArrow"] : [UIImage imageNamed:@"mineLessonLeft"] forState:UIControlStateNormal];
}

@end
