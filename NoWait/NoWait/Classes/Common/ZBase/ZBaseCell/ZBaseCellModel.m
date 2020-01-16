//
//  ZBaseCellModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCellModel.h"

@implementation ZBaseCellModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.leftMargin = CGFloatIn750(30);
        self.rightMargin = CGFloatIn750(30);

        self.isHiddenLine = NO;
        self.lineColor = KBackColor;

        self.cellTitle = @"ZBaseCell";
        self.cellHeight = CGFloatIn750(100);
    }
    return self;
}
@end


@implementation ZBaseSingleCellModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.leftColor = KFont3Color;
        self.leftFont = [UIFont systemFontOfSize:CGFloatIn750(30)];

        self.rightColor = KFont6Color;
        self.rightFont = [UIFont systemFontOfSize:CGFloatIn750(30)];
 
        self.leftContentSpace = CGFloatIn750(20);
        self.rightContentSpace = CGFloatIn750(10);
        
    }
    return self;
}

@end

@implementation ZBaseMultiseriateCellModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.lineSpace = CGFloatIn750(14);
        self.leftImageWidth = 0;
        self.rightImageWidth = 0;
        self.singleCellHeight = kCellNormalHeight;
    }
    return self;
}

@end
