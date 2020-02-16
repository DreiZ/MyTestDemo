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
        self.lineColor = [UIColor colorGrayBG];

        self.titleWidth = 0;
        self.cellTitle = @"ZBaseCell";
        self.cellHeight = CGFloatIn750(100);
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
        self.leftFont = [UIFont systemFontOfSize:CGFloatIn750(30)];

        self.rightColor = [UIColor colorTextGray];
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

@implementation ZBaseTextFieldCellModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.leftContentWidth = CGFloatIn750(220);
        self.textFieldHeight = CGFloatIn750(60);
        self.contentSpace = CGFloatIn750(30);
        self.formatterType = ZFormatterTypeAny;
        self.textAlignment = NSTextAlignmentRight;
  
        self.leftColor = [UIColor colorTextBlack];
        self.leftFont = [UIFont systemFontOfSize:CGFloatIn750(30)];
        self.subTitleColor = [UIColor colorTextGray1];
        self.subTitleFont = [UIFont systemFontOfSize:CGFloatIn750(26)];
        
        self.placeholder = @"请输入";
        self.leftTitle = @"";
        self.subTitle = @"";
        self.max = 6;
        self.cellHeight = kCellNormalHeight;
        
        self.isHiddenInputLine = YES;
        
        self.textColor = [UIColor colorTextBlack];
        self.textFont = [UIFont systemFontOfSize:CGFloatIn750(30)];

    }
    return self;
}
@end
