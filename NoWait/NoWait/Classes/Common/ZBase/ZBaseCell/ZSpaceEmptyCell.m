//
//  ZSpaceEmptyCell.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/11/22.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZSpaceEmptyCell.h"

@implementation ZSpaceEmptyCell

- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    self.contentView.backgroundColor = backColor;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return 10;
}
@end
