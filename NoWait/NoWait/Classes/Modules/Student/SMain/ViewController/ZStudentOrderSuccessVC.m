//
//  ZStudentOrderSuccessVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrderSuccessVC.h"
#import "ZOriganizationOrderViewModel.h"
#import "ZOrderModel.h"
#import "ZStudentMineOrderDetailResultCell.h"
#import "ZStudentMineOrderDetailHandleBottomView.h"


@interface ZStudentOrderSuccessVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) ZStudentMineOrderDetailHandleBottomView *handleView;

@property (nonatomic,strong) ZOrderDetailModel *detailModel;
@property (nonatomic,strong) NSString *order_id;
@end

@implementation ZStudentOrderSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setTableViewGary();
    self.zChain_resetMainView(^{
        self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]];
        
        [self.view addSubview:self.handleView];
        [self.handleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(100)+safeAreaBottom());
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.handleView.mas_top);
            make.top.equalTo(self.view.mas_top).offset(0);
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        {
//            1:等待支付 2:支付成功 3:支付失败
            switch ([SafeStr(self.detailModel.status) intValue]) {
                case 1:
                    if ([self.detailModel.type intValue] == 1) {
                        //待付款（去支付，取消）
                        [weakSelf.navigationItem setTitle:@"待付款"];
                    }else{
                        [weakSelf.navigationItem setTitle:@"预约待付款"];//预约待付款（去支付，取消）
                    }
                    break;
                case 2:
                    //已付款（评价，退款，删除）
                    [weakSelf.navigationItem setTitle:@"支付成功"];
                    break;
                case 3:
                    if ([self.detailModel.type intValue] == 1) {
                        [weakSelf.navigationItem setTitle:@"待付款"];
                    }else{
                        [weakSelf.navigationItem setTitle:@"预约待付款"];//预约待付款（去支付，取消）
                    }
                    break;
                
                default:
                    [weakSelf.navigationItem setTitle:@"订单"];
            }
        }
        
        
        weakSelf.detailModel.isStudent = [[ZUserHelper sharedHelper].user.type intValue] == 1;
        [weakSelf.cellConfigArr removeAllObjects];
        
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderDetailResultCell className] title:[ZStudentMineOrderDetailResultCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderDetailResultCell z_getCellHeight:weakSelf.detailModel] cellType:ZCellTypeClass dataModel:weakSelf.detailModel];
        [weakSelf.cellConfigArr addObject:orderCellConfig];
        
        weakSelf.handleView.model = weakSelf.detailModel;
    }).zChain_addRefreshHeader().zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshData];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableview, NSIndexPath *index, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentMineOrderDetailResultCell"]){
            ZStudentMineOrderDetailResultCell *lcell = (ZStudentMineOrderDetailResultCell *)cell;
            lcell.handleBlock = ^(NSInteger index, ZOrderDetailModel *model) {
                if (index == ZLessonOrderHandleTypeRefund) {
                    routePushVC(ZRoute_mine_OrderRefundHandle, weakSelf.detailModel, nil);
                }else if (index == ZLessonOrderHandleTypeClub){
                    routePushVC(ZRoute_main_organizationDetail, @{@"id":model.stores_id}, nil);
                }else if(index == ZLessonOrderHandleTypeLesson){
                    routePushVC(ZRoute_main_orderLessonDetail, @{@"id":model.course_id}, nil);
                }else if(index == ZLessonOrderHandleTypeDetail){
                    ZOrderListModel *listModel = [[ZOrderListModel alloc] init];
                    listModel.order_id = weakSelf.order_id;
                    routePushVC(ZRoute_org_orderDetail, listModel, nil);
                }
            };
        }
    });
    
    self.zChain_reload_Net();
}


#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(118), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontSmall]];
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}


#pragma mark - lazy loading...
- (ZStudentMineOrderDetailHandleBottomView *)handleView {
    if (!_handleView) {
        __weak typeof(self) weakSelf = self;
        _handleView = [[ZStudentMineOrderDetailHandleBottomView alloc] init];
        _handleView.handleBlock = ^(ZLessonOrderHandleType type) {
            if (type == ZLessonOrderHandleTypeTel) {
                if ([[ZUserHelper sharedHelper].user.type intValue] == 1) {
                    [ZPublicTool callTel:weakSelf.detailModel.phone];
                }else{
                    [ZPublicTool callTel:weakSelf.detailModel.account_phone];
                }
            }else if (type == ZLessonOrderHandleTypeEva) {
                routePushVC(ZRoute_mine_evaEdit, weakSelf.detailModel, nil);
            }else{
                [ZOriganizationOrderViewModel handleOrderWithIndex:type data:weakSelf.detailModel completeBlock:^(BOOL isSuccess, id data) {
                    if (isSuccess) {
                        [TLUIUtility showSuccessHint:data];
                        [weakSelf refreshData];
                    }else{
                        [TLUIUtility showErrorHint:data];
                    }
                }];
            }
        };
        
    }
    return _handleView;
}

#pragma mark - 网络数据
- (void)refreshData {
    self.loading = YES;
    
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = @{@"order_id":SafeStr(self.order_id)}.mutableCopy;
    
    [ZOriganizationOrderViewModel getOrderDetail:params completeBlock:^(BOOL isSuccess, id data) {
        weakSelf.loading = NO;
        if (isSuccess) {
            weakSelf.detailModel = data;
//            weakSelf.detailModel.status = @"2";
            if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}
@end


#pragma mark - RouteHandler
@interface ZStudentOrderSuccessVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentOrderSuccessVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_main_sureOrderResulet;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentOrderSuccessVC *routevc = [[ZStudentOrderSuccessVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = request.prts;
        if ([dict objectForKey:@"order_id"]) {
            routevc.order_id = request.prts[@"order_id"];
        }
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
