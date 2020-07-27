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
#import "ZOrganizationEvaListEvaTextViewCell.h"
#import "ZOrganizationEvaListEvaBtnCell.h"
#import "ZStudentEvaDetailReEvaCell.h"

#import "ZOrganizationEvaListCell.h"
#import "ZOriganizationOrderViewModel.h"
#import "ZOrganizationMineOrderDetailVC.h"

@interface ZStudentMineEvaDetailVC ()
@property (nonatomic,strong) ZOrderEvaDetailModel *detailModel;
@property (nonatomic,strong) NSString *stores_reply_text;
@property (nonatomic,strong) NSString *course_reply_text;

@end
@implementation ZStudentMineEvaDetailVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.zChain_reload_Net();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"评价详情")
    .zChain_resetMainView(^{
        UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(220))];
        tableFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        self.iTableView.tableFooterView = tableFooterView;
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
            make.top.equalTo(self.view.mas_top).offset(10);
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        if (!weakSelf.detailModel) {
            return;
        }
        
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListLessonCell className] title:[ZOrganizationEvaListLessonCell className] showInfoMethod:@selector(setDetailModel:) heightOfCell:[ZOrganizationEvaListLessonCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:weakSelf.detailModel];
        [weakSelf.cellConfigArr addObject:orderCellConfig];
        [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(60))];
        
        [weakSelf lessonEva];
        [weakSelf teacherEva];
        [weakSelf organizationEva];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZOrganizationEvaDetailTitleCell"]){
            ZOrganizationEvaDetailTitleCell *lcell = (ZOrganizationEvaDetailTitleCell *)cell;
            lcell.handleBlock = ^(NSInteger index) {
                routePushVC(ZRoute_mine_evaEdit, weakSelf.detailModel, nil);
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListLessonCell"]){
            ZOrganizationMineOrderDetailVC *evc = [[ZOrganizationMineOrderDetailVC alloc] init];
            ZOrderListModel *model = [[ZOrderListModel alloc] init];
            model.order_id = weakSelf.detailModel.order_id;
            evc.model = model;
            [weakSelf.navigationController pushViewController:evc animated:YES];
        }
    });
    
    self.zChain_block_setRefreshHeaderNet(^{
        weakSelf.loading = YES;
        [ZOriganizationOrderViewModel getEvaDetail:@{@"order_id":SafeStr(weakSelf.listModel.order_id),@"stores_id":SafeStr(weakSelf.listModel.stores_id)} completeBlock:^(BOOL isSuccess, id data) {
            weakSelf.loading = NO;
            if (isSuccess) {
                weakSelf.detailModel = data;
                
                weakSelf.zChain_reload_ui();
            }else{
                [TLUIUtility showErrorHint:data];
            }
        }];
    });
}

- (void)lessonEva {
    {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaDetailTitleCell className] title:[ZOrganizationEvaDetailTitleCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZOrganizationEvaDetailTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@{@"title":@"课程评价",@"star":SafeStr(self.detailModel.courses_comment_score),@"no":SafeStr(self.detailModel.has_update)}];
         [self.cellConfigArr addObject:orderCellConfig];
     }
    if (ValidStr(self.detailModel.courses_comment_desc)) {
         ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"content")
         .zz_titleLeft(self.detailModel.courses_comment_desc)
         .zz_lineHidden(YES)
         .zz_cellWidth(KScreenWidth - CGFloatIn750(60))
         .zz_cellHeight(CGFloatIn750(60))
         .zz_spaceLine(CGFloatIn750(10))
         .zz_leftMultiLine(YES);
         
          ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

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
         ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"content")
         .zz_titleLeft(self.detailModel.teacher_comment_desc)
         .zz_lineHidden(YES)
         .zz_cellWidth(KScreenWidth - CGFloatIn750(60))
         .zz_cellHeight(CGFloatIn750(60))
         .zz_spaceLine(CGFloatIn750(10))
         .zz_leftMultiLine(YES);
         
          ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

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
         ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"content")
         .zz_titleLeft(self.detailModel.stores_comment_desc)
         .zz_lineHidden(YES)
         .zz_cellWidth(KScreenWidth - CGFloatIn750(60))
         .zz_cellHeight(CGFloatIn750(60))
         .zz_spaceLine(CGFloatIn750(10))
         .zz_leftMultiLine(YES);
         
          ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

          [self.cellConfigArr  addObject:menuCellConfig];
     }
    
     if ([self.detailModel.stores_is_reply intValue] == 1) {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaDetailReEvaCell className] title:[ZStudentEvaDetailReEvaCell className] showInfoMethod:@selector(setData:) heightOfCell:[ZStudentEvaDetailReEvaCell z_getCellHeight:SafeStr(self.detailModel.stores_reply_desc)] cellType:ZCellTypeClass dataModel:@{@"title":SafeStr(self.detailModel.stores_name),@"content":SafeStr(self.detailModel.stores_reply_desc)}];
         [self.cellConfigArr addObject:orderCellConfig];
     }
}

@end

#pragma mark - RouteHandler
@interface ZStudentMineEvaDetailVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentMineEvaDetailVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_evaDetail;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentMineEvaDetailVC *routevc = [[ZStudentMineEvaDetailVC alloc] init];
    routevc.listModel = request.prts;
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
