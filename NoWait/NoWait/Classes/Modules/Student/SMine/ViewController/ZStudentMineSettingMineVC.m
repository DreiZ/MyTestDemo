//
//  ZStudentMineSettingMineVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingMineVC.h"
#import "ZBaseUnitModel.h"

#import "ZOriganizationLessonViewModel.h"
#import "ZOriganizationViewModel.h"
#import "ZAlertDataSinglePickerView.h"
#import "ZStudentMineSettingUserHeadImageCell.h"

@interface ZStudentMineSettingMineVC ()
@property (nonatomic,strong) id avterImage;
@property (nonatomic,strong) ZUser *user;

@end
@implementation ZStudentMineSettingMineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    self.zChain_updateDataSource(^{
        weakSelf.user = [ZUserHelper sharedHelper].user;
        weakSelf.avterImage = weakSelf.user.avatar;
    }).zChain_setNavTitle(@"个人信息").zChain_setTableViewGary();
    
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        NSArray <NSArray *>*titleArr =
            @[@[@"头像", weakSelf.avterImage ? weakSelf.avterImage:@"", @""],
              @[@"昵称", @"rightBlackArrowN", SafeStr(weakSelf.user.nikeName)],
              @[@"性别", @"rightBlackArrowN", [SafeStr(weakSelf.user.sex) intValue] == 1?@"男":@"女"],
              @[@"出生日期", @"rightBlackArrowN", [weakSelf.user.birthday timeStringWithFormatter:@"yyyy-MM-dd"]]];
        
        for (int i = 0; i < titleArr.count; i++) {
           ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(SafeStr(titleArr[i][0]));
            model.zz_titleLeft(titleArr[i][0]).zz_titleRight(titleArr[i][2])
            .zz_fontLeft([UIFont fontContent])
            .zz_cellHeight(CGFloatIn750(100));
            
            if (i == 0) {
                model.zz_setData(titleArr[i][1]);
                self.addCell(model.cellTitle).zz_className([ZStudentMineSettingUserHeadImageCell className]).zz_data(model).zz_height([ZStudentMineSettingUserHeadImageCell z_getCellHeight:nil]).zz_method(@selector(setModel:)).zz_didSelect(^(UIScrollView *tableview, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
                    [[ZImagePickerManager sharedManager] setAvatarSelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                        if (list && list.count > 0) {
                           ZImagePickerModel *model = list[0];
                           [TLUIUtility showLoading:@"上传中"];
                           [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"5",@"imageKey":@{@"file":model.image}} completeBlock:^(BOOL isSuccess, id data) {
                               if (isSuccess) {
                                [weakSelf updateUserInfo:@{@"image":SafeStr(data)}];
                               }
                               [TLUIUtility hiddenLoading];
                           }];
                         }
                    }];
                });
            }else{
                model.zz_imageRight(titleArr[i][1]).zz_imageRightHeight(CGFloatIn750(14));
                
                self.addCell(model.cellTitle).zz_className([ZBaseLineCell className]).zz_height([ZStudentMineSettingUserHeadImageCell z_getCellHeight:nil]).zz_method(@selector(setModel:)).zz_data(model).zz_didSelect(^(UIScrollView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
                    if([cellConfig.title isEqualToString:@"昵称"]){
                        ZBaseTextVCModel *edit = [[ZBaseTextVCModel alloc] init];
                        edit.navTitle = @"设置昵称";
                        edit.formatter = ZFormatterTypeAnyByte;
                        edit.max = 30;
                        edit.hitStr = @"昵称只可有汉字字母数字下划线组成，30字符以内";
                        edit.showHitStr = @"你还没有输入任何昵称";
                        edit.placeholder = @"请输入昵称";
                        edit.text = weakSelf.user.nikeName;
                        
                        routePushVC(ZRoute_mine_textEditVC, edit, ^(NSString *text, NSError * _Nullable error) {
                            weakSelf.user.nikeName = text;
                            weakSelf.zChain_reload_ui();
                            [weakSelf updateUserInfo:@{@"nick_name":SafeStr(weakSelf.user.nikeName)}];
                        });
                    }else if([cellConfig.title isEqualToString:@"性别"]){
                        NSMutableArray *items = @[].mutableCopy;
                        NSArray *temp = @[@"男",@"女"];
                        for (int i = 0; i < temp.count; i++) {
                           ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
                           model.name = temp[i];
                           [items addObject:model];
                        }
                        
                        [ZAlertDataSinglePickerView setAlertName:@"性别选择" selectedIndex:[weakSelf.user.sex intValue] > 0 ? [weakSelf.user.sex intValue]-1:0 items:items handlerBlock:^(NSInteger index) {
                            weakSelf.user.sex = [NSString stringWithFormat:@"%ld",index + 1];
                            
                            weakSelf.zChain_reload_ui();
                            [weakSelf updateUserInfo:@{@"sex":SafeStr(weakSelf.user.sex)}];
                        }];
                    }else if([cellConfig.title isEqualToString:@"出生日期"]){
                        [ZDatePickerManager showDatePickerWithTitle:@"出生日期" type:PGDatePickerModeDate viewController:weakSelf handle:^(NSDateComponents * date) {
                             weakSelf.user.birthday = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateFromComponents:date] timeIntervalSince1970]];
                            
                            weakSelf.zChain_reload_ui();
                            [weakSelf updateUserInfo:@{@"birthday":SafeStr(weakSelf.user.birthday)}];
                        }];
                    }
                });
            }
        }
    }).zChain_block_setRefreshHeaderNet(^{
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
                weakSelf.zChain_reload_ui();
            }else{
                [TLUIUtility showErrorHint:data];
            }
        }];
    });
    
    self.zChain_reload_Net();
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
@end

#pragma mark - RouteHandler
@interface ZStudentMineSettingMineVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentMineSettingMineVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_settingMineUs;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentMineSettingMineVC *routevc = [[ZStudentMineSettingMineVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
