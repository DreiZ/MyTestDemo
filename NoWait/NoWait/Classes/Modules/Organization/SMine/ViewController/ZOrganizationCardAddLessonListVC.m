//
//  ZOrganizationCardAddLessonListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardAddLessonListVC.h"
#import "ZOriganizationLessonViewModel.h"


@interface ZOrganizationCardAddLessonListVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,strong) NSMutableArray *hadSelectArr;

@end

@implementation ZOrganizationCardAddLessonListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self setTableViewRefreshFooter];
    [self.iTableView reloadData];
    [self refreshData];
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"选择课程"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
    [self.navigationItem setRightBarButtonItem:item];
}


- (void)setupMainView {
    [super setupMainView];
   
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(200))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(200));
    }];
    
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(80));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top);
    }];
}


#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(106), CGFloatIn750(48))];
        [_navLeftBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontContent]];
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            [weakSelf handleAll];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}



- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            NSArray *temp = [weakSelf getSelect];
            if (temp.count > 0) {
                weakSelf.handleBlock(temp,temp.count==weakSelf.total ? YES:NO);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [TLUIUtility showErrorHint:@"您还没有选中"];
                return;
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationLessonListModel *listModel = self.dataSources[i];
//
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
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"week")
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

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationStudentListModel *model = self.dataSources[i];
        if (i == indexPath.row) {
            model.isSelected = !model.isSelected;
        }
    }
    [self initCellConfigArr];
    [self.iTableView reloadData];
    if ([self getSelect].count == self.dataSources.count) {
        [_navLeftBtn setTitle:@"全不选" forState:UIControlStateNormal];
    }else{
        [_navLeftBtn setTitle:@"全选" forState:UIControlStateNormal];
    }
}


- (NSArray<ZOriganizationLessonListModel *> *)getSelect{
    NSMutableArray *list = @[].mutableCopy;
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationLessonListModel *model = self.dataSources[i];
        if (model.isSelected) {
            [list addObject:model];
        }
    }
    return list;
}

- (void)handleAll{
    if ([self getSelect].count == self.dataSources.count) {
        for (int i = 0; i < self.dataSources.count; i++) {
            ZOriganizationStudentListModel *model = self.dataSources[i];
            model.isSelected = NO;
        }
        [self.navLeftBtn setTitle:@"全选" forState:UIControlStateNormal];
    }else{
        for (int i = 0; i < self.dataSources.count; i++) {
            ZOriganizationStudentListModel *model = self.dataSources[i];
            model.isSelected = YES;
        }
        [self.navLeftBtn setTitle:@"全不选" forState:UIControlStateNormal];
    }
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
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
            for (ZOriganizationLessonListModel *model in weakSelf.dataSources) {
                for (ZOriganizationLessonListModel *smodel in weakSelf.hadSelectArr) {
                    if ([model.lessonID isEqualToString:smodel.lessonID]) {
                        model.isSelected = YES;
                    }
                }
            }
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


- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    [param setObject:[ZUserHelper sharedHelper].school.schoolID forKey:@"stores_id"];
    [param setObject:@"1" forKey:@"status"];
    [param setObject:@"1000" forKey:@"page_size"];
    return param;
}
@end

#pragma mark - RouteHandler
@interface ZOrganizationCardAddLessonListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationCardAddLessonListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_cartAddLesson;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationCardAddLessonListVC *routevc = [[ZOrganizationCardAddLessonListVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSArray class]]) {
        routevc.hadSelectArr = request.prts;
    }
    routevc.handleBlock = ^(NSArray<ZOriganizationLessonListModel *> *list, BOOL isAll) {
        if (completionHandler) {
            completionHandler(@{@"list":list?list:@[],@"isAll":isAll?@YES:@NO},nil);
        }
    };
    [topViewController.navigationController pushViewController:routevc animated:YES];
    
}
@end
