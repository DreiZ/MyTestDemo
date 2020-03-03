//
//  ZStudentMineSettingMineVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingMineVC.h"

#import "ZStudentMineSettingUserHeadImageCell.h"

#import "ZStudentMineSignDetailVC.h"
#import "ZStudentMineSettingMineEditVC.h"
#import "ZStudentMineSettingSexVC.h"


@interface ZStudentMineSettingMineVC ()
@property (nonatomic,strong) UIImage *avterImage;

@end
@implementation ZStudentMineSettingMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTiableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSArray <NSArray *>*titleArr = @[@[@"头像", self.avterImage ? self.avterImage:@"", @""], @[@"昵称", @"rightBlackArrowN", @"闯红灯的蜗牛"],@[@"性别", @"rightBlackArrowN", @"男"],@[@"出生日期", @"rightBlackArrowN", @"1990-2-21"]];
    
    for (int i = 0; i < titleArr.count; i++) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = titleArr[i][0];
        
        model.rightTitle = titleArr[i][2];
        model.leftFont = [UIFont fontContent];
        model.cellTitle = titleArr[i][0];
        model.cellHeight = CGFloatIn750(100);
        if (i == 0) {
            model.rightImageH = titleArr[i][1];
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingUserHeadImageCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineSettingUserHeadImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
            
        }else{
            model.rightImage = titleArr[i][1];
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"设置"];
}


#pragma mark tableView ------delegate-----
-(void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"头像"]){
          __weak typeof(self) weakSelf = self;
            [ZPhotoManager sharedManager].maxImageSelected = 1;
            [[ZPhotoManager sharedManager] showCropOriginalSelectMenuWithCropSize:CGSizeMake(KScreenWidth, KScreenWidth) complete:^(NSArray<LLImagePickerModel *> *list) {
                if (list && list.count > 0) {
                    weakSelf.avterImage = list[0].image;
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                    
//                    NSString *imageFileName = [NSString stringWithFormat:@"%@.jpg",AliYunUserFilePath];
//                    [[ZFileUploadManger sharedManager] uploadImage:weakSelf.avterImage fileName:imageFileName complete:^(NSString *url, NSString *content_md5) {
//
//                    }];
                }
            }];
     }else if([cellConfig.title isEqualToString:@"昵称"]){
         ZStudentMineSettingMineEditVC *edit = [[ZStudentMineSettingMineEditVC alloc] init];
         [self.navigationController pushViewControllerAndSuicide:edit animated:YES];
     }else if([cellConfig.title isEqualToString:@"性别"]){
         ZStudentMineSettingSexVC *edit = [[ZStudentMineSettingSexVC alloc] init];
         [self.navigationController pushViewControllerAndSuicide:edit animated:YES];
     } else if([cellConfig.title isEqualToString:@"出生日期"]){
         [[ZDatePickerManager sharedManager] showDatePickerWithTitle:@"出生日期" type:PGDatePickerModeDate viewController:self handle:^(NSDateComponents * date) {
             
         }];
     }
}

@end
