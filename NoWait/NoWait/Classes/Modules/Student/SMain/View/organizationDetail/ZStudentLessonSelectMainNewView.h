//
//  ZStudentLessonSelectMainNewView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentDetailModel.h"
#import "ZOrderModel.h"

@interface ZStudentLessonSelectMainNewView : UIView
@property (nonatomic,assign) ZLessonBuyType buyType;
@property (nonatomic,strong) void (^completeBlock)(ZOrderAddModel *);
- (void)showSelectViewWithModel:(ZOriganizationLessonDetailModel *)model;

@end
