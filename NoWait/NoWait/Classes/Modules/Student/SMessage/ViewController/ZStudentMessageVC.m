//
//  ZStudentMessageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMessageVC.h"
#import "ZMessageListCell.h"
#import "ZMessageTypeEntryCell.h"
#import "ZMessageHistoryReadCell.h"
#import "ZMessageListCell.h"
#import "ZNoDataCell.h"

#import "ZMessgeModel.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZCircleMineViewModel.h"
#import "ZLaunchManager.h"
#import <TLTabBarControllerProtocol.h>
#import "ZAlertView.h"

@interface ZStudentMessageVC ()<TLTabBarControllerProtocol>
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) ZMessageCircleNewsModel *circleModel;


@property (nonatomic,assign) BOOL loadFromLocalHistory;
@property (nonatomic,strong) ZMessageNetModel *messageNetModel;
@end

@implementation ZStudentMessageVC

- (id)init {
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"消息"), @"tabBarMessage", @"tabBarMessage_highlighted");
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getMessageNum];
    [ZStudentMessageVC refreshMessageNum];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"消息")
    .zChain_setTableViewGary()
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_resetMainView(^{
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
            make.top.equalTo(self.view.mas_top).offset(10);
        }];
    }).zChain_updateDataSource(^{
        self.loading = YES;
        self.param = @{}.mutableCopy;
        if (ValidStr([ZUserHelper sharedHelper].user_id)) {
            self.emptyDataStr = @"您还没有收到过消息";
        }else{
            self.emptyDataStr = @"您还没有登录";
        }
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        NSString *likeNum = @"0";
        NSString *evaNum = @"0";
        NSString *newNum = @"0";
        if (weakSelf.circleModel) {
            if (ValidStr(weakSelf.circleModel.enjoy)) {
                likeNum = weakSelf.circleModel.enjoy;
            }
            if (ValidStr(weakSelf.circleModel.comment)) {
                evaNum = weakSelf.circleModel.comment;
            }
            if (ValidStr(weakSelf.circleModel.follow)) {
                newNum = weakSelf.circleModel.follow;
            }
        }
        
         NSArray *tempArr = @[@[@"finderMessageLike",@"喜欢",likeNum],@[@"finderMessageReceive",@"评论",evaNum],@[@"finderMessageFans",@"新增粉丝",newNum]];
         NSMutableArray *itemArr = @[].mutableCopy;
         for (int i = 0; i < tempArr.count; i++) {
             ZMessageTypeEntryModel *model = [[ZMessageTypeEntryModel alloc] init];
             model.name = tempArr[i][1];
             model.image = tempArr[i][0];
             model.num = tempArr[i][2];
             model.entry_id = i;
             [itemArr addObject:model];
         }
         
         ZCellConfig *entryCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageTypeEntryCell className] title:[ZMessageTypeEntryCell className] showInfoMethod:@selector(setItemArr:) heightOfCell:[ZMessageTypeEntryCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:itemArr];
         [weakSelf.cellConfigArr addObject:entryCellConfig];

        if (!ValidArray(weakSelf.dataSources)) {
            ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZNoDataCell className] title:@"ZNoDataCell" showInfoMethod:@selector(setModel:) heightOfCell:(KScreenHeight - [ZMessageTypeEntryCell z_getCellHeight:nil] - kTopHeight - kTabBarHeight) cellType:ZCellTypeClass dataModel:@"暂无消息"];
            [weakSelf.cellConfigArr addObject:orCellCon1fig];
        }else{
            NSInteger hadRead = 0;
            for (int i = 0; i < weakSelf.dataSources.count; i++) {
                ZMessgeModel *model = weakSelf.dataSources[i];
                if ([model.is_read intValue] >= 1) {
                    hadRead++;
                }
                if (i != 0 && hadRead == 1) {
                    ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageHistoryReadCell className] title:[ZMessageHistoryReadCell className] showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(50) cellType:ZCellTypeClass dataModel:nil];
                    [weakSelf.cellConfigArr addObject:messageCellConfig];
                }
                ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageListCell className] title:[ZMessageListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZMessageListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [weakSelf.cellConfigArr addObject:messageCellConfig];
            }
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZMessageListCell"]) {
            ZMessageListCell *lcell = (ZMessageListCell *)cell;
            lcell.handleBlock = ^(ZMessgeModel * message, NSInteger index) {
                [weakSelf setHandleModel:message index:index];
            };
        }else if ([cellConfig.title isEqualToString:@"ZMessageTypeEntryCell"]) {
            ZMessageTypeEntryCell *lcell = (ZMessageTypeEntryCell *)cell;
            lcell.handleBlock = ^(NSInteger index) {
                if (index == 0) {
                    routePushVC(ZRoute_circle_likeList, nil, nil);
                }else if(index == 1){
                    routePushVC(ZRoute_circle_evaList, nil, nil);
                }else if(index == 2){
                    routePushVC(ZRoute_circle_newFans, nil, nil);
                }
            };
        }
    }).zChain_block_setRefreshHeaderNet(^{
        [weakSelf refreshData];
    }).zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMoreData];
    });
    
    [self readCacheData];
    self.zChain_reload_ui();
    [self.reachability setNotifyBlock:^(YYReachability * _Nonnull reachability) {
        if (weakSelf.loadFromLocalHistory && reachability.reachable) {
            [weakSelf refreshAllData];
        }
    }];
    
}


