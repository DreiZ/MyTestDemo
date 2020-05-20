//
//  ZButton.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZButton.h"

@implementation ZButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.JQ_acceptEventInterval = 1;
    }
    return self;
}

@end
