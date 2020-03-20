//
//  ZOrganizationMineEvaDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineEvaDetailVC.h"
#import "ZOrganizationEvaListLessonCell.h"
#import "ZOrganizationEvaDetailTitleCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZOrganizationEvaListEvaTextViewCell.h"
#import "ZOrganizationEvaListEvaBtnCell.h"
#import "ZOrganizationEvaListReEvaCell.h"

#import "ZOrganizationEvaListCell.h"

@interface ZOrganizationMineEvaDetailVC ()

@end
@implementation ZOrganizationMineEvaDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(220))];
    tableFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    self.iTableView.tableFooterView = tableFooterView;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self lessonEva];
    [self teacherEva];
    [self organizationEva];
    
    {
        ZCellConfig *topSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(120) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topSpaceCellConfig];
        
        ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
        
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListLessonCell className] title:[ZOrganizationEvaListLessonCell className] showInfoMethod:nil heightOfCell:[ZOrganizationEvaListLessonCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:orderCellConfig];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
    }
}

- (void)lessonEva {
    {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaDetailTitleCell className] title:[ZOrganizationEvaDetailTitleCell className] showInfoMethod:nil heightOfCell:[ZOrganizationEvaDetailTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
         [self.cellConfigArr addObject:orderCellConfig];
     }
     {
         ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
         model.rightTitle = @"山东矿机愤怒地说给你哒哒哒哒哒哒多多多多多多多多多多多多多多多多多多多多多多军军军军军军军军军所所死阿嘎我和安慰嘿哈我IE回日为hi偶然华为噢华融我问候人";
         model.isHiddenLine = YES;
         model.cellWidth = KScreenWidth - CGFloatIn750(60);
         model.singleCellHeight = CGFloatIn750(60);
         model.lineLeftMargin = CGFloatIn750(30);
         model.lineRightMargin = CGFloatIn750(30);
         model.cellHeight = CGFloatIn750(62);
         model.lineSpace = CGFloatIn750(10);
         model.rightFont = [UIFont fontContent];
         model.rightColor = [UIColor colorTextBlack];
         model.rightDarkColor =  [UIColor colorTextBlackDark];
         
         ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
         
         [self.cellConfigArr  addObject:menuCellConfig];
     }
     
     {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaTextViewCell className] title:[ZOrganizationEvaListEvaTextViewCell className] showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaTextViewCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
         [self.cellConfigArr addObject:orderCellConfig];
     }
    
     {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaBtnCell className] title:[ZOrganizationEvaListEvaBtnCell className] showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaBtnCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
         [self.cellConfigArr addObject:orderCellConfig];
     }
    
    ZCellConfig *topSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
    [self.cellConfigArr addObject:topSpaceCellConfig];
}


- (void)teacherEva {
    {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaDetailTitleCell className] title:[ZOrganizationEvaDetailTitleCell className] showInfoMethod:nil heightOfCell:[ZOrganizationEvaDetailTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
         [self.cellConfigArr addObject:orderCellConfig];
     }
     {
         ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
         model.rightTitle = @"山东矿机愤怒地说给你哒哒哒哒哒哒多多多多多多多多多多多多多多多多多多多多多多军军军军军军军军军所所死阿嘎我和安慰嘿哈我IE回日为hi偶然华为噢华融我问候人";
         model.isHiddenLine = YES;
         model.cellWidth = KScreenWidth - CGFloatIn750(60);
         model.singleCellHeight = CGFloatIn750(60);
         model.lineLeftMargin = CGFloatIn750(30);
         model.lineRightMargin = CGFloatIn750(30);
         model.cellHeight = CGFloatIn750(62);
         model.lineSpace = CGFloatIn750(10);
         model.rightFont = [UIFont fontContent];
         model.rightColor = [UIColor colorTextBlack];
         model.rightDarkColor =  [UIColor colorTextBlackDark];
         
         ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
         
         [self.cellConfigArr  addObject:menuCellConfig];
     }
    
    ZCellConfig *topSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(80) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
    [self.cellConfigArr addObject:topSpaceCellConfig];
}


- (void)organizationEva {
    {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaDetailTitleCell className] title:[ZOrganizationEvaDetailTitleCell className] showInfoMethod:nil heightOfCell:[ZOrganizationEvaDetailTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
         [self.cellConfigArr addObject:orderCellConfig];
     }
     {
         ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
         model.rightTitle = @"山东矿机愤怒地说给你哒哒哒哒哒哒多多多多多多多多多多多多多多多多多多多多多多军军军军军军军军军所所死阿嘎我和安慰嘿哈我IE回日为hi偶然华为噢华融我问候人";
         model.isHiddenLine = YES;
         model.cellWidth = KScreenWidth - CGFloatIn750(60);
         model.singleCellHeight = CGFloatIn750(60);
         model.lineLeftMargin = CGFloatIn750(30);
         model.lineRightMargin = CGFloatIn750(30);
         model.cellHeight = CGFloatIn750(62);
         model.lineSpace = CGFloatIn750(10);
         model.rightFont = [UIFont fontContent];
         model.rightColor = [UIColor colorTextBlack];
         model.rightDarkColor =  [UIColor colorTextBlackDark];
         
         ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
         
         [self.cellConfigArr  addObject:menuCellConfig];
     }
     {
         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListReEvaCell className] title:[ZOrganizationEvaListReEvaCell className] showInfoMethod:@selector(setEvaDes:) heightOfCell:[ZOrganizationEvaListReEvaCell z_getCellHeight:@"但是噶所过过过过多军军多军军多军多军多军多军军多军多军多军多军多军多军多军多军"] cellType:ZCellTypeClass dataModel:@"但是噶所过过过过多军军多军军多军多军多军多军军多军多军多军多军多军多军多军多军"];
         [self.cellConfigArr addObject:orderCellConfig];
         
     }
//     {
//         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaTextViewCell className] title:[ZOrganizationEvaListEvaTextViewCell className] showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaTextViewCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
//         [self.cellConfigArr addObject:orderCellConfig];
//     }
//
//     {
//         ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaBtnCell className] title:[ZOrganizationEvaListEvaBtnCell className] showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaBtnCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
//         [self.cellConfigArr addObject:orderCellConfig];
//     }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"评价详情"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark lazy loading...
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListLessonCell"]){
        ZOrganizationEvaListLessonCell *lcell = (ZOrganizationEvaListLessonCell *)cell;
        lcell.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        lcell.contView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
//        enteryCell.evaBlock = ^{
////            ZStudentMineEvaEditVC *evc = [[ZStudentMineEvaEditVC alloc] init];
////            [self.navigationController pushViewController:evc animated:YES];
//        };
    }
}
@end

