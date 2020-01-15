//
//  ZStudentMineOrderDetailHandleBottomView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentMineModel.h"

@interface ZStudentMineOrderDetailHandleBottomView : UIView
@property (nonatomic,strong) void (^handleBlock)(ZLessonOrderHandleType);
@end

