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
@property (nonatomic,strong) NSMutableArray *mounthData1;
@property (nonatomic,strong) NSMutableArray *weeksData2;


@end

@implementation ZOrganizationCampusManageTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)setDataSource {
    [super setDataSource];
    
    if (!self.start || self.start.length == 0) {
        self.start = @"00:00";
    }
    
    if (!self.end || self.end.length == 0) {
        self.end = @"00:00";
    }
    
    NSMutableArray *menulist = @[].mutableCopy;
    for (int i = 0; i < 12; i++) {
        ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
        model.name = [NSString stringWithFormat:@"%d月",i+1];
        [menulist addObject:model];
    }
    self.mounthData1 = menulist;
    if (self.months) {
        for (int i = 0; i < self.months.count; i++) {
            if ([self.months[i] intValue] - 1 < 12 && [self.months[i] intValue] - 1 >= 0) {
                ZBaseUnitModel *model = menulist[[self.months[i] intValue] - 1];
                model.isSelected = YES;
            }
        }
    }
    
    NSMutableArray *tweeks = @[].mutableCopy;
    NSArray *weekArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期七"];
    for (int i = 0; i < weekArr.count; i++) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = weekArr[i];
        model.leftMargin = CGFloatIn750(60);
        model.rightMargin = CGFloatIn750(60);
        model.cellHeight = CGFloatIn750(96);
        model.leftFont = [UIFont fontMaxTitle];
        model.rightImage = @"unSelectedCycle";
        model.isHiddenLine = YES;
        
        [tweeks addObject:model];
    }
    self.weeksData2 = tweeks;
    if (self.weeks) {
        for (int i = 0; i < self.weeks.count; i++) {
            if ([self.weeks[i] intValue] - 1 < 7 && [self.weeks[i] intValue] - 1 >= 0) {
                ZBaseSingleCellModel *model = _weeksData2[[self.weeks[i] intValue] - 1];
                model.isSelected = YES;
                model.rightImage = @"selectedCycle";
            }
        }
    }
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
    
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTimeSelectCell className] title:[ZOrganizationTimeSelectCell className] showInfoMethod:@selector(setChannelList:) heightOfCell:[ZOrganizationTimeSelectCell z_getCellHeight:self.mounthData1] cellType:ZCellTypeClass dataModel:self.mounthData1];
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
        
        for (int i = 0; i < self.weeksData2.count; i++) {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:@"week" showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:self.weeksData2[i]] cellType:ZCellTypeClass dataModel:self.weeksData2[i]];
            
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
            
            ZCellConfig *hourCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTimeHourCell className] title:@"ZOrganizationTimeHourCell" showInfoMethod:nil heightOfCell:[ZOrganizationTimeHourCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:hourCellConfig];
        }
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"营业时间"];
    __weak typeof(self) weakSelf = self;
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont fontSmall]];
    [sureBtn bk_whenTapped:^{
        if (weakSelf.timeBlock) {
            [weakSelf checkSelectTime];
            weakSelf.timeBlock(weakSelf.months, weakSelf.weeks, weakSelf.start, weakSelf.end);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
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
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOrganizationTimeHourCell"]) {
        ZOrganizationTimeHourCell *lcell = (ZOrganizationTimeHourCell *)cell;
        [lcell setStart:self.start end:self.end];
        lcell.handleBlock = ^(NSString *start, NSString *end) {
            weakSelf.start = start;
            weakSelf.end = end;
        };
    }else if ([cellConfig.title isEqualToString:@"ZOrganizationTimeSelectCell"]){
        ZOrganizationTimeSelectCell *lcell = (ZOrganizationTimeSelectCell *)cell;
        lcell.menuBlock = ^(ZBaseUnitModel * model) {
//
//
//            [weakSelf initCellConfigArr];
//            [weakSelf.iTableView reloadData];
        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"week"]){
        ZBaseSingleCellModel *model = cellConfig.dataModel;
         for (ZBaseSingleCellModel *smodel in self.weeksData2) {
             if ([smodel.leftTitle isEqualToString:model.leftTitle]) {
                 smodel.isSelected = !smodel.isSelected;
                 if (smodel.isSelected) {
                     smodel.rightImage = @"selectedCycle";
                 }else{
                     smodel.rightImage = @"unSelectedCycle";
                 }
             }
         }
         
         [self initCellConfigArr];
         [self.iTableView reloadData];
//         NSInteger weekid = 0;
//         for (int i = 0; i < self.weeksData2.count; i++) {
//             ZBaseSingleCellModel *tmodel = self.weeksData2[i];
//             if ([tmodel.leftTitle isEqualToString:model.leftTitle]) {
//                 weekid = i;
//             }
//         }
    }
}


-(void)checkSelectTime {
    NSMutableArray *mouths = @[].mutableCopy;
    for (ZBaseUnitModel *model in self.mounthData1) {
        if (model.isSelected) {
            [mouths addObject:model.name];
        }
    }
    
    NSMutableArray *weeks = @[].mutableCopy;
    for (ZBaseSingleCellModel *model in self.weeksData2) {
        if (model.isSelected) {
            NSArray *weekArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期七"];
            for (int i = 0; i < weekArr.count; i++) {
                if ([model.leftTitle isEqualToString:weekArr[i]]) {
                    [weeks addObject:[NSString stringWithFormat:@"%d",i+1]];
                }
            }
        }
    }
    
    self.weeks = weeks;
    self.months = mouths;
}
@end
