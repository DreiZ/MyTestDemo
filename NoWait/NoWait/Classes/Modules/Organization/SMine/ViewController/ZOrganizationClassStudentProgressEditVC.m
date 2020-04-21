//
//  ZOrganizationClassStudentProgressEditVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassStudentProgressEditVC.h"
#import "ZOrganizationStudentProcressEditCell.h"
#import "ZOriganizationClassViewModel.h"
#import "ZAlertView.h"

@interface ZOrganizationClassStudentProgressEditVC ()
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOrganizationClassStudentProgressEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshData];
}

- (void)setNavigation {
    [super setNavigation];
    [self.navigationItem setTitle:@"设置课程进度"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(80));
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomBtn.mas_top);
    }];
}

#pragma mark - lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(118), CGFloatIn750(50))];
        [_bottomBtn setTitle:@"设置线下学员学习进度" forState:UIControlStateNormal];

        [_bottomBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        
        [_bottomBtn bk_whenTapped:^{
            [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"学员进度只可修改一次，请谨慎修改提交" leftBtnTitle:@"取消" rightBtnTitle:@"提交" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    [weakSelf updateData];
                }
            }];
        }];
    }
    return _bottomBtn;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = [NSString stringWithFormat:@"课程总节数：%@节",self.total_progress];
    model.leftColor = [UIColor colorMain];
    model.leftDarkColor = [UIColor colorMain];
    model.isHiddenLine = YES;
    model.cellHeight = CGFloatIn750(96);
    model.leftFont = [UIFont fontContent];
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    
    [self.cellConfigArr addObject:menuCellConfig];
    
    for (ZOriganizationStudentListModel *model in self.dataSources) {
        model.now_progress = @"";
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationStudentProcressEditCell className] title:@"ZOrganizationStudentProcressEditCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationStudentProcressEditCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationStudentProcressEditCell"]) {
        ZOriganizationStudentListModel *model = (ZOriganizationStudentListModel *)cellConfig.dataModel;
        ZOrganizationStudentProcressEditCell *ecell = (ZOrganizationStudentProcressEditCell *)cell;
        ecell.handleBlock = ^(NSString *text) {
            model.nowNums = text;
        };
    }
}
#pragma mark - refresh data
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getQrcodeStudentList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
     [ZOriganizationClassViewModel getQrcodeStudentList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    NSMutableDictionary *param = [self setPostCommonData];
    [param setObject:@"1" forKey:@"page"];
    [param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    [self refreshHeadData:param];
}

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    [param setObject:self.courses_class_id forKey:@"courses_class_id"];
   
    return param;
}



- (void)updateData {
    NSMutableDictionary *params = @{}.mutableCopy;
    NSMutableArray *students = @[].mutableCopy;
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationStudentListModel *listModel = self.dataSources[i];
        if (ValidStr(listModel.nowNums)) {
            if ([listModel.nowNums intValue] - [self.total_progress intValue] > 0) {
                [TLUIUtility showErrorHint:[NSString stringWithFormat:@"%@的进度大于课程总进度了",listModel.name]];
                return;
            }
            [students addObject:@{@"student_id":SafeStr(listModel.studentID),@"now_progress":[NSString stringWithFormat:@"%d",[self.total_progress intValue] - [listModel.nowNums intValue]]}];
        }
    }
    [params setObject:students forKey:@"students"];
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationClassViewModel setQrcodeStudentProgress:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}
@end
