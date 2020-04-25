//
//  ZLessonWeekHandlerView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLessonWeekHandlerView : UIView
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@property (nonatomic,strong) void (^moreBlock)(NSInteger);
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) BOOL isOrganization;
@end

NS_ASSUME_NONNULL_END
