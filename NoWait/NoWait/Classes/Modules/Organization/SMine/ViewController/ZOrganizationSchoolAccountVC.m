//
//  ZOrganizationSchoolAccountVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSchoolAccountVC.h"
#import "ZOriganizationStudentListCell.h"
#import "ZSchoolAccountTopMainView.h"
#import "ZOrganizationAccountSchoolCell.h"
#import "ZTableViewListCell.h"

#import "ZOrganizationSchoolAccountListVC.h"
#import "ZOrganizationSchoolAccountDetailVC.h"

#import "ZOriganizationViewModel.h"

@interface ZOrganizationSchoolAccountVC ()
@property (nonatomic,strong) ZSchoolAccountTopMainView *topView;
@property (nonatomic,strong) ZStoresAccountModel *model;

@end

@implementation ZOrganizationSchoolAccountVC


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    
    [self getAccountBill];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSArray *topArr = @[@[@"已打款金额￥",ValidStr(self.model.received_amount)?[NSString stringWithFormat:@"%.2f",[SafeStr(self.model.received_amount) doubleValue]]:@"0.00",@NO,@"hadPay"],
        @[@"待回款金额￥",ValidStr(self.model.surplus_payment_amount)?[NSString stringWithFormat:@"%.2f",[SafeStr(self.model.surplus_payment_amount) doubleValue]]:@"0.00",@YES,@"huikuanpay"],
  @[@"上周期结算金额￥",ValidStr(self.model.pre_receive_amount)?[NSString stringWithFormat:@"%.2f",[SafeStr(self.model.pre_receive_amount) doubleValue]]:@"0.00",@NO,@"shouldPay"],
                        @[@"本周期待结算金额￥",ValidStr(self.model.now_receive_amount)?[NSString stringWithFormat:@"%.2f",[SafeStr(self.model.now_receive_amount) doubleValue]]:@"0.00",@NO,@"benPay"],
                        @[@"剩余课程质押金￥",ValidStr(self.model.surplus_course_deposit)?[NSString stringWithFormat:@"%.2f",[SafeStr(self.model.surplus_course_deposit) doubleValue]]:@"0",@YES,@"left"]];
    for (NSArray *arr in topArr) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = arr[0];
        model.rightTitle = arr[1];
        model.isHiddenLine = [arr[2] boolValue];
        model.cellTitle = arr[3];
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAccountSchoolCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationAccountSchoolCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:textCellConfig];
    }
    
    {
        NSArray *tempArr = @[@"账户信息",
                            SafeStr(self.model.mechanism_name),
                            @"结算方式",
                            SafeStr(self.model.settlement_method),
                            @"须知",
                            [NSString stringWithFormat:@"%@\n%@",SafeStr(self.model.notice),SafeStr(self.model.annotations)]];
        NSInteger index = 1;
        NSMutableArray *configArr = @[].mutableCopy;
        [configArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        for (NSString *text in tempArr) {
            if (index%2 == 1) {
                ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
                model.leftTitle = text;
                model.cellHeight = CGFloatIn750(46);
                model.leftFont = [UIFont boldFontContent];
                model.isHiddenLine = YES;
                
                ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:[ZSingleLineCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [configArr addObject:textCellConfig];
            }else{
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"text")
                .zz_titleLeft(text)
                .zz_lineHidden(YES)
                .zz_leftMultiLine(YES)
                .zz_cellWidth(KScreenWidth-CGFloatIn750(60));
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [configArr addObject:menuCellConfig];
                [configArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
            }
            index ++;
        }
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
        [self.cellConfigArr addObject:bottomCellConfig];
    }
    _topView.model = self.model;
}

- (void)setNavigation {
    self.isHidenNaviBar = YES;
    [self.navigationItem setTitle:@"校区账户信息"];
}

- (void)setupMainView {
    [super setupMainView];
    
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(460));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
        make.top.equalTo(self.topView.mas_bottom).offset(CGFloatIn750(1));
    }];
}

#pragma mark - lazy loading...
- (ZSchoolAccountTopMainView *)topView {
    if (!_topView) {
        __weak typeof(self) weakSelf = self;
        _topView = [[ZSchoolAccountTopMainView alloc] init];
        _topView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else if (index == 3){
                ZOrganizationSchoolAccountListVC *lvc = [[ZOrganizationSchoolAccountListVC alloc] init];
                lvc.type = @"0";
                lvc.stores_id = weakSelf.stores_id;
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            }
        };
    }
    return _topView;
}


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig
 {
    
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"hadPay"]){
        ZOrganizationSchoolAccountDetailVC *dvc = [[ZOrganizationSchoolAccountDetailVC alloc] init];
        dvc.stores_id = self.stores_id;
        [self.navigationController pushViewController:dvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"shouldPay"]){
        ZOrganizationSchoolAccountListVC *lvc = [[ZOrganizationSchoolAccountListVC alloc] init];
        lvc.type = @"1";
        lvc.stores_id = self.stores_id;
        [self.navigationController pushViewController:lvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"benPay"]){
        ZOrganizationSchoolAccountListVC *lvc = [[ZOrganizationSchoolAccountListVC alloc] init];
        lvc.type = @"2";
        lvc.stores_id = self.stores_id;
        [self.navigationController pushViewController:lvc animated:YES];
    }
}

- (void)getAccountBill {
    __weak typeof(self) weakSelf = self;
    self.loading = YES;
    [ZOriganizationViewModel getMerchantsAccount:@{@"stores_id":SafeStr(self.stores_id),@"merchants_id":SafeStr([ZUserHelper sharedHelper].user.userID)} completeBlock:^(BOOL isSuccess, id data) {
        weakSelf.loading = NO;
        if (isSuccess && data && [data isKindOfClass:[ZStoresAccountModel class]]) {
            weakSelf.model = data;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end

#pragma mark - RouteHandler
@interface ZOrganizationSchoolAccountVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationSchoolAccountVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_schoolAccount;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationSchoolAccountVC *routevc = [[ZOrganizationSchoolAccountVC alloc] init];
    routevc.stores_id = request.prts;
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
