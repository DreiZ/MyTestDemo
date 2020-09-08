//
//  ZTeacherSignStudentListBottomView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTeacherSignStudentListBottomView : UIView
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@property (nonatomic,strong) NSString *type;
@property (nonatomic,assign) BOOL isLong;

@end

NS_ASSUME_NONNULL_END
