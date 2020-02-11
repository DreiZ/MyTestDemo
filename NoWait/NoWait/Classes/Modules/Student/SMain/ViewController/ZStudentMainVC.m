//
//  ZStudentMainVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainVC.h"
#import "ZStudentMainTopSearchView.h"
#import "ZUserHelper.h"

#import "ZStudentBannerCell.h"
#import "ZStudentMainEnteryCell.h"
#import "ZStudentMainPhotoWallCell.h"
#import "ZStudentMainOrganizationListCell.h"
#import "ZStudentMainFiltrateSectionView.h"

#import "ZStudentOrganizationDetailVC.h"


#import "ZPhoneAlertView.h"
#import "ZServerCompleteAlertView.h"
#import "ZAlertUpdateAppView.h"
#import "ZAlertView.h"
#import "ZAlertImageView.h"

#define KSearchTopViewHeight  CGFloatIn750(88)

@interface ZStudentMainVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) ZStudentMainTopSearchView *searchView;
@property (nonatomic,strong) ZStudentMainFiltrateSectionView *sectionView;

@property (nonatomic,strong) NSMutableArray <NSArray *>*cellConfigArr;
@property (nonatomic,strong) NSMutableArray *enteryArr;
@property (nonatomic,strong) NSMutableArray *photoWallArr;

@end

@implementation ZStudentMainVC

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"首页"), @"record_normal", @"record_highlighted");
        self.analyzeTitle = @"首页";
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [ZUserHelper sharedHelper].user.nikeName;
    [self setData];
    [self setupMainView];
}


- (void)setData {
    _cellConfigArr = @[].mutableCopy;
    _enteryArr = @[].mutableCopy;
    _photoWallArr = @[].mutableCopy;
    
    NSArray *entryArr = @[@[@"体育竞技",@"studentMainSports"],@[@"艺术舞蹈",@"studentMainArt"],@[@"兴趣爱好",@"studentMainHobby"],@[@"其他",@"studentMainMore"],@[@"体育竞技",@"studentMainSports"],@[@"艺术舞蹈",@"studentMainArt"],@[@"兴趣爱好",@"studentMainHobby"],@[@"其他",@"studentMainMore"]];
    
    for (int i = 0; i < entryArr.count; i++) {
        ZStudentEnteryItemModel *model = [[ZStudentEnteryItemModel alloc] init];
        model.imageName = entryArr[i][1];
        model.name = entryArr[i][0];
        [_enteryArr addObject:model];
        
    }
    
    for (int i = 0; i < 2; i++) {
        ZStudentPhotoWallItemModel *photoWallModel = [[ZStudentPhotoWallItemModel alloc] init];
        photoWallModel.imageName = @"serverTopbg";
        [_photoWallArr addObject:photoWallModel];
    }
    
    [self resetData];
}


- (void)resetData {
    [_cellConfigArr removeAllObjects];
    NSMutableArray *sectionArr = @[].mutableCopy;
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentBannerCell className] title:@"ZStudentBannerCell" showInfoMethod:nil heightOfCell:[ZStudentBannerCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [sectionArr addObject:topCellConfig];
    
    ZCellConfig *enteryCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainEnteryCell className] title:@"ZStudentMainEnteryCell" showInfoMethod:@selector(setChannelList:) heightOfCell:[ZStudentMainEnteryCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:_enteryArr];
    [sectionArr addObject:enteryCellConfig];
    
    ZCellConfig *photoWallCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainPhotoWallCell className] title:@"ZStudentMainPhotoWallCell" showInfoMethod:@selector(setChannelList:) heightOfCell:[ZStudentMainPhotoWallCell z_getCellHeight:_photoWallArr] cellType:ZCellTypeClass dataModel:_photoWallArr];
    [sectionArr addObject:photoWallCellConfig];
    
    [_cellConfigArr addObject:sectionArr];
    
    
    NSMutableArray *section1Arr = @[].mutableCopy;
    ZCellConfig *photoWallCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationListCell className] title:@"ZStudentMainOrganizationListCell" showInfoMethod:nil heightOfCell:[ZStudentMainOrganizationListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    [section1Arr addObject:photoWallCellCon1fig];
    
    [_cellConfigArr addObject:section1Arr]; 
}

- (void)setupMainView {
    self.view.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K2eBackColor);
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(KSearchTopViewHeight + kStatusBarHeight);
    }];
    
    
    [self.view addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
}

#pragma mark - lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.showsHorizontalScrollIndicator = NO;
        _iTableView.showsVerticalScrollIndicator = NO;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _iTableView.backgroundColor = KAdaptAndDarkColor(KBackColor, K2eBackColor);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        
    }
    return _iTableView;
}

- (ZStudentMainTopSearchView *)searchView {
    if (!_searchView) {
//        __weak typeof(self) weakSelf = self;
        _searchView = [[ZStudentMainTopSearchView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KSearchTopViewHeight+kStatusBarHeight)];
    }
    return _searchView;
}

- (ZStudentMainFiltrateSectionView *)sectionView {
    if (!_sectionView) {
        __weak typeof(self) weakSelf = self;
        _sectionView = [[ZStudentMainFiltrateSectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88))];
        _sectionView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, KLineColor);
        _sectionView.titleSelect = ^(NSInteger index) {
            if (weakSelf.iTableView.contentOffset.y < [ZStudentBannerCell z_getCellHeight:nil] + [ZStudentMainEnteryCell z_getCellHeight:self.enteryArr] + [ZStudentMainPhotoWallCell z_getCellHeight:self.photoWallArr]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.iTableView setContentOffset:CGPointMake(0, [ZStudentBannerCell z_getCellHeight:nil] + [ZStudentMainEnteryCell z_getCellHeight:weakSelf.enteryArr] + [ZStudentMainPhotoWallCell z_getCellHeight:weakSelf.photoWallArr]) animated:YES];
                });
                
            }
        };
    }
    return _sectionView;
}


#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cellConfigArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr[section].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr[indexPath.section] objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];

    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.section][indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return CGFloatIn750(88);
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section) {
        return self.sectionView;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [ZAlertImageView setAlertWithType:ZAlertTypeRepealSubscribeFail handlerBlock:^(NSInteger index) {
//        
//    }];
//
//    return;
//    [ZPhoneAlertView setAlertName:@"哈哈哈" detail:@"十多个哈啊烦得很" headImage:@"coachSelect1" tel:@"1882111232" handlerBlock:^(NSInteger index) {
//
//    }];
//    return;
//    [ZServerCompleteAlertView setAlertWithHandlerBlock:^(NSInteger index) {
//
//    }];
//    return;
//    [ZAlertView setAlertWithTitle:@"放顶顶顶" btnTitle:@"确定" handlerBlock:^(NSInteger index) {
//
//    }];
//    return;
    if (indexPath.section == 1) {
        ZStudentOrganizationDetailVC *dvc = [[ZStudentOrganizationDetailVC alloc] init];
        
        [self.navigationController pushViewController:dvc animated:YES];
    }
}



#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
   
    [self.searchView updateWithOffset:Offset_y];
}


#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
    [self setupDarkModel];
}

#pragma mark - setupDarkModel
- (void)setupDarkModel{
    if ([DarkModel isDarkMode]) {
//        [self darkType];
    }else{
//        [self lightType];
    }
}


// darkType
- (void)darkType{
    //Dark 模式(黑夜)
}

// lightType
- (void)lightType{
     //Light 模式(白天)
}

@end
