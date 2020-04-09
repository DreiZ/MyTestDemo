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
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZTableViewListCell.h"

#import "ZOrganizationSchoolAccountListVC.h"
#import "ZOrganizationSchoolAccountDetailVC.h"

@interface ZOrganizationSchoolAccountVC ()
@property (nonatomic,strong) ZSchoolAccountTopMainView *topView;

@end

@implementation ZOrganizationSchoolAccountVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSArray *topArr = @[@[@"已打款金额￥",@"2001",@NO,@"hadPay"],@[@"应打款金额￥",@"2001",@NO,@"shouldPay"],@[@"剩余金额￥",@"2001",@YES,@"left"]];
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
                            @"有限公司",
                            @"结算方式",
                            @"月结",
                            @"须知",
                            @"坎坎坷坷扩所扩所扩扩所扩所扩"];
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
                ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
                model.rightTitle = text;
                model.isHiddenLine = YES;
                model.cellWidth = KScreenWidth - CGFloatIn750(60);
                model.singleCellHeight = CGFloatIn750(44);
                model.cellHeight = CGFloatIn750(46);
                model.lineSpace = CGFloatIn750(8);
                model.rightFont = [UIFont fontContent];
                model.rightColor = [UIColor colorTextBlack];
                model.rightDarkColor =  [UIColor colorTextBlackDark];
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [configArr addObject:menuCellConfig];
                [configArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
            }
            index ++;
        }
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
        [self.cellConfigArr addObject:bottomCellConfig];
    }
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
        [self.navigationController pushViewController:dvc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"shouldPay"]){
        ZOrganizationSchoolAccountListVC *lvc = [[ZOrganizationSchoolAccountListVC alloc] init];
        lvc.type = 2;
        [self.navigationController pushViewController:lvc animated:YES];
    }
}
@end
