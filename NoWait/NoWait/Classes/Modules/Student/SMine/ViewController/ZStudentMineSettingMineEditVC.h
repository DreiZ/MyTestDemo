//
//  ZStudentMineSettingMineEditVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import "ZBaseUnitModel.h"

@interface ZStudentMineSettingMineEditVC : ZViewController
@property (nonatomic,strong) ZBaseTextVCModel *model;
@property (nonatomic,strong) void (^handleBlock)(NSString *text);
@end

