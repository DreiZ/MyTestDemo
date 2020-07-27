//
//  ZCircleReleaseSelectSchoolVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseSelectSchoolVC.h"
#import "ZCircleReleaseSchoolListCell.h"
#import "ZCircleSearchTextView.h"
#import "ZCircleMineViewModel.h"
#import "ZCircleMineModel.h"
#import "ZCircleReleaseModel.h"

#import "ZLocationManager.h"

@interface ZCircleReleaseSelectSchoolVC ()
@property (nonatomic,strong) ZCircleSearchTextView *searchView;
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) NSString *name;

@end

@implementation ZCircleReleaseSelectSchoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"选择校区")
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_block_setRefreshHeaderNet(^{
        [weakSelf refreshData];
    }).zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMoreData];
    }).zChain_updateDataSource(^{
        self.param = @{}.mutableCopy;
    }).zChain_resetMainView(^{
        [self.view addSubview:self.searchView];
        [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.searchView.mas_bottom);
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        for (int i = 0; i < self.dataSources.count; i++) {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseSchoolListCell className] title:@"ZCircleReleaseSchoolListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleReleaseSchoolListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:weakSelf.dataSources[i]];

            [weakSelf.cellConfigArr  addObject:menuCellConfig];
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(cellConfig.dataModel);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
    self.zChain_reload_Net();
}

- (ZCircleSearchTextView *)searchView {
    if (!_searchView) {
        __weak typeof(self) weakSelf = self;
        _searchView = [[ZCircleSearchTextView alloc] init];
        _searchView.searchBlock = ^(NSString * text) {
            weakSelf.name = text;
            weakSelf.zChain_reload_Net();
        };
        
        _searchView.textChangeBlock = ^(NSString * text) {
            
        };
    }
    return _searchView;
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
    [ZCircleMineViewModel getDynamicSchoolList:param completeBlock:^(BOOL isSuccess, ZCircleReleaseSchoolNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
            weakSelf.zChain_reload_ui();
            
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
    [ZCircleMineViewModel getDynamicSchoolList:self.param completeBlock:^(BOOL isSuccess, ZCircleReleaseSchoolNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
            weakSelf.zChain_reload_ui();
            
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
    [self.param setObject:@"10" forKey:@"page_size"];
    if (ValidStr(self.name)) {
        [self.param setObject:self.name forKey:@"name"];
    }
    
    [self setLocationParams];
}

- (void)setLocationParams {
    if ([ZLocationManager shareManager].cureUserLocation.location) {
        [self.param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].cureUserLocation.coordinate.longitude] forKey:@"longitude"];
        [self.param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].cureUserLocation.coordinate.latitude] forKey:@"latitude"];
    }
}
@end

#pragma mark - RouteHandler
@interface ZCircleReleaseSelectSchoolVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZCircleReleaseSelectSchoolVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_circle_choseSchool;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZCircleReleaseSelectSchoolVC *routevc = [[ZCircleReleaseSelectSchoolVC alloc] init];
    routevc.handleBlock = ^(ZCircleReleaseSchoolModel * model) {
        if (completionHandler) {
            completionHandler(model,nil);
        }
    };
    [topViewController.navigationController pushViewController:routevc animated:YES];
    
}
@end
