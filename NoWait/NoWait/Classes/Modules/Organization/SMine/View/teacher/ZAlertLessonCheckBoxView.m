//
//  ZAlertLessonCheckBoxView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertLessonCheckBoxView.h"
#import "ZOriganizationLessonViewModel.h"

@interface ZAlertLessonCheckBoxView()
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) NSMutableArray *dataSources;

@end
@implementation ZAlertLessonCheckBoxView

static ZAlertLessonCheckBoxView *sharedLessonManager;

+ (ZAlertLessonCheckBoxView *)sharedLessonManager {
    @synchronized (self) {
        if (!sharedLessonManager) {
            sharedLessonManager = [[ZAlertLessonCheckBoxView alloc] init];
        }
    }
    return sharedLessonManager;
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
        ZOriganizationLessonListModel *listModel = self.dataSources[i];
//        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
//        model.leftTitle = listModel.name;
//        model.leftMargin = CGFloatIn750(60);
//        model.rightMargin = CGFloatIn750(60);
//        model.cellHeight = CGFloatIn750(108);
//        model.leftFont = [UIFont fontMaxTitle];
//        model.rightImage = listModel.isSelected ? @"selectedCycle" :@"unSelectedCycle";
//        model.isHiddenLine = YES;
//
//        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:@"week" showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
//
//        [self.cellConfigArr addObject:menuCellConfig];
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"user")
        .zz_cellHeight(CGFloatIn750(108))
        .zz_titleLeft(listModel.name)
        .zz_imageRightHeight(CGFloatIn750(30))
        .zz_leftMultiLine(YES);
        if (listModel.isSelected) {
            model.zz_imageRight(@"selectedCycle");
        }else{
            model.zz_imageRight(@"unSelectedCycle");
        }
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    ZOriganizationLessonListModel *listModel = cellConfig.dataModel;
    if (!listModel.isSelected) {
        for (int i = 0; i < self.dataSources.count; i++) {
            ZOriganizationLessonListModel *model = self.dataSources[i];
            if (i != indexPath.row) {
                model.isSelected = NO;
            }else{
                model.isSelected = !model.isSelected;
            }
        }
    }else{
        ZOriganizationLessonListModel *model = self.dataSources[indexPath.row];
        model.isSelected = !model.isSelected;
    }
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (ZOriganizationLessonListModel *)getSelect{
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationLessonListModel *model = self.dataSources[i];
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
    [ZOriganizationLessonViewModel getLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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


- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    [param setObject:self.schoolID forKey:@"stores_id"];
    [param setObject:@"0" forKey:@"status"];
    [param setObject:@"2" forKey:@"fix_time"];
    return param;
}

-(void)setName:(NSString *)title schoolID:(NSString *)schoolID handlerBlock:(void (^)(NSInteger,id))handleBlock {
    [super setName:title handlerBlock:handleBlock];
    self.schoolID = schoolID;
    [self refreshData];
}

+ (void)setAlertName:(NSString *)title schoolID:(NSString *)schoolID handlerBlock:(void(^)(NSInteger,id))handleBlock {
    
    [[ZAlertLessonCheckBoxView sharedLessonManager] setName:title schoolID:schoolID handlerBlock:handleBlock];
}

@end

