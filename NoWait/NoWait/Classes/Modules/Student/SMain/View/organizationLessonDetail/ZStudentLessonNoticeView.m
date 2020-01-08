//
//  ZStudentLessonNoticeView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonNoticeView.h"

@implementation ZStudentLessonNoticeView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor redColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
}

@end
