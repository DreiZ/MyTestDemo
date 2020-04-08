//
//  ZStudentMainTopSearchView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZStudentMainTopSearchView : UIView
@property (nonatomic,strong) void (^searchBlock)(NSInteger);
- (void)updateWithOffset:(CGFloat)offsetY;

@end

