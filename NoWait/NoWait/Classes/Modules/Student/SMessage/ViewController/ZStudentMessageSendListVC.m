//
//  ZStudentMessageSendListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMessageSendListVC.h"
#import "ZOriganizationStudentViewModel.h"

@interface ZStudentMessageSendListVC ()
@property (nonatomic,strong) ZMessageInfoModel *infoModel;

@end

@implementation ZStudentMessageSendListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"收件人列表")
    .zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];

        if (ValidArray(self.infoModel.account )) {
            [weakSelf.infoModel.account enumerateObjectsUsingBlock:^(ZMessageAccountModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"ZLineCellModel");
                
                model.leftTitle = obj.nick_name;
                model.isHiddenLine = YES;
                model.cellHeight = CGFloatIn750(96);
                model.leftFont = [UIFont fontContent];
                model.leftImage = obj.image;
                model.leftImageH = CGFloatIn750(70);
                model.zz_imageLeftRadius(YES);
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                
                [weakSelf.cellConfigArr addObject:menuCellConfig];
            }];
        }
    }).zChain_block_setRefreshHeaderNet(^{
        self.loading = YES;
        [ZOriganizationStudentViewModel getSendMessageInfo:@{@"id":SafeStr(self.model.message_id)} completeBlock:^(BOOL isSuccess, ZMessageInfoModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                weakSelf.infoModel = data;
                
                weakSelf.zChain_reload_ui();
                [weakSelf.iTableView tt_endRefreshing];
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView reloadData];
                [weakSelf.iTableView tt_endRefreshing];
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }
        }];
    });

    self.zChain_reload_Net();
}

@end

#pragma mark - RouteHandler
@interface ZStudentMessageSendListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentMessageSendListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_circle_messageSend;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentMessageSendListVC *routevc = [[ZStudentMessageSendListVC alloc] init];
    routevc.model = request.prts;
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
