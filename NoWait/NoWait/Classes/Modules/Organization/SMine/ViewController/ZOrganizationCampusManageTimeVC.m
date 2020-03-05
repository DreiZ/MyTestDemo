//
//  ZOrganizationCampusManageTimeVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCampusManageTimeVC.h"
#import "ZOrganizationCampusManagementAddressVC.h"

#import "ZOrganizationTimeSelectCell.h"
#import "ZOrganizationTimeHourCell.h"


@interface ZOrganizationCampusManageTimeVC ()
@end

@implementation ZOrganizationCampusManageTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
    [self.cellConfigArr addObject:topCellConfig];
    
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"营业月份";
    model.leftMargin = CGFloatIn750(30);
    model.cellHeight = CGFloatIn750(40);
    model.leftFont = [UIFont boldFontTitle];
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    
    [self.cellConfigArr addObject:menuCellConfig];
    NSMutableArray *menulist = @[].mutableCopy;
    for (int i = 0; i < 12; i++) {
        ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
        model.name = [NSString stringWithFormat:@"%d月",i+1];
        [menulist addObject:model];
        if (i == 0) {
            model.isSelected = YES;
        }
    }
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTimeSelectCell className] title:[ZOrganizationTimeSelectCell className] showInfoMethod:@selector(setChannelList:) heightOfCell:[ZOrganizationTimeSelectCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:menulist];
    [self.cellConfigArr addObject:progressCellConfig];
    
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"营业时间";
        model.leftMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(60);
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
        
        {
            NSArray *weekArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期七"];
            for (int i = 0; i < weekArr.count; i++) {
                ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
                model.leftTitle = weekArr[i];
                model.leftMargin = CGFloatIn750(60);
                model.rightMargin = CGFloatIn750(60);
                model.cellHeight = CGFloatIn750(96);
                model.leftFont = [UIFont fontMaxTitle];
                model.rightImage = @"selectedCycle";//unSelectedCycle
                model.isHiddenLine = YES;
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:@"week" showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                
                [self.cellConfigArr addObject:menuCellConfig];
                
            }
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.lineLeftMargin = CGFloatIn750(30);
            model.lineRightMargin = CGFloatIn750(30);
            model.isHiddenLine = NO;

            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:CGFloatIn750(2) cellType:ZCellTypeClass dataModel:model];

            [self.cellConfigArr addObject:menuCellConfig];

        }
        
        
        {
            ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
            [self.cellConfigArr addObject:topCellConfig];
            
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = @"营业时段";
            model.leftMargin = CGFloatIn750(30);
            model.cellHeight = CGFloatIn750(60);
            model.leftFont = [UIFont boldFontTitle];

            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

            [self.cellConfigArr addObject:menuCellConfig];
            
            ZCellConfig *hourCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTimeHourCell className] title:model.cellTitle showInfoMethod:nil heightOfCell:[ZOrganizationTimeHourCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:nil];

            [self.cellConfigArr addObject:hourCellConfig];
            
        }
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"营业时间"];
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont fontSmall]];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:sureBtn]];
}

- (void)setupMainView {
    [super setupMainView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(140))];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
    self.iTableView.tableFooterView = bottomView;
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"address"]) {
        ZOrganizationCampusManagementAddressVC *mvc = [[ZOrganizationCampusManagementAddressVC alloc] init];
        [self.navigationController pushViewController:mvc animated:YES];
    }
}

@end
