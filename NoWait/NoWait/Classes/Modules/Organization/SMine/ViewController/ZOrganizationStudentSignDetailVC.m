//
//  ZOrganizationStudentSignDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentSignDetailVC.h"
#import "ZOriganizationTeachListCell.h"
#import "ZOriganizationTeachAddHeadImageCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"
#import "ZOriganizationTextViewCell.h"
#import "ZOriganizationIDCardCell.h"
#import "ZOrganizationCampusTextLabelCell.h"
#import "ZMineStudentEvaListEvaOrderDesCell.h"
#import "ZOriganizationTeachHeadImageCell.h"

#import "ZBaseUnitModel.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZAlertDataPickerView.h"

#import "ZOrganizationCampusManageAddLabelVC.h"
#import "ZOrganizationTeacherLessonSelectVC.h"

@interface ZOrganizationStudentSignDetailVC ()

@end

@implementation ZOrganizationStudentSignDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self setupMainView];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"上课进度";
        model.rightTitle = @"4/10节";
        model.rightFont = [UIFont fontContent];
        model.leftFont = [UIFont boldFontTitle];
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(92);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    {
//        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
//         [self.cellConfigArr addObject:topCellConfig];
           
         ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
         model.isHiddenLine = NO;
         model.lineLeftMargin = CGFloatIn750(30);
         model.lineRightMargin = CGFloatIn750(30);
         model.cellHeight = CGFloatIn750(1);
           
       ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
       [self.cellConfigArr addObject:menuCellConfig];
         

       ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
       [self.cellConfigArr addObject:bottomCellConfig];
    }
    
    {
        NSArray *signArr = @[@[@"已签课", @"2节"],
                             @[@"补签", @"2节"],
                             @[@"请假", @"2节"],
                             @[@"旷课", @"2节"],
                             @[@"待千克", @"2节"]];
        for (int i = 0; i < signArr.count; i++) {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.isHiddenLine = YES;
            model.cellHeight = CGFloatIn750(68);
            model.leftTitle = signArr[i][0];
            model.rightTitle = signArr[i][1];
            model.leftFont = [UIFont fontContent];
            model.rightFont = [UIFont fontContent];
            model.rightColor = [UIColor colorTextGray];
            model.rightDarkColor = [UIColor colorTextGrayDark];
                
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
    {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
         [self.cellConfigArr addObject:topCellConfig];
           
         ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
         model.isHiddenLine = NO;
         model.lineLeftMargin = CGFloatIn750(30);
         model.lineRightMargin = CGFloatIn750(30);
         model.cellHeight = CGFloatIn750(1);
           
       ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
       [self.cellConfigArr addObject:menuCellConfig];
         

       ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
       [self.cellConfigArr addObject:bottomCellConfig];
    }
    
    {
       NSArray *signArr = @[@[@"多咪屋-第四节", @"2019.02.12", @"签课"],
                            @[@"多咪屋-第四节", @"2019.02.12", @"签课"],
                            @[@"多咪屋-第四节", @"2019.02.12", @"签课"],
                            @[@"多咪屋-第四节", @"2019.02.12", @"签课"],
                            @[@"多咪屋-第四节", @"2019.02.12", @"签课"]];
       for (int i = 0; i < signArr.count; i++) {
           ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
           model.leftTitle = signArr[i][0];
           model.content = signArr[i][2];
           model.subTitle = signArr[i][1];
           model.leftContentWidth = CGFloatIn750(322);
           model.isHiddenInputLine = YES;
           model.isHiddenLine = YES;
           model.isTextEnabled = NO;
           model.cellHeight = CGFloatIn750(106);
           model.textAlignment = NSTextAlignmentRight;
           model.leftFont = [UIFont boldFontContent];
           model.subTitleFont = [UIFont fontContent];
           model.textFont = [UIFont fontContent];
           model.subTitleColor = [UIColor colorTextGray];
           model.subTitleDarkColor = [UIColor colorTextGrayDark];
               
           ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
           [self.cellConfigArr addObject:menuCellConfig];
       }
   }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"签到详情"];
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"sex"]) {
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"男",@"女"];
        for (int i = 0; i < temp.count; i++) {
           ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
           model.name = temp[i];
           [items addObject:model];
        }
        
        [ZAlertDataSinglePickerView setAlertName:@"性别选择" items:items handlerBlock:^(NSInteger index) {
           
        }];
    }else if ([cellConfig.title isEqualToString:@"address"]){
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"徐州"];
        for (int i = 0; i < temp.count; i++) {
           ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
           model.name = temp[i];
           
           NSMutableArray *subItems = @[].mutableCopy;
           
           NSArray *temp = @[@"篮球",@"排球",@"乒乓球",@"足球"];
           for (int i = 0; i < temp.count; i++) {
               ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
               model.name = temp[i];
               [subItems addObject:model];
           }
           model.ItemArr = subItems;
           [items addObject:model];
        }
        [ZAlertDataPickerView setAlertName:@"校区选择" items:items handlerBlock:^(NSInteger index, NSInteger subIndex) {
           
        }];
    }else if ([cellConfig.title isEqualToString:@"class"]) {
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"初级教师",@"高级教师"];
        for (int i = 0; i < temp.count; i++) {
            ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
            model.name = temp[i];
            [items addObject:model];
        }
        
        [ZAlertDataSinglePickerView setAlertName:@"教师等级" items:items handlerBlock:^(NSInteger index) {
            
        }];
    }else if ([cellConfig.title isEqualToString:@"skill"]) {
        ZOrganizationCampusManageAddLabelVC *avc = [[ZOrganizationCampusManageAddLabelVC alloc] init];
        
        [self.navigationController pushViewController:avc animated:YES];
    }else if ([cellConfig.title isEqualToString:@"lesson"]) {
        ZOrganizationTeacherLessonSelectVC *avc = [[ZOrganizationTeacherLessonSelectVC alloc] init];
        
        [self.navigationController pushViewController:avc animated:YES];
    }
}

@end
