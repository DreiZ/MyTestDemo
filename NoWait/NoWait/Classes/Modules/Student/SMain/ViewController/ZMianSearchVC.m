//
//  ZMianSearchVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMianSearchVC.h"
#import "ZStudentMainOrganizationListCell.h"
#import "ZStudentMainViewModel.h"
#import "ZOriganizationLessonViewModel.h"
#import "ZStudentOrganizationLessonListCell.h"
#import "ZStudentOrganizationDetailDesVC.h"
#import "ZStudentLessonDetailVC.h"

@interface ZMianSearchVC ()
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) NSString *search_type;
@property (nonatomic,strong) UIView *typeView;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;

@end

@implementation ZMianSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.search_type = @"1";
    _param = @{}.mutableCopy;
}

- (void)setupMainView{
    [super setupMainView];
    [self.view addSubview:self.typeView];
    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.searchView.mas_bottom);
        make.height.mas_equalTo(CGFloatIn750(80));
    }];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
           make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
           make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
           make.top.equalTo(self.typeView.mas_bottom).offset(-CGFloatIn750(0));
       }];
}

- (UIView *)typeView {
    if (!_typeView) {
        _typeView = [[UIView alloc] init];
        _typeView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainSub]);
        [_typeView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.typeView.mas_bottom).offset(CGFloatIn750(-30));
            make.top.equalTo(self.typeView.mas_top).offset(CGFloatIn750(30));
            make.centerX.equalTo(self.typeView.mas_centerX);
            make.width.mas_equalTo(2);
        }];
        
        [_typeView addSubview:self.leftBtn];
        [_typeView addSubview:self.rightBtn];
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self.typeView);
            make.right.equalTo(bottomLineView.mas_left);
        }];
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.typeView);
            make.left.equalTo(bottomLineView.mas_right);
        }];
    }
    return _typeView;
}


- (UIButton *)leftBtn {
    if (!_leftBtn) {
        __weak typeof(self) weakSelf = self;
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_leftBtn setTitle:@"搜索机构" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_leftBtn.titleLabel setFont:[UIFont fontContent]];
       
        [_leftBtn bk_whenTapped:^{
            weakSelf.search_type = @"1";
        }];
    }
    return _leftBtn;
}


- (UIButton *)rightBtn {
    if (!_rightBtn) {
        __weak typeof(self) weakSelf = self;
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_rightBtn setTitle:@"搜索课程" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:[UIFont fontContent]];
       
        [_rightBtn bk_whenTapped:^{
            weakSelf.search_type = @"2";
        }];
    }
    return _rightBtn;
}

- (void)setSearch_type:(NSString *)search_type {
    _search_type = search_type;
    if ([search_type isEqualToString:@"1"]) {
        [self.leftBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
    }else{
        [self.leftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
    }
    [self refreshData];
}

#pragma mark - setdata
- (void)initCellConfigArr {
    [super initCellConfigArr];
    if ([self.search_type isEqualToString:@"1"]) {
        for (int i = 0; i < self.dataSources.count; i++) {
            id data = self.dataSources[i];
            if ([data isKindOfClass:[ZStoresListModel class]]) {
                ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationListCell className] title:@"ZStudentMainOrganizationListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMainOrganizationListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
                [self.cellConfigArr addObject:orCellCon1fig];
            }
        }
    }else{
        for (int i = 0; i < self.dataSources.count; i++) {
            id data = self.dataSources[i];
            if ([data isKindOfClass:[ZOriganizationLessonListModel class]]) {
                 ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationLessonListCell className] title:[ZStudentOrganizationLessonListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationLessonListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:data];
                [self.cellConfigArr addObject:lessonCellConfig];
            }
        }
    }
}

- (void)searchClick:(NSString *)text {
    [super searchClick:text];
    self.name = SafeStr(text);
    if (self.name.length > 0) {
        [self refreshData];
    }
}


- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMainOrganizationListCell"]) {
        ZStudentOrganizationDetailDesVC *dvc = [[ZStudentOrganizationDetailDesVC alloc] init];
        dvc.listModel = cellConfig.dataModel;
        [self.navigationController pushViewController:dvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]) {
            ZStudentLessonDetailVC *dvc = [[ZStudentLessonDetailVC alloc] init];
            dvc.model = cellConfig.dataModel;
            [self.navigationController pushViewController:dvc animated:YES];
    //        ZStudentOrganizationLessonDetailVC *lessond_vc = [[ZStudentOrganizationLessonDetailVC alloc] init];
    //        [self.navigationController pushViewController:lessond_vc animated:YES];
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
    if ([self.search_type intValue] == 1) {
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
        [ZOriganizationLessonViewModel searchAllLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    if ([self.search_type intValue] == 1) {
        [ZStudentMainViewModel getIndexList:self.param completeBlock:^(BOOL isSuccess, ZStoresListNetModel *data) {
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
    }else {
        [ZOriganizationLessonViewModel searchAllLessonList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
}

- (void)refreshAllData {
    self.loading = YES;
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    if ([self.search_type isEqualToString:@"1"]) {
        [_param setObject:self.name forKey:@"search_name"];
    }else{
        [_param setObject:self.name forKey:@"name"];
    }
    
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
}

@end
