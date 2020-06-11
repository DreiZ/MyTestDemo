//
//  ZStudentMessageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMessageVC.h"
#import "ZMessageListCell.h"

#import "ZMessageHistoryReadCell.h"
#import "ZMessageListCell.h"
#import "ZMessgeModel.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZStudentMessageSendListVC.h"
#import "ZStudentMineSettingMineVC.h"
#import "ZOrganizationCampusManagementVC.h"
#import "ZOrganizationMineOrderDetailVC.h"
#import "ZAlertView.h"
#import "ZOrganizationLessonManageVC.h"
#import "ZOrganizationAccountVC.h"
#import "ZOrganizationMineEvaDetailVC.h"
#import "ZStudentMineEvaDetailVC.h"
#import <TLTabBarControllerProtocol.h>

@interface ZStudentMessageVC ()<TLTabBarControllerProtocol>
@property (nonatomic,strong) NSMutableDictionary *param;

@end
@implementation ZStudentMessageVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"消息"), @"tabBarMessage", @"tabBarMessage_highlighted");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loading = YES;
    [self setTableViewGaryBack];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

- (void)setDataSource {
    [super setDataSource];
    _param = @{}.mutableCopy;
    if (ValidStr([ZUserHelper sharedHelper].user_id)) {
        self.emptyDataStr = @"您还没有收到过消息";
    }else{
        self.emptyDataStr = @"您还没有登录";
    }
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSInteger hadRead = 0;
    for (int i = 0; i < self.dataSources.count; i++) {
        ZMessgeModel *model = self.dataSources[i];
        if ([model.is_read intValue] >= 1) {
            hadRead++;
        }
        if (i != 0 && hadRead == 1) {
            ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageHistoryReadCell className] title:[ZMessageHistoryReadCell className] showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(50) cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:messageCellConfig];
        }
        ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageListCell className] title:[ZMessageListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZMessageListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:messageCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"消息"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}


- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZMessageListCell"]) {
        ZMessageListCell *lcell = (ZMessageListCell *)cell;
        lcell.handleBlock = ^(ZMessgeModel * message, NSInteger index) {
            [weakSelf setHandleModel:message index:index];
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {

}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self setPostCommonData];
    [self refreshHeadData:self.param];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    
    [ZOriganizationStudentViewModel getMessageList:param completeBlock:^(BOOL isSuccess, ZMessageNetModel *data) {
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
    [self setPostCommonData];
    __weak typeof(self) weakSelf = self;
   
    [ZOriganizationStudentViewModel getMessageList:self.param completeBlock:^(BOOL isSuccess, ZMessageNetModel *data) {
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

- (void)setPostCommonData {
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [_param setObject:@"10" forKey:@"page_size"];
}


- (void)refreshAllData {
    self.loading = YES;
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

#pragma mark - set handele
- (void)setHandleModel:(ZMessgeModel *)model index:(NSInteger)index{
    if (index == 200) {
        [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"确定删除此通知？" leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
            if (index == 1) {
                [ZOriganizationStudentViewModel delMessage:@{@"id":SafeStr(model.message_id)} completeBlock:^(BOOL isSuccess, id data) {
                    if (isSuccess) {
                        [self refreshAllData];
                        [TLUIUtility showSuccessHint:data];
                    }else{
                        [TLUIUtility showErrorHint:data];
                    }
                }];
            }
        }];
        return;
    }
    switch ([model.notice intValue]) {
        case ZCustomNoticeTypeSettledIn :                        //  机构入驻通知
            {
                ZOrganizationCampusManagementVC *mvc = [[ZOrganizationCampusManagementVC alloc] init];
                [self.navigationController pushViewController:mvc animated:YES];
            }
                break;
        case ZCustomNoticeTypeCourseAudit:                    //  课程审核通知
            {
                ZOrganizationLessonManageVC *mvc = [[ZOrganizationLessonManageVC alloc] init];
                [self.navigationController pushViewController:mvc animated:YES];
            }
                break;
        case ZCustomNoticeTypePayment:                       //  支付交易通知
            {
                ZOrganizationMineOrderDetailVC *dvc = [[ZOrganizationMineOrderDetailVC alloc] init];
                ZOrderListModel *orderModel = [[ZOrderListModel alloc] init];
                orderModel.order_id = model.extra.order_id;
                dvc.model = orderModel;
                [self.navigationController pushViewController:dvc animated:YES];
            }
                break;
        case ZCustomNoticeTypeRefund:                          //  退款通知
            {
                ZOrganizationMineOrderDetailVC *dvc = [[ZOrganizationMineOrderDetailVC alloc] init];
                ZOrderListModel *orderModel = [[ZOrderListModel alloc] init];
                orderModel.order_id = model.extra.order_id;
                orderModel.isRefund = YES;
                dvc.model = orderModel;
                [self.navigationController pushViewController:dvc animated:YES];
            }
                break;
        case ZCustomNoticeTypeMoneyBack:                      //  回款通知
            {
                ZOrganizationAccountVC *svc = [[ZOrganizationAccountVC alloc] init];
                [self.navigationController pushViewController:svc animated:YES];
            }
                break;
        case ZCustomNoticeTypeRegister:                       //  注册通知
            {
                ZStudentMineSettingMineVC *mvc = [[ZStudentMineSettingMineVC alloc] init];
                [self.navigationController pushViewController:mvc animated:YES];
            }
                break;
        case ZCustomNoticeTypeAppointment:                     //  预约通知
            {
                ZOrganizationMineOrderDetailVC *dvc = [[ZOrganizationMineOrderDetailVC alloc] init];
                ZOrderListModel *orderModel = [[ZOrderListModel alloc] init];
                orderModel.order_id = model.extra.order_id;
                dvc.model = orderModel;
                [self.navigationController pushViewController:dvc animated:YES];
            }
                break;
        case ZCustomNoticeTypeCourseBegins:                   //  开课通知
            {
                
            }
                break;
        case ZCustomNoticeTypeCourseEnd:                      //  结课通知
            {
                
            }
                break;
        case ZCustomNoticeTypeCourseSign:                     //  签课通知
            {
                
            }
                break;
        case ZCustomNoticeTypeEvaluate:                        //  评价通知
            {
                if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
                    ZOrderEvaListModel *smodel = [[ZOrderEvaListModel alloc] init];
                    smodel.stores_id = model.extra.stores_id;
                    smodel.order_id = model.extra.order_id;
                    smodel.isTeacher = [[ZUserHelper sharedHelper].user.type intValue] == 2 ? YES:NO;
                    ZOrganizationMineEvaDetailVC *dvc =
                    [[ZOrganizationMineEvaDetailVC alloc] init];
                    dvc.listModel = smodel;
                    [self.navigationController pushViewController:dvc animated:YES];
                }else{
                    ZOrderEvaListModel *smodel = [[ZOrderEvaListModel alloc] init];
                    smodel.stores_id = model.extra.stores_id;
                    smodel.order_id = model.extra.order_id;
                    ZStudentMineEvaDetailVC *dvc = [[ZStudentMineEvaDetailVC alloc] init];
                    dvc.listModel = smodel;
                    [self.navigationController pushViewController:dvc animated:YES];
                }
            }
                break;
        case ZCustomNoticeTypeCustom:
            {
                
            }
                break;
        case ZCustomNoticeTypeNotice:                        //机构老师通知
            {
                if (index == 0) {
                    if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
                        ZStudentMessageSendListVC *svc = [[ZStudentMessageSendListVC alloc] init];
                        svc.model = model;
                        [self.navigationController pushViewController:svc animated:YES];
                    }
                }else{
                    if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
                        ZStudentMessageSendListVC *svc = [[ZStudentMessageSendListVC alloc] init];
                        svc.model = model;
                        [self.navigationController pushViewController:svc animated:YES];
                    }
                }
            }
                break;
        default:
            
            break;
    }
}

- (void)tabBarItemDidDoubleClick {
    [self refreshAllData];
}
@end
