//
//  ZCircleMineCollectionViewFlowLayout.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineCollectionViewFlowLayout.h"

@implementation ZCircleMineCollectionViewFlowLayout

- (instancetype)init
{
    if (!(self = [super init])) return nil;
    self.sectionHeadersPinToVisibleBounds = YES;//header 悬浮
    
    return self;
}

@end
