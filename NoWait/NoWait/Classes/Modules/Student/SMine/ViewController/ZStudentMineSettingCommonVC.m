//
//  ZStudentMineSettingCommonVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingCommonVC.h"
#import "ZStudentMineSettingBottomCell.h"
#import "ZStudentMineSettingSwitchCell.h"
#import <SDImageCache.h>


@interface ZStudentMineSettingCommonVC ()
@property (nonatomic,strong) NSString *isOpen;

@end

@implementation ZStudentMineSettingCommonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isOpen = @"2";
    [self setNavigation];
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
    [self getDeviceToken];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingSwitchCell className] title:[ZStudentMineSettingSwitchCell className] showInfoMethod:@selector(setIsOpen:) heightOfCell:CGFloatIn750(110) cellType:ZCellTypeClass dataModel:_isOpen];
    [self.cellConfigArr addObject:messageCellConfig];

    [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(10))];
    ZCellConfig *loginOutCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"cache" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(110) cellType:ZCellTypeClass dataModel:@"清空缓存"];
    [self.cellConfigArr addObject:loginOutCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"通用"];
}

#pragma mark tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"cache"]){
         [[SDImageCache sharedImageCache] clearMemory];
         [TLUIUtility showSuccessHint:@"操作成功"];
     }
}

- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZStudentMineSettingSwitchCell"]){
        ZStudentMineSettingSwitchCell *lcell = (ZStudentMineSettingSwitchCell *)cell;
        lcell.handleBlock = ^(NSString * isOpen) {
            weakSelf.isOpen = isOpen;
            [weakSelf setTokenIsOpen:isOpen];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        };
    }
}

- (void)setTokenIsOpen:(NSString *)isOpen {
    if ([isOpen intValue] == 1) {
        [[ZUserHelper sharedHelper] updateToken:YES];
    }else{
        [[ZUserHelper sharedHelper] updateToken:NO];
    }
}

- (void)getDeviceToken {
    __weak typeof(self) weakSelf = self;
    if ([ZUserHelper sharedHelper].push_token) {
        [[ZUserHelper sharedHelper] getDeviceTokenWithParams:@{@"device_token":SafeStr([ZUserHelper sharedHelper].push_token)} block:^(BOOL isSuccess, NSString *status) {
                if (isSuccess) {
                    if ([status intValue] == 1) {
                        weakSelf.isOpen = @"1";
                        [weakSelf initCellConfigArr];
                        [weakSelf.iTableView reloadData];
                        return;;
                    }
                }
            weakSelf.isOpen = @"2";
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }];
    }
}
@end
