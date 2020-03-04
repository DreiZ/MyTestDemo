//
//  ZOrganizationTeachingScheduleNoVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeachingScheduleNoVC.h"
#import "ZOrganizationTeachingScheduleNoCell.h"
#import "ZOrganizationTeachingScheduleBuCell.h"

#import "ZOrganizationTrachingScheduleNewClassVC.h"
#import "ZOriganizationTeachingScheduleViewModel.h"

@interface ZOrganizationTeachingScheduleNoVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOrganizationTeachingScheduleNoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
    [self initCellConfigArr];
}

- (void)setDataSource {
    [super setDataSource];
    for (int i = 0; i < 10; i++) {
        ZOriganizationLessonOrderListModel *model = [[ZOriganizationLessonOrderListModel alloc] init];
        model.lessonName = @"w瑜伽课";
        model.lessonDes = @"很好学但是很痛苦哇啊啊";
        model.lessonNum = @"1/12节";
        model.validity = @"有效期至2012.12.1";
        model.teacherName = @"史蒂夫老师";
        model.lessonImage = @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gci14eu0k1j30e609gmyj.jpg";
        [self.dataSources addObject:model];
    }
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTeachingScheduleNoCell className] title:[ZOrganizationTeachingScheduleNoCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationTeachingScheduleNoCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:progressCellConfig];
    }
    
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"课程列表"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(96));
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.bottomBtn.mas_top).offset(-CGFloatIn750(0));
        make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
    }];
}


#pragma mark lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"新建排课" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            if (weakSelf.isEdit) {
                ZOrganizationTrachingScheduleNewClassVC *successvc = [[ZOrganizationTrachingScheduleNewClassVC alloc] init];
                [weakSelf.navigationController pushViewController:successvc animated:YES];
            }else{
                weakSelf.isEdit = YES;
                if (weakSelf.editChangeBlock) {
                    weakSelf.editChangeBlock(weakSelf.isEdit);
                }
            }
        }];
    }
    return _bottomBtn;
}

- (void)changeType:(BOOL)type {
    for (ZOriganizationLessonOrderListModel *model in self.dataSources) {
        model.isEdit = type;
    };;
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    if (isEdit) {
        [self changeType:YES];
        [_bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }else{
        [self changeType:NO];
        [_bottomBtn setTitle:@"新建排课" forState:UIControlStateNormal];
    }
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

#pragma mark - tableview datasource
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationTeachingScheduleNoCell"]) {
        ZOrganizationTeachingScheduleNoCell *ncell = (ZOrganizationTeachingScheduleNoCell *)cell;
        ncell.handleBlock = ^(NSInteger index) {
            ZOriganizationLessonOrderListModel *model = cellConfig.dataModel;
//            model.isSelected = !model.isSelected;
        };
    }
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = @{@"page_index":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    
    [ZOriganizationTeachingScheduleViewModel getLessonOderList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonOrderListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.pages integerValue] <= weakSelf.currentPage) {
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
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = @{@"page_index":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    
    [ZOriganizationTeachingScheduleViewModel getLessonOderList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonOrderListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.pages integerValue] <= weakSelf.currentPage) {
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
@end
