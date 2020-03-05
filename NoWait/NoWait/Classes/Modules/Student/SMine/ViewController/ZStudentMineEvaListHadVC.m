//
//  ZStudentMineEvaListHadVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineEvaListHadVC.h"
#import "ZCellConfig.h"
#import "ZStudentMineModel.h"

#import "ZSpaceEmptyCell.h"
#import "ZMineStudentEvaListHadEvaCell.h"

@interface ZStudentMineEvaListHadVC ()

@end
@implementation ZStudentMineEvaListHadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZStudentOrderEvaModel *evaModel = [[ZStudentOrderEvaModel alloc] init];
    evaModel.orderImage = @"lessonOrder";
    evaModel.orderNum = @"23042039523452";
    evaModel.lessonTitle = @"仰泳";
    evaModel.lessonTime = @"2019-10-26";
    evaModel.lessonCoach = @"高圆圆";
    evaModel.lessonOrg = @"上飞天俱乐部";
    evaModel.coachStar = @"3.4";
    evaModel.coachEva = @"吊柜好尬施工阿红化工诶按文化宫我胡搜ID哈工我哈山东IG后is阿活动IG华东师范";
    evaModel.coachEvaImages = @[@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2"];

    evaModel.orgStar = @"4.5";
    evaModel.orgEva = @"反反复复付受到法律和";
    evaModel.orgEvaImages =  @[@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2",@"studentListItem2"];;
    
    
    ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaListHadEvaCell className] title:[ZMineStudentEvaListHadEvaCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZMineStudentEvaListHadEvaCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
    
    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
    [self.cellConfigArr addObject:evaCellConfig];
    
    [self.cellConfigArr addObject:spacCellConfig];
    [self.cellConfigArr addObject:evaCellConfig];
    [self.cellConfigArr addObject:spacCellConfig];
    [self.cellConfigArr addObject:evaCellConfig];
    [self.cellConfigArr addObject:spacCellConfig];
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

