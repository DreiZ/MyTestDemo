//
//  ZStudentLessonDetailBannerCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonDetailBannerCell.h"

@implementation ZStudentLessonDetailBannerCell

//- (void)setupView {
//    [super setupView];
//    
//    [self.iCycleScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(CGFloatIn750(10));
//        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-10));
//        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
//        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-20));
//    }];
//}


+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(350);
}
@end
