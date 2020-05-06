//
//  ZCellModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/30.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCellModel.h"

@implementation ZCellModel
- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.isHiddenLine = NO;
        self.lineColor = [UIColor colorGrayLine];
        self.lineDarkColor = [UIColor colorGrayLineDark];
        self.lineLeftMargin = kLineLeftMargin;
        self.lineRightMargin = kLineRightMargin;
        
        self.cellTitle = @"ZBaseCell";
        self.cellHeight = kCellNormalHeight ;
        self.cellWidth = kCellNormalWidth;
    }
    return self;
}

@end


@implementation ZLineCellModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.leftMargin = kLeftMargin;
        self.rightMargin = kRightMargin;

        self.leftImageH = 0;
        self.leftColor = [UIColor colorTextBlack];
        self.leftDarkColor = [UIColor colorTextBlackDark];
        self.leftFont = [UIFont fontContent];
        self.leftTextAlignment = NSTextAlignmentLeft;

        self.leftSubColor = [UIColor colorTextGray];
        self.leftSubDarkColor = [UIColor colorTextGrayDark];
        self.leftSubFont = [UIFont fontSmall];

        self.rightImageH = 0;

        self.rightColor = [UIColor colorTextBlack];
        self.rightDarkColor = [UIColor colorTextBlackDark];
        self.rightFont = [UIFont fontContent];
        self.rightTextAlignment = NSTextAlignmentRight;


        self.rightSubColor = [UIColor colorTextGray];
        self.rightSubDarkColor = [UIColor colorTextGrayDark];
        self.rightSubFont = [UIFont fontSmall];

        self.leftContentSpace = kCellContentSpace;
        self.rightContentSpace = kCellContentSpace;
        
        self.lineSpace = kLineSpace;
        self.leftContentWidth = 0;
    }
    return self;
}
@end
