//
//  ZMineHeaderView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZMineHeaderView : UIView
@property (nonatomic,strong) void (^topHandleBlock)(NSInteger);
- (void)updateSubViewFrame;
@end

