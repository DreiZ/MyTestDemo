//
//  ZAlertClassifyPickerView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentMainModel.h"

@interface ZAlertClassifyPickerView : UIView
@property (nonatomic,strong) NSArray <ZMainClassifyOneModel *>*classifys;

@property (nonatomic,strong) void (^sureBlock)(NSMutableArray *);


+ (void)setClassifyAlertWithClassifyArr:(NSArray *)classify handlerBlock:(void(^)( NSMutableArray *))handleBlock;
@end


