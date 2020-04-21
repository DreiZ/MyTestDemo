//
//  ZOrganizationCardLessonSeeListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardLessonSeeListVC.h"
#import "ZOriganizationCardViewModel.h"
#import "ZOriganizationLessonViewModel.h"
#import "ZOriganizationModel.h"
#import "ZOriganizationLessonModel.h"
#import "ZStudentOrganizationLessonListCell.h"

#import "ZStudentLessonDetailVC.h"

@interface ZOrganizationCardLessonSeeListVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,assign) NSInteger total;

@end

@implementation ZOrganizationCardLessonSeeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
    [self.iTableView reloadData];
    [self refreshData];
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"可用课程"];
}


- (void)setupMainView {
    [super setupMainView];
   
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(200))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.iTableView.tableFooterView = bottomView;
    
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(80));
    }];
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
//        model.isHiddenLine = YES;

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationLessonListCell className] title:@"ZStudentOrganizationLessonListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationLessonListCell z_getCellHeight:listModel] cellType:ZCellTypeClass dataModel:listModel];

        [self.cellConfigArr addObject:menuCellConfig];

    }
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]) {
        ZStudentLessonDetailVC *dvc = [[ZStudentLessonDetailVC alloc] init];
        dvc.model = cellConfig.dataModel;
        [self.navigationController pushViewController:dvc animated:YES];
    }
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    if (self.isAll) {
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
    }else{
        [ZOriganizationCardViewModel getCardLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                [weakSelf.dataSources removeAllObjects];
                [weakSelf.dataSources addObjectsFromArray:data.list];
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
                weakSelf.total = [data.total intValue];
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
    
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    if (self.isAll) {
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
    }else{
        [ZOriganizationCardViewModel getCardLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                [weakSelf.dataSources addObjectsFromArray:data.list];
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
                weakSelf.total = [data.total intValue];
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
    
}


- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
       
    if (self.isAll) {
         [param setObject:self.stores_id forKey:@"stores_id"];
              [param setObject:@"1" forKey:@"status"];
    }else{
        [param setObject:self.coupons_id forKey:@"id"];
    }
    return param;
}
@end

