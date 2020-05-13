//
//  ZCellModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/30.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCellModel.h"

@implementation ZCellModel

@end


@implementation ZLineCellModel
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

ZCHAIN_CLASS_CREATE(ZLineCellModel, NSString *, zz_lineCellModel_create, cellTitle)


ZCHAIN_LINECELLMODEL_IMPLEMENTATION(setData, id, data)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(marginLineLeft, CGFloat, lineLeftMargin)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(marginLineRight, CGFloat, lineRightMargin)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(width, CGFloat, cellWidth)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(height, CGFloat, cellHeight)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(selected, BOOL, isSelected)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(lineHidden, BOOL, isHiddenLine)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorLine, UIColor *, lineColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorDarkLine, UIColor *, lineDarkColor)


ZCHAIN_LINECELLMODEL_IMPLEMENTATION(marginLeft, CGFloat, leftMargin)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(marginRight, CGFloat, rightMargin)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(imageLeftHeight, CGFloat, leftImageH)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(imageLeft, id, leftImage)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(imageLeftRadius, BOOL, isLeftImageRadius)


ZCHAIN_LINECELLMODEL_IMPLEMENTATION(titleLeft, NSString *, leftTitle)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorLeft, UIColor *, leftColor)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorDarkLeft, UIColor *, leftDarkColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(fontLeft, UIFont *, leftFont)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(alignmentLeft, NSTextAlignment, leftTextAlignment)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(imageRightHeight, CGFloat, rightImageH)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(imageRight, id, rightImage)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(subTitleLeft, NSString *, leftSubTitle)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorSubLeft, UIColor *, leftSubColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorDarkSubLeft, UIColor *, leftSubDarkColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(fontSubLeft, UIFont *,leftSubFont)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorRight, UIColor *, rightColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorDarkRight, UIColor *, rightDarkColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(fontRight, UIFont *, rightFont)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(titleRight, NSString *, rightTitle)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(alignmentRight, NSTextAlignment,rightTextAlignment)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(subTitleRight, NSString *, rightSubTitle)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorSubRight, UIColor *, rightSubColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorDarkSubRight, UIColor *, rightSubDarkColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(fontSubRight, UIFont *, rightSubFont)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(contentSpaceLeft, CGFloat, leftContentSpace)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(contentSpaceRight, CGFloat, rightContentSpace)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(spaceLine, CGFloat, lineSpace)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(contentLeftWidth, CGFloat, leftContentWidth)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(leftMultiLine, BOOL, isLeftMultiLine)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(rightMultiLine, BOOL, isRightMultiLine)
@end

@implementation ZTextFieldModel
- (instancetype)init {
    self = [super init];
    if (self) {

        self.textColor = [UIColor colorTextBlack];
        self.textDarkColor = [UIColor colorTextBlackDark];
        self.textFont = [UIFont fontContent];;

        self.formatterType = ZFormatterTypeAny;
        self.textAlignment = NSTextAlignmentRight;

        self.placeholderText = @"请输入";
        self.maxLength = 50;
        self.textContent = @"";
        self.textFieldHeight = self.cellHeight;

        self.isHiddenInputLine = YES;
        self.isTextEnabled = YES;
    }
    return self;
}

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorText, UIColor *, textColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(colorDarkText, UIColor *, textDarkColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(fontText, UIFont *, textFont)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(alignmentText, NSTextAlignment, textAlignment)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(formatter, ZFormatterType, formatterType)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(placeholder, NSString *, placeholderText)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(max, NSInteger, maxLength)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(content, NSString *, textContent)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(heightTextField, CGFloat, textFieldHeight)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(lineInputHidden, BOOL, isHiddenInputLine)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(textEnabled, BOOL, isTextEnabled)

@end
