//
//  ZMianSearchVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMianSearchVC.h"
#import "ZStudentMainViewModel.h"
#import "ZStudentOrganizationDetailDesVC.h"
#import "ZStudentLessonDetailVC.h"
#import "ZStudentMainOrganizationSearchListCell.h"
#import "ZLocationManager.h"
#import "ZDBMainStore.h"
#import "ZHistoryModel.h"
#import "ZLabelListCell.h"

#import "ZOriganizationModel.h"

@interface ZMianSearchVC ()
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZMianSearchVC

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
    
    [self initCellConfigArr];
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
    
    if (ValidArray(self.dataSources)) {
        for (int i = 0; i < self.dataSources.count; i++) {
            id data = self.dataSources[i];
            if ([data isKindOfClass:[ZStoresListModel class]]) {
                ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationSearchListCell className] title:@"ZStudentMainOrganizationSearchListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMainOrganizationSearchListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
                [self.cellConfigArr addObject:orCellCon1fig];
                
                [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
            }
        }
    }else {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"type")
        .zz_titleLeft(@"历史搜索")
        .zz_lineHidden(YES)
        .zz_cellHeight(CGFloatIn750(50))
        .zz_fontLeft([UIFont boldFontTitle]);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        
        NSArray *mainArr = [[ZDBMainStore shareManager] searchHistorysByID:kSearchHistoryMainSearch];
        __block NSMutableArray *tempArr = @[].mutableCopy;
        [mainArr enumerateObjectsUsingBlock:^(ZHistoryModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tempArr addObject:SafeStr(obj.search_title)];
        }];
        
        ZCellConfig *historyCellConfig = [ZCellConfig cellConfigWithClassName:[ZLabelListCell className] title:@"history" showInfoMethod:@selector(setTitleArr:) heightOfCell:[ZLabelListCell z_getCellHeight:tempArr] cellType:ZCellTypeClass dataModel:tempArr];

        [self.cellConfigArr addObject:historyCellConfig];
        
        [self.iTableView reloadData];
    }
}

- (void)searchClick:(NSString *)text {
    [super searchClick:text];
    self.name = SafeStr(text);
    if (self.name) {
        [self refreshData];
        
        ZHistoryModel *lmodel = [[ZHistoryModel alloc] init];
        lmodel.search_title = self.name;
        lmodel.search_type = kSearchHistoryMainSearch;
        [[ZDBMainStore shareManager] updateHistorySearch:lmodel];
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
            ZStudentLessonDetailVC *dvc = [[ZStudentLessonDetailVC alloc] init];
            ZOriganizationLessonListModel *lmodel = [[ZOriganizationLessonListModel alloc] init];
            lmodel.lessonID = model.course_id;
            dvc.model = lmodel;
            [weakSelf.navigationController pushViewController:dvc animated:YES];
        };
    }else if([cellConfig.title isEqualToString:@"history"]){
        ZLabelListCell *lcell = (ZLabelListCell *)cell;
        lcell.handleBlock = ^(NSString * text) {
            weakSelf.searchView.iTextField.text = text;
            [weakSelf searchClick:text];
        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMainOrganizationSearchListCell"]) {
        ZStudentOrganizationDetailDesVC *dvc = [[ZStudentOrganizationDetailDesVC alloc] init];
        dvc.listModel = cellConfig.dataModel;
        [self.navigationController pushViewController:dvc animated:YES];
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
    
    if ([ZLocationManager shareManager].cureUserLocation) {
        [_param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].cureUserLocation.coordinate.longitude] forKey:@"longitude"];
        [_param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].cureUserLocation.coordinate.latitude] forKey:@"latitude"];
    }
}

@end
