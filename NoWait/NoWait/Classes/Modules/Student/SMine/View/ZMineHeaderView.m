//
//  ZMineHeaderView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineHeaderView.h"

@interface ZMineHeaderView ()

@end

@implementation ZMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor orangeColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
}
@end
