//
//  ZStudentMineEvaDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/28.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineEvaDetailVC.h"
#import "ZOrganizationEvaListLessonCell.h"
#import "ZOrganizationEvaDetailTitleCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZOrganizationEvaListEvaTextViewCell.h"
#import "ZOrganizationEvaListEvaBtnCell.h"
#import "ZStudentEvaDetailReEvaCell.h"

#import "ZOrganizationEvaListCell.h"
#import "ZOriganizationOrderViewModel.h"
#import "ZStudentMineEvaEditVC.h"
#import "ZOrganizationMineOrderDetailVC.h"

@interface ZStudentMineEvaDetailVC ()
@property (nonatomic,strong) ZOrderEvaDetailModel *detailModel;
@property (nonatomic,strong) NSString *stores_reply_text;
@property (nonatomic,strong) NSString *course_reply_text;

@end
@implementation ZStudentMineEvaDetailVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setTableViewGaryBack];
    [self initCellConfigArr];
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(220))];
    tableFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    self.iTableView.tableFooterView = tableFooterView;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    if (!self.detailModel) {
        return;
    }
    
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListLessonCell className] title:[ZOrganizationEvaListLessonCell className] showInfoMethod:@selector(setDetailModel:) heightOfCell:[ZOrganizationEvaListLessonCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.detailModel];
    [self.cellConfigArr addObject:orderCellConfig];
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(60))];
    
    [self lessonEva];
    [self teacherEva];
    [self organizationEva];
    
    
}

- (void)lessonEva {
    {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaDetailTitleCell className] title:[ZOrganizationEvaDetailTitleCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZOrganizationEvaDetailTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@{@"title":@"课程评价",@"star":SafeStr(self.detailModel.courses_comment_score),@"no":SafeStr(self.detailModel.has_update)}];
         [self.cellConfigArr addObject:orderCellConfig];
     }
    if (ValidStr(self.detailModel.courses_comment_desc)) {
         ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
         model.rightTitle = self.detailModel.courses_comment_desc;
         model.isHiddenLine = YES;
         model.cellWidth = KScreenWidth - CGFloatIn750(60);
         model.singleCellHeight = CGFloatIn750(60);
         model.lineLeftMargin = CGFloatIn750(30);
         model.lineRightMargin = CGFloatIn750(30);
         model.cellHeight = CGFloatIn750(62);
         model.lineSpace = CGFloatIn750(10);
         model.rightFont = [UIFont fontContent];
         model.rightColor = [UIColor colorTextBlack];
         model.rightDarkColor =  [UIColor colorTextBlackDark];
         
         ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
         
         [self.cellConfigArr  addObject:menuCellConfig];
     }
    if ([self.detailModel.course_is_reply intValue] == 1) {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaDetailReEvaCell className] title:[ZStudentEvaDetailReEvaCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZStudentEvaDetailReEvaCell z_getCellHeight:SafeStr(self.detailModel.courses_reply_desc)] cellType:ZCellTypeClass dataModel:@{@"title":SafeStr(self.detailModel.stores_name),@"content":SafeStr(self.detailModel.courses_reply_desc)}];
        [self.cellConfigArr addObject:orderCellConfig];
    }
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
}


