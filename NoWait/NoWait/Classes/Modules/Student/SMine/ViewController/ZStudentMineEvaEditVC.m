//
//  ZStudentMineEvaEditVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineEvaEditVC.h"
#import "ZCellConfig.h"
#import "ZStudentMineModel.h"
#import "ZStudentMainModel.h"

#import "ZSpaceEmptyCell.h"
#import "ZMineStudentEvaListHadEvaCell.h"
#import "ZStudentLessonOrderIntroItemCell.h"
#import "ZStudentLessonOrderCompleteCell.h"
#import "ZStudentLessonOrderMoreInputCell.h"
#import "ZMineStudentEvaEditStarCell.h"
#import "ZMineStudentEvaEditUpdateImageCell.h"

@interface ZStudentMineEvaEditVC ()

@end
@implementation ZStudentMineEvaEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    {
        //订单基本信息

        NSArray *lists = @[
                        @[@"课程：",@"暑期瑜伽班",[UIColor colorTextBlack]],
                        @[@"老师：",@"赵东来",[UIColor colorTextBlack]],@[@"开课时间：",@"2019-08-21",[UIColor colorTextBlack]]];
        
        NSMutableArray *mList = @[].mutableCopy;
        for (int i = 0; i < lists.count; i++) {
            ZStudentLessonOrderInfoCellModel *cModel = [[ZStudentLessonOrderInfoCellModel alloc] init];
            cModel.title = lists[i][0];
            cModel.subTitle = lists[i][1];
            cModel.subColor = lists[i][2];
            
            [mList addObject:cModel];
        }
        
        ZCellConfig *infoSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:infoSpacCellConfig];
        
        for (int i = 0; i < mList.count; i++) {
            ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderIntroItemCell className] title:[ZStudentLessonOrderIntroItemCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderIntroItemCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:mList[i]];
            [self.cellConfigArr addObject:spacCellConfig];
            ZCellConfig *infoBottomSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(10) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
            [self.cellConfigArr addObject:infoBottomSpacCellConfig];
        }
        ZCellConfig *infoBottomSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:infoBottomSpacCellConfig];
        
        ZCellConfig *infoBottomBlackSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
        [self.cellConfigArr addObject:infoBottomBlackSpacCellConfig];
        
    }
    
   
    {
        ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
               model.leftTitle = @"机构评价";
               
           ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
           [self.cellConfigArr addObject:menuCellConfig];
        {
            
            ZCellConfig *starSpace1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
            [self.cellConfigArr addObject:starSpace1CellConfig];
            
            
            ZCellConfig *starCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditStarCell className] title:[ZMineStudentEvaEditStarCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditStarCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:starCellConfig];
            
            [self.cellConfigArr addObject:starSpace1CellConfig];

            
            ZCellConfig *star1CellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditStarCell className] title:[ZMineStudentEvaEditStarCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditStarCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:star1CellConfig];
            [self.cellConfigArr addObject:starSpace1CellConfig];
        }
        
        ZCellConfig *moreIntputCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderMoreInputCell className] title:[ZStudentLessonOrderMoreInputCell className] showInfoMethod:@selector(setIsBackColor:) heightOfCell:[ZStudentLessonOrderMoreInputCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"yes"];
        [self.cellConfigArr addObject:moreIntputCellConfig];
        
        
        
        ZCellConfig *uploadImageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditUpdateImageCell className] title:[ZMineStudentEvaEditUpdateImageCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditUpdateImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:uploadImageCellConfig];

        
        ZCellConfig *iSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
        [self.cellConfigArr addObject:iSpacCellConfig];
    }
    
    {
         ZStudentDetailOrderSubmitListModel *model = [[ZStudentDetailOrderSubmitListModel alloc] init];
                model.leftTitle = @"教练评价";
                
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderCompleteCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentLessonOrderCompleteCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
         {
             
             ZCellConfig *starSpace1CellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(30) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
             [self.cellConfigArr addObject:starSpace1CellConfig];
             
             
             ZCellConfig *starCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditStarCell className] title:[ZMineStudentEvaEditStarCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditStarCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
             [self.cellConfigArr addObject:starCellConfig];
             
             [self.cellConfigArr addObject:starSpace1CellConfig];
         }
         
         ZCellConfig *moreIntputCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonOrderMoreInputCell className] title:[ZStudentLessonOrderMoreInputCell className] showInfoMethod:@selector(setIsBackColor:) heightOfCell:[ZStudentLessonOrderMoreInputCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"yes"];
         [self.cellConfigArr addObject:moreIntputCellConfig];
         
         
         
         ZCellConfig *uploadImageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaEditUpdateImageCell className] title:[ZMineStudentEvaEditUpdateImageCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaEditUpdateImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
         [self.cellConfigArr addObject:uploadImageCellConfig];

         
         ZCellConfig *iSpacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
         [self.cellConfigArr addObject:iSpacCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"视频课程"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

@end
