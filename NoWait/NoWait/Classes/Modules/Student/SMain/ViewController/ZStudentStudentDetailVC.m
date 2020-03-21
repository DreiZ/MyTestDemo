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

@interface ZStudentStudentDetailVC ()
@end

@implementation ZStudentStudentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    

    ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStudentInfoDesCell className] title:[ZStudentStudentInfoDesCell className] showInfoMethod:nil heightOfCell:[ZStudentStudentInfoDesCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:desCellConfig];

    {
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"学员介绍"];
        [self.cellConfigArr addObject:titleCellConfig];
        
    }
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = @"       再看见本公司的办公空间吧圣诞节看过吧上课进度不干胶埃斯科巴豆腐干不撒地方借款圣诞节奥卡福会计师的年份里看见那丝黛芬妮读书卡不放过金卡戴珊不放开酒吧SDK基本覆盖八十多会计法、\n      的撒哈佛我会受到if后isad哈佛我胡搜分红天河湾\n水电费后我阿萨德哈佛好滴时候\n     第三方会爱上大会GFUI海带丝胡覅USD哈弗hi欧舍噢问候i适得府君书代付借款收代理费第三方可接受的加";
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
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentCoachInfoTitleCell className] title:[ZStudentCoachInfoTitleCell className] showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentCoachInfoTitleCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"联系相册"];
        [self.cellConfigArr addObject:titleCellConfig];
        
    }
    {
        ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
        NSArray *stemparr = @[@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd18jm09cuj30u017x7wh.jpg",
          @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gd18eptwlij318z0u0198.jpg",
          @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gd17vgbvgfj30u011eq9i.jpg",
        @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gd17qv01jnj30u01927az.jpg",
        @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd17mjs214j30rs15o4qp.jpg",
        @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd17hdmtn9j30u0142ang.jpg",
        @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gd17c994y0j30u011ignb.jpg",
        @"http://wx2.sinaimg.cn/mw600/007erPXFgy1gcei2kksvkj30rs15o1kx.jpg",
        @"http://wx3.sinaimg.cn/mw600/44f2ef1bgy1gd1746o74cj20ku0q1gqz.jpg"
        ];
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentImageCollectionCell className] title:[ZStudentImageCollectionCell className] showInfoMethod:@selector(setImages:) heightOfCell:[ZStudentImageCollectionCell z_getCellHeight:stemparr] cellType:ZCellTypeClass dataModel:stemparr];
        [self.cellConfigArr addObject:titleCellConfig];
    }
    
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"教师详情"];
}


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig
{
    
//    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZStudentImageCollectionCell"]){
        ZStudentImageCollectionCell *lcell = (ZStudentImageCollectionCell *)cell;
        lcell.menuBlock = ^(NSInteger index) {
            NSArray *stemparr = @[@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd18jm09cuj30u017x7wh.jpg",
              @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gd18eptwlij318z0u0198.jpg",
              @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gd17vgbvgfj30u011eq9i.jpg",
            @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gd17qv01jnj30u01927az.jpg",
            @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd17mjs214j30rs15o4qp.jpg",
            @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gd17hdmtn9j30u0142ang.jpg",
            @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gd17c994y0j30u011ignb.jpg",
            @"http://wx2.sinaimg.cn/mw600/007erPXFgy1gcei2kksvkj30rs15o1kx.jpg",
            @"http://wx3.sinaimg.cn/mw600/44f2ef1bgy1gd1746o74cj20ku0q1gqz.jpg"
            ];
            [[ZPhotoManager sharedManager] showBrowser:stemparr withIndex:2];
        };
    }
//    else if ([cellConfig.title isEqualToString:@"ZStudentOrganizationDetailIntroCell"]){
//        ZStudentOrganizationDetailIntroCell *lcell = (ZStudentOrganizationDetailIntroCell *)cell;
//        lcell.handleBlock = ^(NSInteger index) {
//            if (index == 1) {
//                ZStudentOrganizationMapAddressVC *avc = [[ZStudentOrganizationMapAddressVC alloc] init];
//                [weakSelf.navigationController pushViewController:avc animated:YES];
//            }else if (index == 2){
//                [ZOrganizationCouponListView setAlertWithTitle:@"优惠" ouponList:@[] handlerBlock:^(NSInteger index) {
//
//                }];
//            }
//        };
//    }
    
    
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
   
    
}

@end


