//
//  ZDatePickerView.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/11/6.
//  Copyright © 2018 承希-开发. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZDatePickerView : UIView

@property (nonatomic,strong) void (^dateSelectBlock)(NSDate *);

+ (void)showTimePickerInView:(UIView *)view dateSelect:(void(^)(NSDate *))selectBlock;

+ (void)showTimePickerInView:(UIView *)view date:(NSDate *)date dateSelect:(void(^)(NSDate *))selectBlock;
@end


