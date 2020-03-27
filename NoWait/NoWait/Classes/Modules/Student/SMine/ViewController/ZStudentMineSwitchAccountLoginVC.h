//
//  ZStudentMineSwitchAccountLoginVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/28.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import "ZLoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZStudentMineSwitchAccountLoginVC : ZViewController
@property (nonatomic,assign) BOOL isCode;
@property (nonatomic,strong) ZUserRolesListModel *model;

@end

NS_ASSUME_NONNULL_END
