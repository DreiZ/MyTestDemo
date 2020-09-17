//
//  ZStudentMineSwitchAccountVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/12.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSwitchAccountVC.h"
#import "ZLoginCodeController.h"
#import "ZLoginTypeController.h"

#import "ZUserHelper.h"
#import "ZLaunchManager.h"

@interface ZStudentMineSwitchAccountVC ()

@end

@implementation ZStudentMineSwitchAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHidenNaviBar = NO;
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"切换账号").zChain_setTableViewGary();
    
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_titleLeft(@"切换账号")
            .zz_fontLeft([UIFont boldFontMax2Title])
            .zz_cellHeight(CGFloatIn750(180));
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr addObject:menuCellConfig];
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
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"user")
                .zz_cellHeight(CGFloatIn750(116))
                .zz_titleLeft([NSString stringWithFormat:@"%@(%@)",user.phone,typestr])
                .zz_imageLeft(ValidStr(user.avatar)? imageFullUrl(user.avatar):@"default_head")
                .zz_imageRightHeight(CGFloatIn750(30))
                .zz_imageLeftHeight(CGFloatIn750(80))
                .zz_imageLeftRadius(YES)
                .zz_setData(user);
                
                if (i == userList.count-1) {
                    model.zz_lineHidden(YES);
                }else{
                    model.zz_lineHidden(NO);
                }
                if ([user.userCodeID isEqualToString:[ZUserHelper sharedHelper].uuid]) {
                    model.zz_imageRight(@"selectedCycle");
                }else{
                    model.zz_imageRight(@"unSelectedCycle");
                }
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [weakSelf.cellConfigArr addObject:menuCellConfig];
            }
        }
        
        if (weakSelf.cellConfigArr.count < 12) {
            [weakSelf.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(60))];
            
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"switch")
            .zz_titleLeft(@"换个新账号登录")
            .zz_imageRight(isDarkModel() ? @"rightBlackArrowDarkN" : @"rightBlackArrowN")
            .zz_imageRightHeight(CGFloatIn750(14));
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            
            [weakSelf.cellConfigArr addObject:menuCellConfig];
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"switch"]){
            ZLoginTypeController *loginvc = [[ZLoginTypeController alloc] init];
            loginvc.loginSuccess = ^{
                if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
                
                NSArray *viewControllers = weakSelf.navigationController.viewControllers;
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
            [weakSelf.navigationController pushViewController:loginvc animated:YES];
        }else if ([cellConfig.title isEqualToString:@"user"]){
            ZBaseSingleCellModel *cellModel = (ZBaseSingleCellModel *)cellConfig.dataModel;
            ZUser *user = cellModel.data;
            [[ZUserHelper sharedHelper] switchUser:user];
            
            if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
        }
    });
    self.zChain_reload_ui();
}

#pragma mark - 删除列表
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = self.cellConfigArr[indexPath.row];
    if ([cellConfig.title isEqualToString:@"user"]) {
        return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = self.cellConfigArr[indexPath.row];
    if ([cellConfig.title isEqualToString:@"user"]) {
        ZBaseSingleCellModel *cellModel = (ZBaseSingleCellModel *)cellConfig.dataModel;
        ZUser *user = cellModel.data;
        
        if (![user.userCodeID isEqualToString:[ZUserHelper sharedHelper].user.userCodeID]) {
            return UITableViewCellEditingStyleDelete;
        }
        return UITableViewCellEditingStyleNone;
    }else{
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = self.cellConfigArr[indexPath.row];
    if ([cellConfig.title isEqualToString:@"user"]) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            ZBaseSingleCellModel *cellModel = (ZBaseSingleCellModel *)cellConfig.dataModel;
            ZUser *user = cellModel.data;
            [[ZUserHelper sharedHelper] deleteUserStore:user.userCodeID];
            self.zChain_reload_ui();
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = self.cellConfigArr[indexPath.row];
    if ([cellConfig.title isEqualToString:@"user"]) {
        return @"删除";
    }else{
        return nil;
    }
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    self.zChain_reload_ui();
}
@end

#pragma mark - RouteHandler
@interface ZStudentMineSwitchAccountVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentMineSwitchAccountVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_switchAccount;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentMineSwitchAccountVC *routevc = [[ZStudentMineSwitchAccountVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
