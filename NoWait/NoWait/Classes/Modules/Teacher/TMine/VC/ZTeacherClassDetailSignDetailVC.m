//
//  ZTeacherClassDetailSignDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherClassDetailSignDetailVC.h"
#import "ZTeacherMineSignListCell.h"

#import "ZTeacherClassDetailVC.h"
#import "ZOriganizationClassViewModel.h"
#import "ZOrganizationClassDetailStudentListVC.h"
#import "ZAlertView.h"

#import "ZTeacherMineSignListDetailTitleCell.h"
#import "ZTeacherMineSignListDetailListCell.h"
#import "ZTeacherSignTopTitleView.h"

@interface ZTeacherClassDetailSignDetailVC ()
@property (nonatomic,strong) ZOriganizationSignListNetModel *detailModel;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) ZTeacherSignTopTitleView *topTitleView;

@end

@implementation ZTeacherClassDetailSignDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _list = @[].mutableCopy;
    
    
    [self refreshData];
    [self setNavigation];
    [self initCellConfigArr];
    [self setTableViewRefreshHeader];
    [self setTableViewEmptyDataDelegate];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    self.model.index = [self.model.now_progress intValue];
    for (int i = 0; i < 5; i++) {
        ZOriganizationSignListModel *model = [[ZOriganizationSignListModel alloc] init];
        model.type = [NSString stringWithFormat:@"%d",i+1];
        NSMutableArray *tempArr = @[].mutableCopy;
        for (int i = 0; i < 15; i++) {
            ZOriganizationSignListStudentModel *model = [[ZOriganizationSignListStudentModel alloc] init];
            model.name = @"我姐的记得记得";
            model.image = @"http://wx2.sinaimg.cn/mw600/005H5u3yly1gdref7tvxdj32ip1oh4qu.jpg";
            [tempArr addObject:model];
        }
        model.list = tempArr;
        [_list addObject:model];
    }
//    /类型 1：签课 2：老师代签 3：补签 4：请假 5：旷课 6:待签课
    NSArray *tarr = @[@"签课",@"老师代签",@"补签",@"请假",@"旷课",@"待签课"];
    NSArray *iarr = @[@"signbu",@"signbu",@"signbu",@"signbu",@"signbu",@"signbu"];
    for (ZOriganizationSignListModel *model in _list) {
        ZBaseSingleCellModel *cellmodel = [[ZBaseSingleCellModel alloc] init];
         cellmodel.rightTitle = [NSString stringWithFormat:@"%ld人",model.list.count];
        if ([model.type intValue] <= tarr.count && [model.type intValue] > 0) {
            cellmodel.leftImage = iarr[[model.type intValue] -1];
            cellmodel.leftTitle = tarr[[model.type intValue] -1];
        }
        
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZTeacherMineSignListDetailTitleCell className] title:[ZTeacherMineSignListDetailTitleCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZTeacherMineSignListDetailTitleCell z_getCellHeight:cellmodel] cellType:ZCellTypeClass dataModel:cellmodel];
        [self.cellConfigArr addObject:orderCellConfig];
        
        ZCellConfig *listCellConfig = [ZCellConfig cellConfigWithClassName:[ZTeacherMineSignListDetailListCell className] title:[ZTeacherMineSignListDetailListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZTeacherMineSignListDetailListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:listCellConfig];
        
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(60))];
    }
    _topTitleView.model = self.model;
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:self.model.stores_name];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.topTitleView];
    [self.topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.topTitleView.mas_bottom).offset(20);
    }];
}


- (ZTeacherSignTopTitleView *)topTitleView {
    if (!_topTitleView) {
        __weak typeof(self) weakSelf = self;
        _topTitleView = [[ZTeacherSignTopTitleView alloc] init];
        _topTitleView.model = self.model;
        _topTitleView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                weakSelf.model.now_progress = [NSString stringWithFormat:@"%d",[weakSelf.model.now_progress intValue] - 1];
            }else{
                weakSelf.model.now_progress = [NSString stringWithFormat:@"%d",[weakSelf.model.now_progress intValue] - 1];
            }
            [weakSelf refreshData];
        };
    }
    return _topTitleView;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZTeacherMineSignListDetailListCell"]){
        ZTeacherMineSignListDetailListCell *enteryCell = (ZTeacherMineSignListDetailListCell *)cell;
        enteryCell.handleBlock = ^(ZOriganizationSignListModel *model) {
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"ZTeacherMineSignListCell"]){
         ZOriganizationClassListModel *model = cellConfig.dataModel;
         ZTeacherClassDetailVC *dvc = [[ZTeacherClassDetailVC alloc] init];
         dvc.model.courses_name = model.courses_name;
         dvc.model.classID = model.classID;
         dvc.model.name = model.name;
         dvc.model.nums = model.nums;
         dvc.model.status = model.status;
         [self.navigationController pushViewController:dvc animated:YES];
    }
}


#pragma mark - 数据处理
- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getMyClassSignList:@{@"courses_class_id":SafeStr(self.model.classID),@"courses_num":SafeStr(self.model.now_progress)} completeBlock:^(BOOL isSuccess, ZOriganizationSignListNetModel *addModel) {
        if (isSuccess) {
            weakSelf.detailModel = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}

@end


