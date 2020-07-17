//
//  ZStudentMainVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//
#import "ZStudentMainVC.h"
#import "ZRewardAlertView.h"
#import "ZLaunchManager.h"
#import "ZRewardCenterVC.h"
#import <TLTabBarControllerProtocol.h>
#import "ZFileManager.h"
@interface ZStudentMainVC ()<TLTabBarControllerProtocol>

@end

@implementation ZStudentMainVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
    
    [self refreshData];
    [self getAdverData];
    [self getCategoryList:^(BOOL isSuccess) {
        
    }];
    
    __weak typeof(self) weakSelf = self;
    [[ZLocationManager shareManager] setLocationMainBlock:^(MAUserLocation *userLocation) {
        if (!weakSelf.isLoacation && userLocation) {
             DLog(@"userLocation %f-%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
            [weakSelf refreshData];
            weakSelf.isLoacation = YES;
        }
    }];
    [[ZLocationManager shareManager] startLocation];
    
    if ([ZUserHelper sharedHelper].user) {
        if ([[ZUserHelper sharedHelper].user.type intValue] != 2) {
            NSString *isRewardFirst = [[NSUserDefaults standardUserDefaults] objectForKey:@"isRewardFirstLogin"];
            if (!isRewardFirst) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [ZRewardAlertView showRewardSeeBlock:^{
                        ZRewardCenterVC *cvc = [[ZRewardCenterVC alloc] init];
                        [self.navigationController pushViewController:cvc animated:YES];
                    }];
                });
                
                [[NSUserDefaults standardUserDefaults] setObject:@"isRewardFirstLogin" forKey:@"isRewardFirstLogin"];
            }
        }
    }else{
        NSString *isRewardFirst = [[NSUserDefaults standardUserDefaults] objectForKey:@"isRewardFirst"];
        if (!isRewardFirst) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ZRewardAlertView showRewardSeeBlock:^{
                    if ([ZLaunchManager sharedInstance].tabBarController.selectedIndex != 2) {
                        [[ZLaunchManager sharedInstance].tabBarController setSelectedIndex:2];
                    }
                }];
            });
            
            [[NSUserDefaults standardUserDefaults] setObject:@"isRewardFirst" forKey:@"isRewardFirst"];
        }
    }
    
    [ZPublicTool checkUpdateVersion];
    
//    NSArray *temp = [ZFileManager readFileWithPath:[ZFileManager getDocumentDirectory] folder:@"videoFolder"];
//    DLog(@"filezzz :%@",temp);
//    [temp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//    //        [ZFileManager removeDocumentWithFilePath:obj[@"path"]];
//    }];
//    NSArray *videos = [[NSBundle mainBundle] pathsForResourcesOfType:@"mov" inDirectory:nil];
//    for (id item in videos) {
//        UISaveVideoAtPathToSavedPhotosAlbum(item, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
//    }
}
//- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//    if(error != nil) {
//        NSLog(@"%@", error);
//    } else {
//        NSLog(@"复制视频成功");
//    }
//}

- (void)setDataSource {
    [super setDataSource];
    
    self.loading = YES;
    self.enteryArr = @[].mutableCopy;
    self.photoWallArr = @[].mutableCopy;
    
    self.enteryDataArr = @[].mutableCopy;
    self.AdverArr = @[].mutableCopy;
    self.placeholderArr = @[].mutableCopy;
    self.classifyArr = @[].mutableCopy;
    
    [self.param setObject:@"0" forKey:@"sort_type"];
    
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
//            ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationListCell className] title:@"ZStudentOrganizationListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
//
            ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationNewListCell className] title:@"ZStudentOrganizationNewListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationNewListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
            [section1Arr addObject:orCellCon1fig];
            [section1Arr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
        }//
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
    [self setLocationParams];
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
    [self setLocationParams];
    [self.param setObject:@"1" forKey:@"page"];
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    [self refreshHeadData:self.param];
}

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    
    [self setLocationParams];
}

- (void)setLocationParams {
    if ([ZLocationManager shareManager].cureUserLocation.location) {
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

- (void)getCategoryList:(void(^)(BOOL))complete {
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
            if (ValidArray(self.classifyArr)) {
                [ZStudentMainViewModel updateMainClassifysOne:weakSelf.classifyArr];
            }
            
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            if (complete) {
                complete(YES);
            }
        }else{
            if (complete) {
                complete(NO);
            }
//            [self getCategoryList:complete];
        }
    }];
}

- (void)tabBarItemDidDoubleClick {
    [self refreshAllData];
//    [self getAdverData];
//    [self getCategoryList];
}

- (void)tabBarItemDidClick:(BOOL)isSelected {
    if (isSelected) {
        [self.iTableView scrollToTopAnimated:YES];
    }
}
@end
