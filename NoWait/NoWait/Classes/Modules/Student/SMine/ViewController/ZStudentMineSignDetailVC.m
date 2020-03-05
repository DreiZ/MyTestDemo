//
//  ZStudentMineSignDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSignDetailVC.h"
#import "ZCellConfig.h"
#import "ZAlertQRCodeView.h"
#import "ZSpaceEmptyCell.h"
#import "ZStudentMineSignDetailHandleCell.h"

@interface ZStudentMineSignDetailVC ()

@end
@implementation ZStudentMineSignDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"上课进度";
        model.rightTitle = @"4/10节";
        model.isHiddenLine = NO;
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(110);
        model.leftFont = [UIFont boldFontTitle];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:@"top" showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(10)cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        
        [self.cellConfigArr addObject:topCellConfig];
        
        NSArray *tempArr = @[@[@"已签课", @"2节"],@[@"补签", @"2节"],@[@"请假", @"2节"],@[@"旷课", @"2节"],@[@"待签课", @"2节"]];
        for (int i = 0; i < tempArr.count; i++) {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.leftTitle = tempArr[i][0];
            model.rightTitle = tempArr[i][1];
            model.leftMargin = CGFloatIn750(30);
            model.isHiddenLine = YES;
            model.cellHeight = CGFloatIn750(66);
            model.leftFont = [UIFont fontContent];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:@"top" showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:bottomCellConfig];
    }
    
    ZCellConfig *spaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:@"top" showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
    
    [self.cellConfigArr addObject:spaceCellConfig];
    
    
    {
           ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
           model.leftTitle = @"多咪屋";
           model.isHiddenLine = NO;
           model.lineLeftMargin = CGFloatIn750(30);
           model.lineRightMargin = CGFloatIn750(30);
           model.cellHeight = CGFloatIn750(110);
           model.leftFont = [UIFont boldFontContent];
           
           ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
           
           [self.cellConfigArr addObject:menuCellConfig];
       }
       {
           ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:@"top" showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(10)cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
           
           [self.cellConfigArr addObject:topCellConfig];
           
           NSArray *tempArr = @[@[@"已签课", @"2节"],@[@"补签", @"2节"],@[@"请假", @"2节"],@[@"旷课", @"2节"],@[@"待签课", @"2节"]];
           for (int i = 0; i < tempArr.count; i++) {
               ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
               model.leftTitle = tempArr[i][0];
               model.rightTitle = tempArr[i][1];
               model.leftMargin = CGFloatIn750(30);
               model.isHiddenLine = YES;
               model.cellHeight = CGFloatIn750(80);
               model.leftFont = [UIFont fontContent];
               
               ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSignDetailHandleCell className] title:@"ZStudentMineSignDetailHandleCell" showInfoMethod:@selector(setModel:) heightOfCell:model.cellHeight cellType:ZCellTypeClass dataModel:model];
               
               [self.cellConfigArr addObject:menuCellConfig];
           }
           
           ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:@"top" showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
           [self.cellConfigArr addObject:bottomCellConfig];
       }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"课程详情"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMineSignDetailHandleCell"]){
        ZStudentMineSignDetailHandleCell *scell = (ZStudentMineSignDetailHandleCell *)cell;
        scell.handleBlock = ^(NSInteger index) {
            [ZAlertQRCodeView setAlertWithTitle:@"请教练扫码完成签课" qrCode:@"http://api.k780.com:88/?app=qr.get&data=http://www.baidu.com" handlerBlock:^(NSInteger index) {
                
            }];
        };
    }
}

@end