#pragma mark - Cache
- (void)readCacheData {
    _loadFromLocalHistory = YES;
    
    self.messageNetModel = (ZMessageNetModel *)[ZCurrentUserCache() objectForKey:[ZMessageNetModel className]];
    
    [self.dataSources removeAllObjects];
    [self.dataSources addObjectsFromArray:self.messageNetModel.list];
}

- (void)writeDataToCache {
    [ZCurrentUserCache() setObject:self.messageNetModel forKey:[ZMessageNetModel className]];
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
            weakSelf.loadFromLocalHistory = NO;
            weakSelf.messageNetModel = data;
            [weakSelf writeDataToCache];
            
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
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
    [self setPostCommonData];
    __weak typeof(self) weakSelf = self;
   
    [ZOriganizationStudentViewModel getMessageList:self.param completeBlock:^(BOOL isSuccess, ZMessageNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            weakSelf.zChain_reload_ui();
            
            weakSelf.loadFromLocalHistory = NO;
            weakSelf.messageNetModel = data;
            weakSelf.messageNetModel.list = weakSelf.dataSources;
            [weakSelf writeDataToCache];
            
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
                routePushVC(ZRoute_org_schoolManager, nil, nil);
            }
                break;
        case ZCustomNoticeTypeCourseAudit:                    //  课程审核通知
            {
                routePushVC(ZRoute_org_lessonManage, model.extra.stores_id, nil);
            }
                break;
        case ZCustomNoticeTypePayment:                       //  支付交易通知
            {
                ZOrderListModel *orderModel = [[ZOrderListModel alloc] init];
                orderModel.order_id = model.extra.order_id;
                
                routePushVC(ZRoute_org_orderDetail, orderModel, nil);
            }
                break;
        case ZCustomNoticeTypeRefund:                          //  退款通知
            {
                ZOrderListModel *orderModel = [[ZOrderListModel alloc] init];
                orderModel.order_id = model.extra.order_id;
                orderModel.isRefund = YES;
                
                routePushVC(ZRoute_org_orderDetail, orderModel, nil);
            }
                break;
        case ZCustomNoticeTypeMoneyBack:                      //  回款通知
            {
                routePushVC(ZRoute_org_account, nil, nil);
            }
                break;
        case ZCustomNoticeTypeRegister:                       //  注册通知
            {
                routePushVC(ZRoute_mine_settingMineUs, nil, nil);
            }
                break;
        case ZCustomNoticeTypeAppointment:                     //  预约通知
            {
                ZOrderListModel *orderModel = [[ZOrderListModel alloc] init];
                orderModel.order_id = model.extra.order_id;
                
                routePushVC(ZRoute_org_orderDetail, orderModel, nil);
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
                    
                    routePushVC(ZRoute_org_evaDetail,smodel, nil);
                }else{
                    ZOrderEvaListModel *smodel = [[ZOrderEvaListModel alloc] init];
                    smodel.stores_id = model.extra.stores_id;
                    smodel.order_id = model.extra.order_id;
                    
                    routePushVC(ZRoute_mine_evaDetail, smodel, nil);
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
                        routePushVC(ZRoute_message_messageSend, model, nil);
                    }
                }else{
                    if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
                        routePushVC(ZRoute_message_messageSend, model, nil);
                    }
                }
            }
                break;
        case ZCustomNoticeTypePhoto:
        {
            
        }
            break;
        case ZCustomNoticeTypeCircle:
        {
            routePushVC(ZRoute_circle_mine, [ZUserHelper sharedHelper].user.userCodeID, nil);
        }
            break;
            
        default:
            
            break;
    }
}


- (void)getMessageNum{
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel getCircleNewsData:@{} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && [data isKindOfClass:[ZMessageCircleNewsModel class]]) {
            weakSelf.circleModel = data;
            self.zChain_reload_ui();
        }
    }];
}

+ (void)refreshMessageNum {
    [ZCircleMineViewModel getCircleNewsData:@{} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && [data isKindOfClass:[ZMessageCircleNewsModel class]]) {
            ZMessageCircleNewsModel *circleModel = data;
            if (ValidStr(circleModel.total) && [circleModel.total intValue] > 0) {
                ([ZLaunchManager sharedInstance].tabBarController.tabBar.items[2]).badgeValue = circleModel.total;
            }else{
                ([ZLaunchManager sharedInstance].tabBarController.tabBar.items[2]).badgeValue = nil;
            }
        }
    }];
}

- (void)tabBarItemDidDoubleClick {
    [self refreshAllData];
}

- (void)tabBarItemDidClick:(BOOL)isSelected {
    if (isSelected) {
        [self.iTableView scrollToTopAnimated:YES];
    }
}
@end
