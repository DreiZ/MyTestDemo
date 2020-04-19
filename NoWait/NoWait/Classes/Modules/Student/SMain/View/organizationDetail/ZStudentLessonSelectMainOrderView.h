//
//  ZStudentLessonSelectMainOrderView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOrderModel.h"

@interface ZStudentLessonSelectMainOrderView : UIView

@property (nonatomic,strong) ZOriganizationLessonListModel *listModel;
@property (nonatomic,strong) ZOriganizationLessonExperienceTimeModel *timeModel;

@property (nonatomic,strong) void (^completeBlock)(ZOriganizationLessonListModel *,ZOriganizationLessonExperienceTimeModel*);
- (void)showSelectViewWithModel:(ZStoresDetailModel*)model;
@end


