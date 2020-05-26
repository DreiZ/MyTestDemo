//
//  ZOrganizationAccountVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationAccountVC.h"
#import "ZOriganizationStudentListCell.h"
#import "ZOrganizationRadiusCell.h"
#import "ZOrganizationAccountTopMainView.h"

#import "ZOrganizationSchoolAccountVC.h"
#import "ZOriganizationViewModel.h"

@interface ZOrganizationAccountVC ()
@property (nonatomic,strong) ZOrganizationAccountTopMainView *topView;
@property (nonatomic,strong) ZStoresAccountModel *model;

@end

@implementation ZOrganizationAccountVC

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getAccountBill];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationRadiusCell className] title:[ZOrganizationRadiusCell className] showInfoMethod:@selector(setIsTop:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:@"yes"];
    [self.cellConfigArr addObject:topCellConfig];
    
    [self.model.list_stores  enumerateObjectsUsingBlock:^(ZStoresAccountListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = ValidStr(obj.stores_name)? obj.stores_name : @"";
        model.rightTitle = [NSString stringWithFormat:@"￥%@",ValidStr(obj.total_amount) ? SafeStr(obj.total_amount):@"0"];
        model.rightImage = @"rightBlackArrowN";
        model.rightMargin = CGFloatIn750(40);
        model.cellHeight = CGFloatIn750(106);
        model.leftFont = [UIFont fontContent];
        model.rightFont = [UIFont fontContent];
        model.rightColor = [UIColor colorTextBlack];
        model.rightDarkColor = [UIColor colorTextBlackDark];
        model.data = obj;
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:[ZSingleLineCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:textCellConfig];
    }];
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationRadiusCell className] title:[ZOrganizationRadiusCell className] showInfoMethod:@selector(setIsTop:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:@""];
    [self.cellConfigArr addObject:bottomCellConfig];
    
    _topView.nameLabel.text = [NSString stringWithFormat:@"%@",ValidStr(self.model.mechanism_name)? self.model.mechanism_name : @""];
    _topView.numLabel.text = [NSString stringWithFormat:@"￥%@",ValidStr(self.model.merchants_total_amount) ? SafeStr(self.model.merchants_total_amount):@"0"];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"账户信息"];
}

- (void)setupMainView {
    [super setupMainView];
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(384));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
     make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
     make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
     make.top.equalTo(self.topView.mas_bottom).offset(CGFloatIn750(1));
    }];
}

#pragma mark lazy loading...
- (ZOrganizationAccountTopMainView *)topView {
    if (!_topView) {
        _topView = [[ZOrganizationAccountTopMainView alloc] init];
    }
    return _topView;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig
{
    if ([cellConfig.title isEqualToString:@"ZOrganizationRadiusCell"]){
        ZOrganizationRadiusCell *enteryCell = (ZOrganizationRadiusCell *)cell;
        enteryCell.leftMargin = 0;
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZSingleLineCell"]) {
        ZOrganizationSchoolAccountVC *avc = [[ZOrganizationSchoolAccountVC alloc] init];
        ZBaseSingleCellModel *cellModel = cellConfig.dataModel;
        ZStoresAccountListModel *listModel = cellModel.data;
        avc.stores_id = listModel.stores_id;
        [self.navigationController pushViewController:avc animated:YES];
    }
}


- (void)getAccountBill {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationViewModel getMerchantsAccount:@{@"merchants_id":SafeStr([ZUserHelper sharedHelper].user.userID)} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && data && [data isKindOfClass:[ZStoresAccountModel class]]) {
            weakSelf.model = data;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end
