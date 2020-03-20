//
//  ZOrganizationMineEvaListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineEvaListVC.h"
#import "ZOrganizationMineEvaDetailVC.h"
#import "ZOrganizationEvaListCell.h"

@interface ZOrganizationMineEvaListVC ()

@end
@implementation ZOrganizationMineEvaListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewGaryBack];
//    [self setNavigation];
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
    
    
    ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListCell className] title:[ZOrganizationEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationEvaListCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
    [self.cellConfigArr addObject:evaCellConfig];
    
    [self.cellConfigArr addObject:evaCellConfig];
    
    [self.cellConfigArr addObject:evaCellConfig];
    [self.cellConfigArr addObject:evaCellConfig];
    [self.cellConfigArr addObject:evaCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"评价管理"];
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
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListCell"]){
        ZOrganizationEvaListCell *enteryCell = (ZOrganizationEvaListCell *)cell;
        enteryCell.evaBlock = ^(NSInteger index) {
            ZOrganizationMineEvaDetailVC *dvc = [[ZOrganizationMineEvaDetailVC alloc] init];
            [self.navigationController pushViewController:dvc animated:YES];
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListCell"]) {
        ZOrganizationMineEvaDetailVC *dvc = [[ZOrganizationMineEvaDetailVC alloc] init];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}
@end
