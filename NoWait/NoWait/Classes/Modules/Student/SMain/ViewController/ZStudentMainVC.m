//
//  ZStudentMainVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//
#import "ZStudentMainVC.h"

@interface ZStudentMainVC ()

@end

@implementation ZStudentMainVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
    [self refreshData];
    [self getAdverData];
    [self getCategoryList];
    
    __weak typeof(self) weakSelf = self;
    [[ZLocationManager shareManager] setLocationMainBlock:^(MAUserLocation *userLocation) {
        if (!weakSelf.isLoacation && userLocation) {
             DLog(@"userLocation %f-%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
            [weakSelf refreshData];
            weakSelf.isLoacation = YES;
        }
    }];
    [[ZLocationManager shareManager] startLocation];
}

- (void)setDataSource {
    [super setDataSource];
    
    self.loading = YES;
    self.enteryArr = @[].mutableCopy;
    self.photoWallArr = @[].mutableCopy;
    
    self.enteryDataArr = @[].mutableCopy;
    self.AdverArr = @[].mutableCopy;
    self.placeholderArr = @[].mutableCopy;
    self.classifyArr = @[].mutableCopy;
    
    NSArray *advers = [ZStudentMainViewModel mainBannerData];
    NSArray *placeholder = [ZStudentMainViewModel mainPlaceholderData];
    NSArray *classify = [ZStudentMainViewModel mainClassifyOneData];
    NSArray *entryData = [ZStudentMainViewModel mainClassifyEntryData];
    if (ValidArray(advers)) {
        [self.AdverArr addObjectsFromArray:advers];
    }
    if (ValidArray(placeholder)) {
        [self.placeholderArr addObjectsFromArray:placeholder];
    }
    if (ValidArray(classify)) {
        [self.classifyArr addObjectsFromArray:classify];
    }
    if (ValidArray(entryData)) {
        [self.enteryDataArr addObjectsFromArray:entryData];
    }
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    [self.enteryArr removeAllObjects];
    
    __block NSMutableArray *sectionArr = @[].mutableCopy;
    if (ValidArray(self.AdverArr)) {
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
    
    if (ValidArray(self.enteryDataArr)) {
        [self.enteryDataArr enumerateObjectsUsingBlock:^(ZMainClassifyOneModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZStudentEnteryItemModel *model = [[ZStudentEnteryItemModel alloc] init];
            model.imageName = obj.imageName;
            model.name = obj.name;
            model.sid = obj.classify_id;
            model.data = obj;
            [self.enteryArr addObject:model];
        }];
        
        ZCellConfig *enteryCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainEnteryCell className] title:@"ZStudentMainEnteryCell" showInfoMethod:@selector(setChannelList:) heightOfCell:[ZStudentMainEnteryCell z_getCellHeight:self.enteryArr] cellType:ZCellTypeClass dataModel:self.enteryArr];
        [sectionArr addObject:enteryCellConfig];
    }
    
    if (self.placeholderArr && self.placeholderArr.count){
        [self.photoWallArr removeAllObjects];
         for (ZAdverListModel *adverModel in self.placeholderArr) {
             ZStudentPhotoWallItemModel *photoWallModel = [[ZStudentPhotoWallItemModel alloc] init];
             photoWallModel.imageName = adverModel.ad_image;
             photoWallModel.data = adverModel;
             [self.photoWallArr addObject:photoWallModel];
         }
        
        ZCellConfig *photoWallCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainPhotoWallCell className] title:@"ZStudentMainPhotoWallCell" showInfoMethod:@selector(setChannelList:) heightOfCell:[ZStudentMainPhotoWallCell z_getCellHeight:self.photoWallArr] cellType:ZCellTypeClass dataModel:self.photoWallArr];
        [sectionArr addObject:photoWallCellConfig];
    }
    [self.cellConfigArr addObject:sectionArr];
    
    NSMutableArray *section1Arr = @[].mutableCopy;
    if (self.dataSources.count > 0) {
        for (int i = 0; i < self.dataSources.count; i++) {
            ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationListCell className] title:@"ZStudentMainOrganizationListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMainOrganizationListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
            [section1Arr addObject:orCellCon1fig];
        }
    }else {
        ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZNoDataCell className] title:@"ZNoDataCell" showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(500) cellType:ZCellTypeClass dataModel:nil];
        [section1Arr addObject:orCellCon1fig];
    }
    
    [self.cellConfigArr addObject:section1Arr];
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self setPostCommonData];
    [self refreshHeadData:self.param];
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
                weakSelf.iTableView.tableFooterView = weakSelf.hintFooterView;
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
            weakSelf.iTableView.tableFooterView = weakSelf.hintFooterView;
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
                weakSelf.iTableView.tableFooterView = weakSelf.hintFooterView;
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
            weakSelf.iTableView.tableFooterView = weakSelf.hintFooterView;
        }
    }];
}

- (void)refreshAllData {
    self.loading = YES;
    [self setPostCommonData];
    [self.param setObject:@"1" forKey:@"page"];
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    [self refreshHeadData:self.param];
}

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    if ([ZLocationManager shareManager].cureUserLocation) {
        [self.param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].cureUserLocation.coordinate.longitude] forKey:@"longitude"];
        [self.param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].cureUserLocation.coordinate.latitude] forKey:@"latitude"];
    }
}

- (void)getAdverData {
    __weak typeof(self) weakSelf = self;
    [ZStudentMainViewModel getAdverList:@{} completeBlock:^(BOOL isSuccess, ZAdverListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.AdverArr removeAllObjects];
            [weakSelf.placeholderArr removeAllObjects];
            [weakSelf.enteryDataArr removeAllObjects];
            
            [weakSelf.AdverArr addObjectsFromArray:data.shuffling];
            [weakSelf.placeholderArr addObjectsFromArray:data.placeholder];
            [weakSelf.enteryDataArr addObjectsFromArray:data.category];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [ZStudentMainViewModel updateMainEntryClassifys:data.category];
            [ZStudentMainViewModel updateMainBanners:data.shuffling];
            [ZStudentMainViewModel updateMainPlaceholders:data.placeholder];
        }else{
            [weakSelf.iTableView reloadData];
        }
    }];
}

- (void)getCategoryList {
    __weak typeof(self) weakSelf = self;
    [ZStudentMainViewModel getCategoryList:@{} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess) {
            ZMainClassifyNetModel *model = data;
            weakSelf.sectionView = nil;
            [weakSelf.classifyArr removeAllObjects];
            [weakSelf.classifyArr addObjectsFromArray:model.list];
            [weakSelf.classifyArr enumerateObjectsUsingBlock:^(ZMainClassifyOneModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj.secondary enumerateObjectsUsingBlock:^(ZMainClassifyOneModel *sobj, NSUInteger idx, BOOL * _Nonnull stop) {
                    sobj.superClassify_id = obj.classify_id;
                }];
            }];
            [ZStudentMainViewModel updateMainClassifysOne:weakSelf.classifyArr];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end
