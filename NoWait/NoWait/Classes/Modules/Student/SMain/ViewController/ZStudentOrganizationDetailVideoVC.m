//
//  ZStudentOrganizationDetailVideoVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailVideoVC.h"
#import "ZVideoPlayerManager.h"
#import "ZCellConfig.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentOrganizationDetailIVideoCell.h"

@interface ZStudentOrganizationDetailVideoVC ()
@end
@implementation ZStudentOrganizationDetailVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    {
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
        [self.cellConfigArr addObject:spacCellConfig];
        for (int i = 0; i < 18; i++) {
            ZStudentDetailContentListModel *model = [[ZStudentDetailContentListModel alloc] init];
            model.image = [NSString stringWithFormat:@"wallhaven%u",arc4random_uniform(4)+1];
            ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIVideoCell className] title:[ZStudentOrganizationDetailIVideoCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIVideoCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:lessonCellConfig];
        }
    }
    
    {
        ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
        [self.cellConfigArr addObject:spacCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"环境"];
}

- (void)setupMainView {
    [super setupMainView];
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(100));
        make.top.equalTo(self.view.mas_top).offset(1);
    }];
}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailIVideoCell"]) {
        [[ZVideoPlayerManager sharedInstance] playVideoWithUrl:@"https://cxapp-dev-web.oss-cn-shanghai.aliyuncs.com/appm/uploads/20190604/480p.mp4" title:@"健身视频"];
    }
}
@end