- (void)teacherEva {
    {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaDetailTitleCell className] title:[ZOrganizationEvaDetailTitleCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZOrganizationEvaDetailTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@{@"title":@"教师评价",@"star":SafeStr(self.detailModel.teacher_comment_score),@"no":SafeStr(self.detailModel.has_update)}];
         [self.cellConfigArr addObject:orderCellConfig];
     }
     if (ValidStr(self.detailModel.teacher_comment_desc)) {

         ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
         model.rightTitle = self.detailModel.teacher_comment_desc;
         model.isHiddenLine = YES;
         model.cellWidth = KScreenWidth - CGFloatIn750(60);
         model.singleCellHeight = CGFloatIn750(60);
         model.lineLeftMargin = CGFloatIn750(30);
         model.lineRightMargin = CGFloatIn750(30);
         model.cellHeight = CGFloatIn750(62);
         model.lineSpace = CGFloatIn750(10);
         model.rightFont = [UIFont fontContent];
         model.rightColor = [UIColor colorTextBlack];
         model.rightDarkColor =  [UIColor colorTextBlackDark];
         
         ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
         
         [self.cellConfigArr  addObject:menuCellConfig];
     }
    if ([self.detailModel.teacher_is_reply intValue] == 1) {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaDetailReEvaCell className] title:[ZStudentEvaDetailReEvaCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZStudentEvaDetailReEvaCell z_getCellHeight:SafeStr(self.detailModel.teacher_reply_desc)] cellType:ZCellTypeClass dataModel:@{@"title":SafeStr(self.detailModel.teacher_nick_name),@"content":SafeStr(self.detailModel.teacher_reply_desc)}];
        [self.cellConfigArr addObject:orderCellConfig];
    }
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(40)];
}


- (void)organizationEva {
    {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaDetailTitleCell className] title:[ZOrganizationEvaDetailTitleCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZOrganizationEvaDetailTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@{@"title":@"校区评价",@"star":SafeStr(self.detailModel.stores_comment_score),@"no":SafeStr(self.detailModel.has_update)}];
         [self.cellConfigArr addObject:orderCellConfig];
     }
     if (ValidStr(self.detailModel.stores_comment_desc)) {
         ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
         model.rightTitle = self.detailModel.stores_comment_desc;
         model.isHiddenLine = YES;
         model.cellWidth = KScreenWidth - CGFloatIn750(60);
         model.singleCellHeight = CGFloatIn750(60);
         model.lineLeftMargin = CGFloatIn750(30);
         model.lineRightMargin = CGFloatIn750(30);
         model.cellHeight = CGFloatIn750(62);
         model.lineSpace = CGFloatIn750(10);
         model.rightFont = [UIFont fontContent];
         model.rightColor = [UIColor colorTextBlack];
         model.rightDarkColor =  [UIColor colorTextBlackDark];
         
         ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
         
         [self.cellConfigArr  addObject:menuCellConfig];
     }
    
     if ([self.detailModel.stores_is_reply intValue] == 1) {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaDetailReEvaCell className] title:[ZStudentEvaDetailReEvaCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZStudentEvaDetailReEvaCell z_getCellHeight:SafeStr(self.detailModel.stores_reply_desc)] cellType:ZCellTypeClass dataModel:@{@"title":SafeStr(self.detailModel.stores_name),@"content":SafeStr(self.detailModel.stores_reply_desc)}];
         [self.cellConfigArr addObject:orderCellConfig];
     }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"评价详情"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaDetailTitleCell"]){
        ZOrganizationEvaDetailTitleCell *lcell = (ZOrganizationEvaDetailTitleCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            ZStudentMineEvaEditVC *evc = [[ZStudentMineEvaEditVC alloc] init];
            evc.evaDetailModel = weakSelf.detailModel;
            [weakSelf.navigationController pushViewController:evc animated:YES];
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListLessonCell"]){
        ZOrganizationMineOrderDetailVC *evc = [[ZOrganizationMineOrderDetailVC alloc] init];
        ZOrderListModel *model = [[ZOrderListModel alloc] init];
        model.order_id = self.detailModel.order_id;
        evc.model = model;
        [self.navigationController pushViewController:evc animated:YES];
    }
}

#pragma mark - refresha
- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    self.loading = YES;
    [ZOriganizationOrderViewModel getEvaDetail:@{@"order_id":SafeStr(self.listModel.order_id),@"stores_id":SafeStr(self.listModel.stores_id)} completeBlock:^(BOOL isSuccess, id data) {
        weakSelf.loading = NO;
        if (isSuccess) {
            weakSelf.detailModel = data;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}

@end


