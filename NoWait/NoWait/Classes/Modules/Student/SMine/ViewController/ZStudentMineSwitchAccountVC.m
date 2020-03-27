//
//  ZStudentMineSwitchAccountVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/12.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSwitchAccountVC.h"
#import "ZLoginCodeController.h"

#import "ZUserHelper.h"
#import "ZLaunchManager.h"

@interface ZStudentMineSwitchAccountVC ()

@end

@implementation ZStudentMineSwitchAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.cellHeight = CGFloatIn750(180);
        model.leftTitle = @"切换账号";
        model.cellTitle = @"title";
        model.leftFont = [UIFont boldFontMax2Title];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
    
    NSArray *userList = [[ZUserHelper sharedHelper] userList];
    
    for (int i = 0; i < userList.count; i++) {
        if ([userList[i] isKindOfClass:[ZUser class]]) {
            ZUser *user = userList[i];
            NSString *typestr = @"学员端";
            //    1：学员 2：教师 6：校区 8：机构
            if ([user.type intValue] == 1) {
                typestr = @"学员端";
            }else if ([user.type intValue] == 2) {
                typestr = @"教师端";
            }else if ([user.type intValue] == 6) {
                typestr = @"校区端";
            }else if ([user.type intValue] == 8) {
                typestr = @"机构端";
            }
            
            
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.cellHeight = CGFloatIn750(116);
            model.leftTitle = [NSString stringWithFormat:@"%@(%@)",user.phone,typestr];
            model.cellTitle = @"user";
            model.leftImage = imageFullUrl(user.avatar);
            if (i == userList.count-1) {
                model.isHiddenLine = YES;
            }
            if ([user.userCodeID isEqualToString:[ZUserHelper sharedHelper].uuid]) {
                model.rightImage = @"selectedCycle";
            }else{
                model.rightImage = @"unSelectedCycle";
            }
            model.rightImageH = @80;
            model.data = user;
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
    
    if (self.cellConfigArr.count < 12) {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(60) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
        [self.cellConfigArr addObject:topCellConfig];
        
        
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"换个新账号登录";
        model.rightImage = isDarkModel() ? @"rightBlackArrowDarkN" : @"rightBlackArrowN";
        model.cellTitle = @"switch";
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    } 
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"切换账号"];
}

#pragma mark tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
     if ([cellConfig.title isEqualToString:@"switch"]){
         ZLoginCodeController *loginvc = [[ZLoginCodeController alloc] init];
         loginvc.loginSuccess = ^{
             [weakSelf initCellConfigArr];
             [weakSelf.iTableView reloadData];
             
             NSArray *viewControllers = self.navigationController.viewControllers;
             NSArray *reversedArray = [[viewControllers reverseObjectEnumerator] allObjects];
             
             ZViewController *target;
             for (ZViewController *controller in reversedArray) {
                 if ([controller isKindOfClass:[NSClassFromString(@"ZStudentMineSwitchAccountVC") class]]) {
                     target = controller;
                     break;
                 }
             }
             
             if (target) {
                 [weakSelf.navigationController popToViewController:target animated:YES];
                 return;
             }
             [weakSelf.navigationController popToRootViewControllerAnimated:YES];
         };
         loginvc.isSwitch = YES;
         [self.navigationController pushViewController:loginvc animated:YES];
     }else if ([cellConfig.title isEqualToString:@"user"]){
         ZBaseSingleCellModel *cellModel = (ZBaseSingleCellModel *)cellConfig.dataModel;
         ZUser *user = cellModel.data;
         [[ZUserHelper sharedHelper] switchUser:user];
         [self initCellConfigArr];
         [self.iTableView reloadData];
     }
}



#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
    [self initCellConfigArr];
    [self.iTableView reloadData];
}
@end
