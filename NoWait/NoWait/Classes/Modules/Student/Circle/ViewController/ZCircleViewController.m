//
//  ZCircleViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleViewController.h"
#import "ZCircleRecommendVC.h"
#import "ZCircleHeaderView.h"

@interface ZCircleViewController ()

@property (nonatomic,strong) NSMutableArray *vcArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,strong) UIButton *releaseBtn;

@property (nonatomic,strong) ZCircleRecommendVC *minRvc;
@property (nonatomic,strong) ZCircleRecommendVC *recommondRvc;

@property (nonatomic,strong) ZCircleHeaderView *headView;

@end

@implementation ZCircleViewController

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"发现"), @"tabBarFinder", @"tabBarFinder_highlighted");
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_headView) {
        [_headView updateData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMainView];
}

- (void)setMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(128));
        make.top.equalTo(self.menuView.mas_bottom);
    }];
    
    [self.view addSubview:self.releaseBtn];
    [self.releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(CGFloatIn750(88));
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight - CGFloatIn750(44));
    }];
    
    [self setSelectIndex:self.selectIndex];
}

#pragma mark - setView & setdata
- (void)initData {
    self.automaticallyCalculatesItemWidths = YES;
    self.titleColorSelected = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    self.titleColorNormal = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    self.titleSizeSelected = CGFloatIn750(32);
    self.titleSizeNormal = CGFloatIn750(28);
    self.menuViewContentMargin = CGFloatIn750(20);
    self.automaticallyCalculatesItemWidths = NO;
    self.progressWidth = CGFloatIn750(30);
    self.menuItemWidth = CGFloatIn750(160);
    self.progressColor = [UIColor colorMain];
    self.progressHeight = 3;
    self.progressViewIsNaughty = YES;
    self.scrollEnable = YES;
    self.selectIndex = 1;
}

- (void)setNavgation {
    [self.navigationItem setTitle:@"发现"];
}

#pragma mark - 懒加载--
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"关注", @"发现"].mutableCopy;
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr {
    if (!_vcArr) {
        _vcArr = @[].mutableCopy;
        _minRvc = [[ZCircleRecommendVC alloc] init];
        _minRvc.isAttention = YES;
        [_vcArr addObject:_minRvc];
        _recommondRvc = [[ZCircleRecommendVC alloc] init];
        [_vcArr addObject:_recommondRvc];
    }
    return _vcArr;
}

- (ZCircleHeaderView *)headView {
    if (!_headView) {
        _headView = [[ZCircleHeaderView alloc] init];
        _headView.handleBlock = ^(NSInteger index) {
            if (index == 1) {
                [[ZUserHelper sharedHelper] checkLogin:^{
                    routePushVC(ZRoute_circle_mine, @{@"id":SafeStr([ZUserHelper sharedHelper].user.userCodeID)}, nil);
                }];
            }else {
                routePushVC(ZRoute_circle_search, nil, nil);
            }
        };
    }
    return _headView;
}

- (UIButton *)releaseBtn {
    if (!_releaseBtn) {
        __weak typeof(self) weakSelf = self;
        _releaseBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_releaseBtn setImage:[UIImage imageNamed:@"finderRelease"] forState:UIControlStateNormal];
        [_releaseBtn bk_addEventHandler:^(id sender) {
            [[ZUserHelper sharedHelper] checkLogin:^{
                [[ZImagePickerManager sharedManager] setPhotoWithMaxCount:9 SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                    [weakSelf pickList:list];
                }];
            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _releaseBtn;
}


- (void)pickList:(NSArray<ZImagePickerModel *> *)list {
    if (list && list.count > 0){
        NSMutableArray *selectImageArr = @[].mutableCopy;
        for (ZImagePickerModel *model in list) {
            ZFileUploadDataModel *dataModel = [[ZFileUploadDataModel alloc] init];
            if (model.isVideo) {
                dataModel.image = model.image;
                dataModel.taskType = ZUploadTypeVideo;
                dataModel.asset = model.asset;
                dataModel.taskState = ZUploadStateWaiting;
//                            dataModel.filePath = [model.mediaURL absoluteString];
            }else{
                dataModel.image = model.image;
                dataModel.asset = model.asset;
                dataModel.taskType = ZUploadTypeImage;
                dataModel.taskState = ZUploadStateWaiting;
            }

            [selectImageArr addObject:dataModel];
        }
        routePushVC(ZRoute_circle_release, selectImageArr, nil);
    }
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
    return CGRectMake(0, safeAreaTop(), KScreenWidth, CGFloatIn750(80));
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGFloatIn750(80)+CGFloatIn750(128);
    return CGRectMake(0, originY+ safeAreaTop(), KScreenWidth, KScreenHeight - originY-TABBAR_HEIGHT-safeAreaTop()-safeAreaBottom());
}

#pragma mark - tabbar
- (void)tabBarItemDidClick:(BOOL)isSelected {
    if (isSelected) {
        if (self.selectIndex == 0 && _minRvc) {
            [_minRvc.iCollectionView scrollToTopAnimated:YES];
        }else if (self.selectIndex == 1 && _recommondRvc) {
            [_recommondRvc.iCollectionView scrollToTopAnimated:YES];
        }
    }
}
@end
