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
#import "ZOriganizationViewModel.h"
#import "ZAlertDataSinglePickerView.h"


@interface ZStudentMineSettingMineVC ()
@property (nonatomic,strong) id avterImage;
@property (nonatomic,strong) ZUser *user;

@end
@implementation ZStudentMineSettingMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _user = [ZUserHelper sharedHelper].user;
    self.avterImage = _user.avatar;
    [self setNavigation];
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
    
    [self refreshData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    
    NSArray <NSArray *>*titleArr = @[@[@"头像", self.avterImage ? self.avterImage:@"", @""],
                                     @[@"昵称", @"rightBlackArrowN", SafeStr(self.user.nikeName)],
                                     @[@"性别", @"rightBlackArrowN", [SafeStr(self.user.sex) intValue] == 1?@"男":@"女"],
                                     @[@"出生日期", @"rightBlackArrowN", [self.user.birthday timeStringWithFormatter:@"yyyy-MM-dd"]]];
    
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
    [self.navigationItem setTitle:@"个人信息"];
}


#pragma mark tableView ------delegate-----
-(void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
     if ([cellConfig.title isEqualToString:@"头像"]){
          __weak typeof(self) weakSelf = self;
            [ZPhotoManager sharedManager].maxImageSelected = 1;
         [[ZPhotoManager sharedManager] showCropOriginalSelectMenuWithCropSize:CGSizeMake(KScreenWidth, KScreenWidth) complete:^(NSArray<LLImagePickerModel *> *list) {
                if (list && list.count > 0) {
                    weakSelf.avterImage = list[0].image;
                    [weakSelf initCellConfigArr];
                    [weakSelf.iTableView reloadData];
                    [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"5",@"imageKey":@{@"file":list[0].image}} completeBlock:^(BOOL isSuccess, id data) {
                        if (isSuccess) {
                            [weakSelf updateUserInfo:@{@"image":SafeStr(data)}];
                        }
                    }];
                    
//                    NSString *imageFileName = [NSString stringWithFormat:@"%@.jpg",AliYunUserFilePath];
//                    [[ZFileUploadManger sharedManager] uploadImage:weakSelf.avterImage fileName:imageFileName complete:^(NSString *url, NSString *content_md5) {
//
//                    }];
                }
            }];
     }else if([cellConfig.title isEqualToString:@"昵称"]){
         ZStudentMineSettingMineEditVC *edit = [[ZStudentMineSettingMineEditVC alloc] init];
         edit.text = weakSelf.user.nikeName;
         edit.handleBlock = ^(NSString *text) {
             weakSelf.user.nikeName = text;
             [weakSelf initCellConfigArr];
             [weakSelf.iTableView reloadData];
             [weakSelf updateUserInfo:@{@"nick_name":SafeStr(weakSelf.user.nikeName)}];
         };
         [self.navigationController pushViewController:edit animated:YES];
     }else if([cellConfig.title isEqualToString:@"性别"]){
//         ZStudentMineSettingSexVC *edit = [[ZStudentMineSettingSexVC alloc] init];
//         [self.navigationController pushViewControllerAndSuicide:edit animated:YES];
         NSMutableArray *items = @[].mutableCopy;
         NSArray *temp = @[@"男",@"女"];
         for (int i = 0; i < temp.count; i++) {
            ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
            model.name = temp[i];
            [items addObject:model];
         }
         [ZAlertDataSinglePickerView setAlertName:@"性别选择" items:items handlerBlock:^(NSInteger index) {
            weakSelf.user.sex = [NSString stringWithFormat:@"%ld",index + 1];
             [weakSelf initCellConfigArr];
             [weakSelf.iTableView reloadData];
             [weakSelf updateUserInfo:@{@"sex":SafeStr(weakSelf.user.sex)}];
         }];
     } else if([cellConfig.title isEqualToString:@"出生日期"]){
         [ZDatePickerManager showDatePickerWithTitle:@"出生日期" type:PGDatePickerModeDate viewController:self handle:^(NSDateComponents * date) {
              weakSelf.user.birthday = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:date] timeIntervalSince1970]];
             [weakSelf initCellConfigArr];
             [weakSelf.iTableView reloadData];
             [weakSelf updateUserInfo:@{@"birthday":SafeStr(weakSelf.user.birthday)}];
         }];
     }
}


- (void)updateUserInfo:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@"更新信息中"];
    [ZOriganizationViewModel updateUserInfo:param completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [weakSelf refreshData];
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}

- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationViewModel getUserInfo:@{} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess) {
            weakSelf.user = data;
            weakSelf.avterImage = weakSelf.user.avatar;
            [ZUserHelper sharedHelper].user.birthday = weakSelf.user.birthday;
            [ZUserHelper sharedHelper].user.avatar = weakSelf.user.avatar;
            [ZUserHelper sharedHelper].user.nikeName = weakSelf.user.nikeName;
            [ZUserHelper sharedHelper].user.sex = weakSelf.user.sex;
            [ZUserHelper sharedHelper].user.type = weakSelf.user.type;
            [[ZUserHelper sharedHelper] setUser:[ZUserHelper sharedHelper].user];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}
@end
