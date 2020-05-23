//
//  ZStudentMainTableViewVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainTableViewVC.h"

@interface ZStudentMainTableViewVC ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ZStudentMainTableViewVC

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
    
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
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
        __weak typeof(self) weakSelf = self;
        _searchView = [[ZStudentMainTopSearchView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KSearchTopViewHeight+kStatusBarHeight) ];
        _searchView.searchBlock = ^(NSInteger index) {
            ZMianSearchVC *svc = [[ZMianSearchVC alloc] init];
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
    }
    return _searchView;
}

- (ZStudentMainFiltrateSectionView *)sectionView {
    if (!_sectionView && _classifyArr) {
        __weak typeof(self) weakSelf = self;
        _sectionView = [[ZStudentMainFiltrateSectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88)) classifys:self.classifyArr];
        _sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorGrayLine]);
        _sectionView.tableView = self.iTableView;
        _sectionView.titleSelect = ^(NSInteger index, void (^menuAfterTime)(void)) {
            CGFloat topHeight = 0;
            topHeight += [ZStudentMainEnteryCell z_getCellHeight:self.enteryArr];
            if (self.AdverArr && self.AdverArr.count > 0) {
                topHeight += [ZStudentBannerCell z_getCellHeight:nil];
            }
            
            if (self.photoWallArr && self.photoWallArr.count > 0) {
                topHeight += [ZStudentMainPhotoWallCell z_getCellHeight:self.photoWallArr];
            }
            
            if (weakSelf.iTableView.contentOffset.y < topHeight) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.iTableView setContentOffset:CGPointMake(0,topHeight) animated:NO];
                    menuAfterTime();
                });
            }else{
                menuAfterTime();
            }
        };
        
        _sectionView.dataBlock = ^(NSDictionary *tDict) {
            if (tDict && [tDict objectForKey:@"type"]) {
                id tdata = tDict[@"type"];
                if ([tdata isKindOfClass:[ZMainClassifyOneModel class]]) {
                    ZMainClassifyOneModel *twoModel = tdata;
                    [weakSelf.param setObject:SafeStr(twoModel.superClassify_id) forKey:@"stores_type"];
                    [weakSelf.param removeObjectForKey:@"sort_type"];
                }
            }
            
            if (tDict && [tDict objectForKey:@"sort"]) {
                [weakSelf.param setObject:tDict[@"sort"] forKey:@"sort_type"];
            }else{
                [weakSelf.param removeObjectForKey:@"sort"];
            }
            if (tDict && [tDict objectForKey:@"more"]) {
                [weakSelf.param setObject:tDict[@"more"] forKey:@"stores_type"];
            }else{
                [weakSelf.param removeObjectForKey:@"more"];
            }
//            [weakSelf refreshData];
            [ZAlertClassifyPickerView setClassifyAlertWithClassifyArr:    weakSelf.sectionView.classifys handlerBlock:^(NSMutableArray *classify) {
                
            }];
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
            lvc.vcTitle = model.name;
            lvc.type = model.sid;
            [weakSelf.navigationController pushViewController:lvc animated:YES];
        };
    }else if([cellConfig.title isEqualToString:@"ZStudentBannerCell"]){
        ZStudentBannerCell *lcell = (ZStudentBannerCell *)cell;
        lcell.bannerBlock = ^(ZStudentBannerModel *model) {
            [ZRouteManager pushToVC:model.data];
        };
    }else if([cellConfig.title isEqualToString:@"ZStudentMainPhotoWallCell"]){
        ZStudentMainPhotoWallCell *lcell = (ZStudentMainPhotoWallCell *)cell;
        lcell.menuBlock = ^(ZStudentPhotoWallItemModel *model) {
               [ZRouteManager pushToVC:model.data];
        };
    }else if([cellConfig.title isEqualToString:@"ZStudentMainOrganizationListCell"]){
       ZStudentMainOrganizationListCell *lcell = (ZStudentMainOrganizationListCell *)cell;
        lcell.moreBlock = ^(ZStoresListModel *model) {
            model.isMore = !model.isMore;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
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
    if (section == 1) {
        return self.sectionView;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSArray *tempArr = self.cellConfigArr[indexPath.section];
        ZCellConfig *cellConfig = tempArr[indexPath.row];
        if ([cellConfig.title isEqualToString:@"ZStudentMainOrganizationListCell"]) {
            ZStudentOrganizationDetailDesVC *dvc = [[ZStudentOrganizationDetailDesVC alloc] init];
            dvc.listModel = cellConfig.dataModel;
            [self.navigationController pushViewController:dvc animated:YES];
        }
    }
}

#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
   
    [self.searchView updateWithOffset:Offset_y];
}
@end
