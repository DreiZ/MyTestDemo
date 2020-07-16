//
//  ZCircleHeaderView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCircleHeaderView : UIView
@property (nonatomic,strong) NSString *hint;

@property (nonatomic,strong) void (^handleBlock)(NSInteger);

- (void)updateData;
@end

