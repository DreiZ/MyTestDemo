//
//  ZStudentLessonEvaView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonEvaView.h"

@implementation ZStudentLessonEvaView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor purpleColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
}

@end
