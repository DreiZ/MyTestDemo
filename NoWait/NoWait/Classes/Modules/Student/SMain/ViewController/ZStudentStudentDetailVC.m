//
//  ZStudentStudentDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStudentDetailVC.h"
#import "ZStudentStudentInfoDesCell.h"
#import "ZStudentCoachInfoTitleCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZStudentImageCollectionCell.h"
#import "ZOriganizationStudentViewModel.h"


@interface ZStudentStudentDetailVC ()
@property (nonatomic,strong) ZOriganizationStudentAddModel *addModel;

@end

@implementation ZStudentStudentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshInfoData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    if (!self.addModel) {
        return;
    }
    
    ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStudentInfoDesCell className] title:[ZStudentStudentInfoDesCell className] showInfoMethod:@selector(setAddModel:) heightOfCell:[ZStudentStudentInfoDesCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.addModel];
    [self.cellConfigArr addObject:desCellConfig];

    {
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"学员介绍"];
        [self.cellConfigArr addObject:titleCellConfig];
    }
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = self.addModel.specialty_desc;
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth;
        model.singleCellHeight = CGFloatIn750(60);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.leftContentSpace = CGFloatIn750(0);
        model.rightContentSpace = CGFloatIn750(0);
        model.cellHeight = CGFloatIn750(62);
        model.rightFont = [UIFont fontContent];
        model.rightColor = [UIColor colorTextBlack];
        model.rightDarkColor =  [UIColor colorTextBlackDark];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    
    {
        ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"学员相册"];
        [self.cellConfigArr addObject:titleCellConfig];
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentImageCollectionCell className] title:[ZStudentImageCollectionCell className] showInfoMethod:@selector(setImages:) heightOfCell:[ZStudentImageCollectionCell z_getCellHeight:self.addModel.images_list] cellType:ZCellTypeClass dataModel:self.addModel.images_list];
        [self.cellConfigArr addObject:titleCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"学员详情"];
}


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig
{
    
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZStudentImageCollectionCell"]){
        ZStudentImageCollectionCell *lcell = (ZStudentImageCollectionCell *)cell;
        lcell.menuBlock = ^(NSInteger index) {
            [[ZPhotoManager sharedManager] showBrowser:weakSelf.addModel.images_list withIndex:index];
        };
    }  
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
   
    
}



#pragma mark - refresha
- (void)refreshInfoData {
    __weak typeof(self) weakSelf = self;
    self.loading = YES;
    [ZOriganizationStudentViewModel getStoresStudentDetail:@{@"student_id":SafeStr(self.student_id),@"stores_id":SafeStr(self.stores_id)} completeBlock:^(BOOL isSuccess, ZOriganizationStudentAddModel *addModel) {
        weakSelf.loading = NO;
        if (isSuccess) {
            weakSelf.addModel = addModel;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }
    }];
}

@end


