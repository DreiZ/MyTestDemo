//
//  ZBaseModel.m
//  BaseProject
//
//  Created by zzz on 2018/5/28.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseModel.h"

@implementation ZBaseModel
- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self modelCopy];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init]; return [self modelInitWithCoder:aDecoder];
}
@end
