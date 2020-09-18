//
//  ZStudentSignDetailListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentSignDetailListVC.h"
#import "ZMineStudentClassSignDetailImageCell.h"
#import "ZMineStudentClassSignDetailSummaryCell.h"
#import "ZOriganizationClassViewModel.h"
#import "ZOriganizationModel.h"

@interface ZStudentSignDetailListVC ()
@property (nonatomic,strong) NSString *student_id;
@property (nonatomic,strong) ZOriganizationStudentSignDetailListNetModel *detailModel;

@end

@implementation ZStudentSignDetailListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"签课详情")
    .zChain_addEmptyDataDelegate()
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_resetMainView(^{
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view);
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(20));
            make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(20));
        }];
        self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        self.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }).zChain_updateDataSource(^{
        
    }).zChain_block_setRefreshHeaderNet(^{
        
    }).zChain_block_setRefreshMoreNet(^{
        
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        NSMutableArray *sectionArr = @[].mutableCopy;
        
//            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title");
//            model.zz_titleLeft(@"初级游泳课")
//            .zz_titleRight(@"李梓萌")
//            .zz_fontLeft([UIFont boldFontContent])
//            .zz_fontRight([UIFont boldFontContent])
//            .zz_colorLeft([UIColor colorMain])
//            .zz_colorRight([UIColor colorMain])
//            .zz_colorDarkLeft([UIColor colorMain])
//            .zz_colorDarkRight([UIColor colorMain])
//            .zz_cellHeight(CGFloatIn750(90));
//
//            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
//            [sectionArr addObject:menuCellConfig];
        
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title");
            model.zz_titleLeft(@"上课进度")
            .zz_titleRight([NSString stringWithFormat:@"%@/%@节",weakSelf.detailModel.now_progress?weakSelf.detailModel.now_progress:@"0",weakSelf.detailModel.total_progress?weakSelf.detailModel.total_progress:@"0"])
            .zz_fontLeft([UIFont fontContent])
            .zz_fontRight([UIFont fontContent])
            .zz_cellHeight(CGFloatIn750(80));
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [sectionArr addObject:menuCellConfig];
        }
        {
            [sectionArr addObject:getEmptyCellWithHeight(CGFloatIn750(18))];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentClassSignDetailSummaryCell className] title:@"ZMineStudentClassSignDetailSummaryCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZMineStudentClassSignDetailSummaryCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:weakSelf.detailModel];
            [sectionArr addObject:menuCellConfig];
            
            [sectionArr addObject:getEmptyCellWithHeight(CGFloatIn750(28))];
        }
        for (ZOriganizationStudentSignDetailListModel *listModel in weakSelf.dataSources) {
            {
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title");
                model.zz_titleLeft([NSString stringWithFormat:@"第%@节",SafeStr(listModel.nums)])
                .zz_titleRight(SafeStr(listModel.sign_time))
                .zz_fontLeft([UIFont boldFontContent])
                .zz_fontRight([UIFont fontSmall])
                .zz_cellHeight(CGFloatIn750(90));
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [sectionArr addObject:menuCellConfig];
                
                if (ValidStr(listModel.image)) {
                    ZCellConfig *imageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentClassSignDetailImageCell className] title:model.cellTitle showInfoMethod:@selector(setImage:) heightOfCell:[ZMineStudentClassSignDetailImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:listModel.image];
                    [sectionArr addObject:imageCellConfig];
                }
            }
            {
                //    1：签课 2：教师代签 3：补签 4：请假 5：旷课
                NSString *state = @"";
                if ([listModel.type intValue] == 1) {
                    state = @"签课";
                }else if ([listModel.type intValue] == 2) {
                    state = @"教师代签";
                }else if ([listModel.type intValue] == 3) {
                    state = @"补签";
                }else if ([listModel.type intValue] == 4) {
                    state = @"请假";
                }else if ([listModel.type intValue] == 5) {
                    state = @"旷课";
                }
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title");
                model.zz_titleLeft(SafeStr(listModel.name))
                .zz_titleRight(SafeStr(listModel.type))
                .zz_cellHeight(CGFloatIn750(90));
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [sectionArr addObject:menuCellConfig];
            }
            {
                [sectionArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title");
                model.zz_lineHidden(NO)
                .zz_marginLineLeft(CGFloatIn750(30))
                .zz_marginLineRight(CGFloatIn750(30))
                .zz_cellHeight(CGFloatIn750(4));
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [sectionArr addObject:menuCellConfig];
            }
            
            [sectionArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        }
        [weakSelf.cellConfigArr addObject:sectionArr];
    }).zChain_block_setViewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(90))];
        sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlack]);
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textColor = [UIColor colorMain];
        titleLabel.text = self.detailModel.course_name;
        titleLabel.numberOfLines = 0;
        [titleLabel setFont:[UIFont boldFontContent]];
        [sectionView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sectionView.mas_left).offset(CGFloatIn750(30));
            make.centerY.equalTo(sectionView.mas_centerY);
        }];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLabel.textColor = [UIColor colorMain];
        nameLabel.text = self.detailModel.student_name;
        nameLabel.numberOfLines = 0;
        [nameLabel setFont:[UIFont boldFontContent]];
        [sectionView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(sectionView.mas_right).offset(-CGFloatIn750(30));
            make.centerY.equalTo(sectionView.mas_centerY);
        }];
        
        return sectionView;
    });
    self.zChain_block_setHeightForHeaderInSection(^CGFloat(UITableView *tableView, NSInteger section) {
        return CGFloatIn750(90);
    });
    
    self.zChain_reload_ui();
    self.zChain_reload_Net();
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getMyClassSignInfoList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentSignDetailListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            weakSelf.detailModel = data;
            
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
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
     [ZOriganizationClassViewModel getMyClassSignInfoList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentSignDetailListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            weakSelf.detailModel = data;
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

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    [param setObject:SafeStr(_student_id) forKey:@"student_id"];
    
    return param;
}
@end

#pragma mark - RouteHandler
@interface ZStudentSignDetailListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentSignDetailListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_signDetailList;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentSignDetailListVC *routevc = [[ZStudentSignDetailListVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = request.prts;
        if ([dict objectForKey:@"student_id"]) {
            routevc.student_id = dict[@"student_id"];
        }
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
