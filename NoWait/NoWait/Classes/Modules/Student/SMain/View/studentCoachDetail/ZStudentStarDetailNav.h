//
//  ZStudentStarDetailNav.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZStudentStarDetailNav : UIView
@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) void (^backBlock)(NSInteger);
@end

