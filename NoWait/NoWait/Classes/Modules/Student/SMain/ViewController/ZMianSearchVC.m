//
//  ZMianSearchVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMianSearchVC.h"
#import "ZStudentMainViewModel.h"

#import "ZStudentHotSearchCell.h"
#import "ZStudentMainOrganizationSearchListCell.h"
#import "ZLocationManager.h"

#import "ZOriganizationModel.h"

@interface ZMianSearchVC ()
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSMutableDictionary *param;
@end

@implementation ZMianSearchVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.searchType = kSearchHistoryMainSearch;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.zChain_block_setNotShouldDecompressImages(^{

    });
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.searchView.iTextField resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.searchView.iTextField && self.searchView.iTextField.text.length < 1) {
        [self.searchView.iTextField becomeFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loading = NO;
    self.name = @"";
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

- (void)setupMainView{
    [super setupMainView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
       make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
       make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
       make.top.equalTo(self.searchView.mas_bottom).offset(-CGFloatIn750(0));
    }];
}

#pragma mark - lazy loading
- (NSMutableDictionary *)param {
    if (!_param) {
        _param = @{}.mutableCopy;
    }
    return _param;
}

#pragma mark - setdata
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
//    for (int i = 0; i < 10; i++) {
//        ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentHotSearchCell className] title:@"ZStudentHotSearchCell" showInfoMethod:@selector(setData:) heightOfCell:[ZStudentHotSearchCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@{@"hint":@"热",@"content":@"圣诞节开发收看电视思考思考思考思考开始上课的方式快递费"}];
//        [self.cellConfigArr addObject:orCellCon1fig];
//
//        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(10))];
//    }
//    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
//    [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        id data = self.dataSources[i];
        if ([data isKindOfClass:[ZStoresListModel class]]) {
            ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationSearchListCell className] title:@"ZStudentMainOrganizationSearchListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMainOrganizationSearchListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
            [self.cellConfigArr addObject:orCellCon1fig];
            
            [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
        }
    }
}

- (void)searchClick:(NSString *)text {
    [super searchClick:text];
    self.name = SafeStr(text);
    if (self.name) {
        [self refreshData];
    }
}


#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if([cellConfig.title isEqualToString:@"ZStudentMainOrganizationSearchListCell"]){
       ZStudentMainOrganizationSearchListCell *lcell = (ZStudentMainOrganizationSearchListCell *)cell;
        lcell.moreBlock = ^(ZStoresListModel *model) {
            model.isMore = !model.isMore;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
        lcell.lessonBlock = ^(ZStoresCourse *model) {
            routePushVC(ZRoute_main_orderLessonDetail, @{@"id":model.course_id}, nil);
        };
    } 
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMainOrganizationSearchListCell"]) {
        ZStoresListModel *model = cellConfig.dataModel;
        routePushVC(ZRoute_main_organizationDetail, @{@"id":model.stores_id}, nil);
    }
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
    [ZStudentMainViewModel searchStoresList:self.param completeBlock:^(BOOL isSuccess, ZStoresListNetModel *data) {
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
    [ZStudentMainViewModel searchStoresList:self.param completeBlock:^(BOOL isSuccess, ZStoresListNetModel *data) {
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
    [self.param setObject:self.name forKey:@"name"];
    
    if ([ZLocationManager shareManager].location) {
        [_param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].location.coordinate.longitude] forKey:@"longitude"];
        [_param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].location.coordinate.latitude] forKey:@"latitude"];
    }
}

@end

#pragma mark - RouteHandler
@interface ZMianSearchVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZMianSearchVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_main_search;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZMianSearchVC *routevc = [[ZMianSearchVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
