//
//  ZStudentOrderPayVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrderPayVC.h"
#import "ZSpaceEmptyCell.h"
//#import "ZPayManager.h"

@interface ZStudentOrderPayVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@property (nonatomic,strong) UIView *footerView;

@end

@implementation ZStudentOrderPayVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.analyzeTitle = @"支付选择页";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self setupMainView];
}

-(void)dealloc {
    [kNotificationCenter removeObserver:self];
}

- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
//    [[kNotificationCenter rac_addObserverForName:KNotificationPayBack object:nil] subscribeNext:^(NSNotification *notfication) {
//        if (notfication.object && [notfication.object isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *backDict = notfication.object;
//            if (backDict && [backDict objectForKey:@"payState"]) {
//                if ([backDict[@"payState"] integerValue] == 0) {
//                    [self.navigationController popViewControllerAnimated:YES];
//                }else if ([backDict[@"payState"] integerValue] == 1) {
//                    if (backDict && [backDict objectForKey:@"msg"]) {
//                        [TLUIUtility showAlertWithTitle:@"支付结果" message:backDict[@"msg"]];
//                    }
//                }else if ([backDict[@"payState"] integerValue] == 2) {
//
//                }else if ([backDict[@"payState"] integerValue] == 3) {
//                    if (backDict && [backDict objectForKey:@"msg"]) {
//                        [TLUIUtility showAlertWithTitle:@"支付结果" message:backDict[@"msg"]];
//                    }
//                }
//            }
//        }
//    }];
//
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
    
    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor(KBackColor, K2eBackColor)];
    [self.cellConfigArr addObject:spacCellConfig];
    
    
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"支付金额";
    model.rightTitle = @"￥423";
    model.isHiddenLine = YES;
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    
    [self.cellConfigArr addObject:menuCellConfig];
    {
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor(KBackColor, K2eBackColor)];
        [self.cellConfigArr addObject:spacCellConfig];
        
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"微信支付";
        model.leftImage = @"wechatPay";
        model.rightImage = @"studentSelect";
        model.isHiddenLine = NO;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"支付宝支付";
        model.leftImage = @"alipay";
        model.rightImage = @"studentSelect";
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)setNavigation {
    [self.navigationItem setTitle:@"支付"];
}

- (void)setupMainView {
    
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(180));
    }];
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.footerView.mas_top);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.backgroundColor = KBackColor;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
    }
    return _iTableView;
}


-(UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
        _footerView.backgroundColor = [UIColor whiteColor];
        
        UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        doneBtn.layer.masksToBounds = YES;
        doneBtn.layer.cornerRadius = CGFloatIn750(40);
        [doneBtn setTitle:@"确定提交" forState:UIControlStateNormal];
        [doneBtn setBackgroundColor:KMainColor forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [doneBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(32)]];
        [_footerView addSubview:doneBtn ];
        [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(80));
            make.left.equalTo(self.footerView.mas_left).offset(CGFloatIn750(20));
            make.right.equalTo(self.footerView.mas_right).offset(-CGFloatIn750(20));
            make.top.equalTo(self.footerView.mas_top);
        }];
        
        __weak typeof(self) weakSelf = self;
        [doneBtn bk_addEventHandler:^(id sender) {
//            if (weakSelf.payModel.isAliPay) {
//                if (weakSelf.payModel.order_sn) {
//                    NSMutableDictionary *params = @{@"order_no":weakSelf.payModel.order_sn}.mutableCopy;
//                    [TLUIUtility showLoading:@"获取支付信息"];
//                    [[ZPayManager sharedManager] getAliPayInfo:params complete:^(BOOL isSuccess, NSString *message) {
//                        [TLUIUtility hiddenLoading];
//                    }];
//                    if (weakSelf.payModel.payMoney) {
//                        [[ZPayManager sharedManager] setPayValue:@{@"order_no":weakSelf.payModel.order_sn ,@"order_money":weakSelf.payModel.payMoney ,@"pay_type":@"aliPay"}];
//                    }
//                }
//            }else{
//                if (weakSelf.payModel.order_sn) {
//                    NSMutableDictionary *params = @{@"order_no":weakSelf.payModel.order_sn}.mutableCopy;
//                    [TLUIUtility showLoading:@"获取支付信息"];
//                    [[ZPayManager sharedManager] getWechatPayInfo:params complete:^(BOOL isSuccess, NSString *message) {
//                        [TLUIUtility hiddenLoading];
//                    }];
//                    if (weakSelf.payModel.payMoney) {
//                        [[ZPayManager sharedManager] setPayValue:@{@"order_no":weakSelf.payModel.order_sn ,@"order_money":weakSelf.payModel.payMoney ,@"pay_type":@"wechatPay"}];
//                    }
//                }
//            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _footerView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"alipay"]){
//        ZMineOrderPayTypeCell *payCell = (ZMineOrderPayTypeCell *)cell;
//        payCell.isAli = YES;
    }else if ([cellConfig.title isEqualToString:@"wechatpay"]){
//        ZMineOrderPayTypeCell *payCell = (ZMineOrderPayTypeCell *)cell;
//        payCell.isAli = NO;
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"wechatpay"] || [cellConfig.title isEqualToString:@"alipay"]) {
//        self.payModel.isAliPay = !self.payModel.isAliPay;
        [self initCellConfigArr];
        [self.iTableView reloadData];
    }
}

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
@end

