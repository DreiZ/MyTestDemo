//
//  ZStudentLessonSelectOrderLessonView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOrderModel.h"

@interface ZStudentLessonSelectOrderLessonView : UIView
@property (nonatomic,strong) ZStoresDetailModel *detailModel;
@property (nonatomic,strong) void (^closeBlock)(void);
@property (nonatomic,strong) void (^bottomBlock)(void);
@end


