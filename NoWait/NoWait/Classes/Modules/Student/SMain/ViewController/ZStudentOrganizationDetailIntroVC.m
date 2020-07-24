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
@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,assign) int index;
@end

@implementation ZStudentOrganizationDetailIntroVC

- (void)dealloc {
    DLog(@"dealloc----ZStudentOrganizationDetailIntroVC ");
}

- (instancetype)initWithTitle:(NSArray *)titleArr {
    self = [super init];
    if (self) {
        self.imageArr = titleArr;
    }
    return self;
}

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
    self.selectIndex = _index;
}


#pragma mark - setView & setdata
- (void)initData {
    self.automaticallyCalculatesItemWidths = YES;
    self.titleColorSelected = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    self.titleColorNormal = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleSizeSelected = CGFloatIn750(28);
    self.titleSizeNormal = CGFloatIn750(26);
    self.progressWidth = CGFloatIn750(40);
    self.progressColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    self.progressViewIsNaughty = YES;
    self.scrollEnable = YES;
}

- (void)setNavgation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"详情"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 懒加载--
- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        _titleArr = @[].mutableCopy;
        _index = 0;
        for (int i = 0; i < self.imageArr.count; i++) {
            ZImagesModel *model = self.imageArr[i];
            if ([model.type isEqualToString:self.imageModel.type]) {
                _index = i;
            }
            ZStudentOrganizationDetailIntroListVC *lvc = [[ZStudentOrganizationDetailIntroListVC alloc] init];
            lvc.imageModel = model;
            lvc.detailModel = self.detailModel;
            [_vcArr addObject:lvc];
            [_titleArr addObject:SafeStr(model.name)];
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

