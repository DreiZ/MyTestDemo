//
//  ZLessonWeekHandlerItemBtnView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZLessonWeekHandlerItemBtnView : UIView
@property (nonatomic,strong) void (^handerBlock)(NSDate *);
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) NSDate *date;
@end

