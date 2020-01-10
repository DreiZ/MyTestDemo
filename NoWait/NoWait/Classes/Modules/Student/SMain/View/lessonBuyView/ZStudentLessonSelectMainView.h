//
//  ZStudentLessonSelectMainView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentDetailModel.h"

@interface ZStudentLessonSelectMainView : UIView
@property (nonatomic,assign) lessonBuyType buyType;

- (void)showSelectViewWithType:(lessonBuyType)type;
@end

