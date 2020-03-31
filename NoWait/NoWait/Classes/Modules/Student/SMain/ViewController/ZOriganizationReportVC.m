//
//  ZOriganizationReportVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationReportVC.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZStudentLabelCell.h"
#import "ZAlertView.h"

@interface ZOriganizationReportVC ()
@property (nonatomic,strong) NSArray *titleArr;

@end

@implementation ZOriganizationReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    
    [self.navigationItem setTitle:@"投诉"];
}

- (void)setDataSource {
    [super setDataSource];
    _titleArr = @[@"垃圾营销", @"涉黄信息",@"不实信息", @"人身攻击",@"有害信息", @"内容信息",@"内容抄袭", @"诈骗信息"];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = @"所得到的";
        model.isHiddenLine = YES;
        model.leftTitle = @"投诉";
        model.cellWidth = KScreenWidth - CGFloatIn750(60);
        model.singleCellHeight = CGFloatIn750(78);
        model.cellHeight = CGFloatIn750(80);
        model.lineSpace = CGFloatIn750(2);
        model.rightFont = [UIFont boldFontContent];
        model.leftFont = [UIFont fontContent];
        model.rightColor = [UIColor colorTextBlack];
        model.rightDarkColor =  [UIColor colorTextBlackDark];
        model.leftColor = [UIColor colorTextGray];
        model.leftDarkColor =  [UIColor colorTextGrayDark];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.leftTitle = @"选择你想要投诉的类型";
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth - CGFloatIn750(60);
        model.singleCellHeight = CGFloatIn750(78);
        model.cellHeight = CGFloatIn750(80);
        model.lineSpace = CGFloatIn750(2);
        model.leftFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLabelCell className] title:@"label" showInfoMethod:@selector(setTitleArr:) heightOfCell:[ZStudentLabelCell z_getCellHeight:self.titleArr] cellType:ZCellTypeClass dataModel:self.titleArr];
    
    [self.cellConfigArr  addObject:menuCellConfig];
    
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"label"]) {
        ZStudentLabelCell *lcell = (ZStudentLabelCell *)cell;
        lcell.handleBlock = ^(NSString * text) {
            [ZAlertView setAlertWithTitle:@"提示" subTitle:[NSString stringWithFormat:@"确定举报 %@ %@",self.sTitle,text] leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
                
            }];
        };
    }
}
@end

