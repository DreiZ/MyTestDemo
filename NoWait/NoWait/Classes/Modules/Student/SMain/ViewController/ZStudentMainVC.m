//
//  ZStudentMainVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//
#import "ZStudentMainVC.h"
#import "ZStudentMainTopSearchView.h"

#import "ZStudentBannerCell.h"
#import "ZStudentMainEnteryCell.h"
#import "ZStudentMainPhotoWallCell.h"
#import "ZStudentMainOrganizationListCell.h"
#import "ZStudentMainFiltrateSectionView.h"

#import "ZStudentOrganizationDetailDesVC.h"
#import "ZStudentClassificationListVC.h"

#import "ZPhoneAlertView.h"
#import "ZServerCompleteAlertView.h"
#import "ZAlertUpdateAppView.h"
#import "ZAlertView.h"
#import "ZAlertImageView.h"

#import "ZStudentMainViewModel.h"

#define KSearchTopViewHeight  CGFloatIn750(88)

@interface ZStudentMainVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) ZStudentMainTopSearchView *searchView;
@property (nonatomic,strong) ZStudentMainFiltrateSectionView *sectionView;

@property (nonatomic,strong) NSMutableArray *enteryArr;
@property (nonatomic,strong) NSMutableArray *photoWallArr;
@property (nonatomic,strong) NSMutableArray *AdverArr;
@property (nonatomic,strong) NSMutableArray *placeholderArr;
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZStudentMainVC

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"首页"), @"tabBarMain", @"tabBarMain_highlighted");
        self.analyzeTitle = @"首页";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCellConfigArr];
    
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
    [self refreshData];
    [self getAdverData];
}

- (void)setDataSource {
    [super setDataSource];
    _enteryArr = @[].mutableCopy;
    _photoWallArr = @[].mutableCopy;
    _AdverArr = @[].mutableCopy;
    _placeholderArr = @[].mutableCopy;
    
    NSArray *entryArr = @[@[@"体育竞技",@"studentMainSports"],@[@"艺术舞蹈",@"studentMainArt"],@[@"兴趣爱好",@"studentMainHobby"],@[@"其他",@"studentMainMore"],@[@"体育竞技",@"studentMainSports"],@[@"艺术舞蹈",@"studentMainArt"],@[@"兴趣爱好",@"studentMainHobby"],@[@"其他",@"studentMainMore"]];
    
    for (int i = 0; i < entryArr.count; i++) {
        ZStudentEnteryItemModel *model = [[ZStudentEnteryItemModel alloc] init];
        model.imageName = entryArr[i][1];
        model.name = entryArr[i][0];
        [_enteryArr addObject:model];
    }
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    NSMutableArray *sectionArr = @[].mutableCopy;
    if (self.AdverArr && self.AdverArr.count > 0) {
        NSMutableArray *tempAdverr = @[].mutableCopy;
        for (ZAdverListModel *adverModel in self.AdverArr) {
            ZStudentBannerModel *model = [[ZStudentBannerModel alloc] init];
            model.image = adverModel.ad_image;
            model.data = adverModel;
            [tempAdverr addObject:model];
        }
           
       ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentBannerCell className] title:@"ZStudentBannerCell" showInfoMethod:@selector(setList:) heightOfCell:[ZStudentBannerCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:tempAdverr];
       [sectionArr addObject:topCellConfig];
    }
    
    ZCellConfig *enteryCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainEnteryCell className] title:@"ZStudentMainEnteryCell" showInfoMethod:@selector(setChannelList:) heightOfCell:[ZStudentMainEnteryCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:_enteryArr];
    [sectionArr addObject:enteryCellConfig];
    
    if (self.placeholderArr && self.placeholderArr.count){
        [_photoWallArr removeAllObjects];
         for (ZAdverListModel *adverModel in self.placeholderArr) {
             ZStudentPhotoWallItemModel *photoWallModel = [[ZStudentPhotoWallItemModel alloc] init];
             photoWallModel.imageName = adverModel.ad_image;
             photoWallModel.data = adverModel;
             [_photoWallArr addObject:photoWallModel];
         }
        
        ZCellConfig *photoWallCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainPhotoWallCell className] title:@"ZStudentMainPhotoWallCell" showInfoMethod:@selector(setChannelList:) heightOfCell:[ZStudentMainPhotoWallCell z_getCellHeight:_photoWallArr] cellType:ZCellTypeClass dataModel:_photoWallArr];
        [sectionArr addObject:photoWallCellConfig];
    }
    
    
    [self.cellConfigArr addObject:sectionArr];
    
    NSMutableArray *section1Arr = @[].mutableCopy;
    
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationListCell className] title:@"ZStudentMainOrganizationListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMainOrganizationListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [section1Arr addObject:orCellCon1fig];
    }
    [self.cellConfigArr addObject:section1Arr];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(KSearchTopViewHeight + kStatusBarHeight);
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
}

#pragma mark - lazy loading
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
        _sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorGrayLine]);
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

- (NSMutableDictionary *)param {
    if (!_param) {
        _param = @{}.mutableCopy;
    }
    return _param;
}

#pragma mark - tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellConfigArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *tempArr = self.cellConfigArr[section];
    return tempArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [self.cellConfigArr[indexPath.section] objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    __weak typeof(self) weakSelf = self;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZStudentMainEnteryCell"]) {
        ZStudentMainEnteryCell *lcell = (ZStudentMainEnteryCell *)cell;
        lcell.menuBlock = ^(ZStudentEnteryItemModel * model) {
            ZStudentClassificationListVC *lvc = [[ZStudentClassificationListVC alloc] init];
            lvc.vcTitle = @"舞蹈分类";
            [weakSelf.navigationController pushViewController:lvc animated:YES];
        };
    }

    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *tempArr = self.cellConfigArr[indexPath.section];
    ZCellConfig *cellConfig = tempArr[indexPath.row];
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
//    [ZServerCompleteAlertView setAlertWithHandlerBlock:^(NSInteger index) {
//
//    }];
    if (indexPath.section == 1) {
        [[ZUserHelper sharedHelper] checkLogin:^{
            NSArray *tempArr = self.cellConfigArr[indexPath.section];
            ZCellConfig *cellConfig = tempArr[indexPath.row];
            if ([cellConfig.title isEqualToString:@"ZStudentMainOrganizationListCell"]) {
                ZStudentOrganizationDetailDesVC *dvc = [[ZStudentOrganizationDetailDesVC alloc] init];
                dvc.listModel = cellConfig.dataModel;
                [self.navigationController pushViewController:dvc animated:YES];
            }
        }];
        
    }
}

#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
   
    [self.searchView updateWithOffset:Offset_y];
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self setPostCommonData];
    [self refreshHeadData:_param];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZStudentMainViewModel getIndexList:self.param completeBlock:^(BOOL isSuccess, ZStoresListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZStudentMainViewModel getIndexList:self.param completeBlock:^(BOOL isSuccess, ZStoresListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshAllData {
    self.loading = YES;
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
}

- (void)getAdverData {
    __weak typeof(self) weakSelf = self;
    [ZStudentMainViewModel getAdverList:@{} completeBlock:^(BOOL isSuccess, ZAdverListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.AdverArr removeAllObjects];
            [weakSelf.placeholderArr removeAllObjects];
            [weakSelf.AdverArr addObjectsFromArray:data.shuffling];
            [weakSelf.placeholderArr addObjectsFromArray:data.placeholder];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
        }else{
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end
