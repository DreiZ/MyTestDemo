//
//  ZStudentMineSettingMineEditVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"


@interface ZStudentMineSettingMineEditVC : ZViewController
@property (nonatomic,strong) NSString *text;
@property (nonatomic,assign) NSInteger max;
@property (nonatomic,assign) ZFormatterType formatter;
@property (nonatomic,copy) NSString *navTitle;
@property (nonatomic,copy) NSString *hitStr;
@property (nonatomic,copy) NSString *showHitStr;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,strong) void (^handleBlock)(NSString *text);
@end

