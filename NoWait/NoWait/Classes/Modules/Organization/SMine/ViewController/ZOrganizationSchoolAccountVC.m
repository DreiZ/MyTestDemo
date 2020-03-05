//
//  ZOrganizationSchoolAccountVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSchoolAccountVC.h"
#import "ZOriganizationStudentListCell.h"
#import "ZOrganizationRadiusCell.h"
#import "ZOrganizationAccountTopMainView.h"

#import "ZOrganizationSchoolAccountListVC.h"

@interface ZOrganizationSchoolAccountVC ()
@property (nonatomic,strong) ZOrganizationAccountTopMainView *topView;
@property (nonatomic,strong) UIButton *navLeftBtn;

@end

@implementation ZOrganizationSchoolAccountVC

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
    
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"结算方式";
    model.rightImage = @"rightBlackArrowN";
    model.rightMargin = CGFloatIn750(40);
    model.cellHeight = CGFloatIn750(106);
    model.leftFont = [UIFont boldFontContent];
    model.rightColor = [UIColor colorTextBlack];
    model.rightDarkColor = [UIColor colorTextBlackDark];
    
    ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:[ZSingleLineCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:textCellConfig];
  
    [self.cellConfigArr addObject:textCellConfig];
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationRadiusCell className] title:[ZOrganizationRadiusCell className] showInfoMethod:@selector(setIsTop:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:@""];
    [self.cellConfigArr addObject:bottomCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"账户信息"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]];
}

- (void)setupMainView {
    [super setupMainView];
    
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(384 + 142));
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
        _topView.isSchool = YES;
    }
    return _topView;
}

- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"账单明细" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontSmall]];
        [_navLeftBtn bk_whenTapped:^{
            ZOrganizationSchoolAccountListVC *lvc = [[ZOrganizationSchoolAccountListVC alloc] init];
            [weakSelf.navigationController pushViewController:lvc animated:YES];
        }];
    }
    return _navLeftBtn;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig
 {
    if ([cellConfig.title isEqualToString:@"ZOrganizationRadiusCell"]){
        ZOrganizationRadiusCell *enteryCell = (ZOrganizationRadiusCell *)cell;
        enteryCell.leftMargin = 0;
    }
}
@end
