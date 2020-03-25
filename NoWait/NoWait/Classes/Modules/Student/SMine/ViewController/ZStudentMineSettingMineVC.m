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
#import "ZOriganizationLessonViewModel.h"


@interface ZStudentMineSettingMineVC ()
@property (nonatomic,strong) id avterImage;

@end
@implementation ZStudentMineSettingMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.avterImage = [ZUserHelper sharedHelper].user.avatar;
    [self setNavigation];
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    
    NSArray <NSArray *>*titleArr = @[@[@"头像", self.avterImage ? self.avterImage:@"", @""],
                                     @[@"昵称", @"rightBlackArrowN", SafeStr([ZUserHelper sharedHelper].user.nikeName)],
                                     @[@"性别", @"rightBlackArrowN", [SafeStr([ZUserHelper sharedHelper].user.sex) intValue] == 1?@"男":@"女"],
                                     @[@"出生日期", @"rightBlackArrowN", [ZUserHelper sharedHelper].user.birthday]];
    
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
                    [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"3",@"imageKey":@{@"file":list[0].image}} completeBlock:^(BOOL isSuccess, id data) {
                        
                    }];
                    
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
         [ZDatePickerManager showDatePickerWithTitle:@"出生日期" type:PGDatePickerModeDate viewController:self handle:^(NSDateComponents * date) {
             
         }];
     }
}

@end
