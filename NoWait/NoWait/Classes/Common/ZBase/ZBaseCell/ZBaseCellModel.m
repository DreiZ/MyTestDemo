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
        self.lineColor = [UIColor colorGrayLine];
        self.lineDarkColor = [UIColor colorGrayLineDark];

        self.titleWidth = 0;
        self.cellTitle = @"ZBaseCell";
        self.lineLeftMargin = 0;
        self.lineRightMargin = 0;
        self.cellHeight = CGFloatIn750(88);
        self.cellWidth = KScreenWidth;//cell的宽度
    }
    return self;
}
@end


@implementation ZBaseSingleCellModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.leftColor = [UIColor colorTextBlack];
        self.leftDarkColor = [UIColor colorTextBlackDark];
        self.leftFont = [UIFont fontContent];

        self.rightColor = [UIColor colorTextGray];
        self.rightDarkColor = [UIColor colorTextGrayDark];
        self.rightFont = [UIFont fontContent];
 
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
        self.lineSpace = CGFloatIn750(12);
        self.leftImageWidth = 0;
        self.rightImageWidth = 0;
        self.singleCellHeight = kCellNormalHeight;
        self.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

@end

@implementation ZBaseTextFieldCellModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.leftContentWidth = CGFloatIn750(220);
        self.textFieldHeight = CGFloatIn750(70);
        self.contentSpace = CGFloatIn750(20);
        self.contBackMargin = CGFloatIn750(30);
        self.formatterType = ZFormatterTypeAny;
        self.textAlignment = NSTextAlignmentRight;
  
        self.leftColor = [UIColor colorTextBlack];
        self.leftDarkColor = [UIColor colorTextBlackDark];
        self.leftFont = [UIFont boldFontTitle];
        
        self.rightColor = [UIColor colorTextBlack];
        self.rightDarkColor = [UIColor colorTextBlackDark];
        self.rightFont = [UIFont fontContent];
        
        self.subTitleColor = [UIColor colorTextGray1];
        self.subTitleDarkColor = [UIColor colorTextGray1Dark];
        self.subTitleFont = [UIFont fontSmall];
        
        self.placeholder = @"";
        self.leftTitle = @"";
        self.subTitle = @"";
        self.rightTitle = @"";
        
        
        self.max = 6;
        self.cellHeight = kCellNormalHeight;
        self.rightImageWidth = CGFloatIn750(10);
        self.isHiddenInputLine = YES;
        self.isTextEnabled = YES;
        
        self.textColor = [UIColor colorTextBlack];
        self.textDarkColor = [UIColor colorTextBlackDark];
        self.textFont = [UIFont fontContent];

    }
    return self;
}
@end
