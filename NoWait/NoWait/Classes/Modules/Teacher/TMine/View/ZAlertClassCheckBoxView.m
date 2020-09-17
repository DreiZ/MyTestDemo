//
//  ZAlertClassCheckBoxView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertClassCheckBoxView.h"
#import "ZOriganizationClassViewModel.h"
#import "ZOriganizationModel.h"

@interface ZAlertClassCheckBoxView()
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) NSMutableArray *dataSources;

@end

@implementation ZAlertClassCheckBoxView

static ZAlertClassCheckBoxView *sharedClassManager;

+ (ZAlertClassCheckBoxView *)sharedClassManager {
    @synchronized (self) {
        if (!sharedClassManager) {
            sharedClassManager = [[ZAlertClassCheckBoxView alloc] init];
        }
    }
    return sharedClassManager;
}

- (void)initMainView {
    [super initMainView];
    self.dataSources = @[].mutableCopy;
    [self refreshData];
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
    [self setTableViewEmptyDataDelegate];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationClassListModel *listModel = self.dataSources[i];
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = listModel.name;
        model.leftMargin = CGFloatIn750(60);
        model.rightMargin = CGFloatIn750(60);
        model.cellHeight = CGFloatIn750(108);
        model.leftFont = [UIFont fontMaxTitle];
//        model.rightImageH = @80;
//        model.leftImage = listModel.image;
        model.rightImage = listModel.isSelected ? @"selectedCycle" :@"unSelectedCycle";
        model.isHiddenLine = YES;

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:@"teacher" showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

        [self.cellConfigArr addObject:menuCellConfig];

    }
}

- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"teacher"]) {
        ZSingleLineCell *lcell = (ZSingleLineCell *)cell;
        lcell.leftImageView.layer.cornerRadius = CGFloatIn750(40);
        [lcell.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lcell.mas_left).offset(CGFloatIn750(30));
            make.width.height.mas_equalTo(CGFloatIn750(80));
            make.centerY.equalTo(lcell.mas_centerY);
        }];
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    ZOriganizationClassListModel *listModel = cellConfig.dataModel;
    if (!listModel.isSelected) {
        for (int i = 0; i < self.dataSources.count; i++) {
            ZOriganizationClassListModel *model = self.dataSources[i];
            if (i != indexPath.row) {
                model.isSelected = NO;
            }else{
                model.isSelected = !model.isSelected;
            }
        }
    }else{
        ZOriganizationClassListModel *model = self.dataSources[indexPath.row];
        model.isSelected = !model.isSelected;
    }
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (ZOriganizationClassListModel *)getSelect{
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationClassListModel *model = self.dataSources[i];
        if (model.isSelected) {
            return model;
        }
    }
    return nil;
}

- (void)handleWithIndex:(NSInteger)index {
    if (self.handleBlock) {
        if (index == 1) {
            id temp = [self getSelect];
            if (temp) {
                self.handleBlock(index, temp);
            }else{
                [TLUIUtility showErrorHint:@"您还没有选中"];
                return;
            }
        }else{
           self.handleBlock(index, nil);
        }
    }
    [super handleWithIndex:index];
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getTeacherClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 100) {
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
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getTeacherClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 100) {
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

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%d",1]}.mutableCopy;
    [param setObject:SafeStr([ZUserHelper sharedHelper].stores.stores_id) forKey:@"stores_id"];
    [param setObject:@"1000" forKey:@"page_size"];
    [param setObject:SafeStr([ZUserHelper sharedHelper].stores.teacher_id) forKey:@"teacher_id"];
    return param;
}

-(void)setName:(NSString *)title dataSources:(NSArray *)data  handlerBlock:(void (^)(NSInteger,id))handleBlock {
    [super setName:title handlerBlock:handleBlock];
    if (ValidArray(data)) {
        [self.dataSources addObjectsFromArray:data];
        [self.iTableView reloadData];
    }else{
        [self refreshData];
    }
}

+ (void)setAlertName:(NSString *)title dataSources:(NSArray *)data handlerBlock:(void(^)(NSInteger,id))handleBlock {
    [[ZAlertClassCheckBoxView sharedClassManager] setName:title dataSources:data handlerBlock:handleBlock];
}

@end
