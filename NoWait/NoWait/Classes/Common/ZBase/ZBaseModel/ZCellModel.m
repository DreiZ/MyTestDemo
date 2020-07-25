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
        self.backDarkColor = [UIColor colorBlackBGDark];
        self.backColor = [UIColor colorWhite];
        
        self.isHiddenLine = YES;
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
        self.leftImageW = 0;
        
        self.leftColor = [UIColor colorTextBlack];
        self.leftDarkColor = [UIColor colorTextBlackDark];
        self.leftFont = [UIFont fontContent];
        self.leftTextAlignment = NSTextAlignmentLeft;

        self.leftSubColor = [UIColor colorTextGray];
        self.leftSubDarkColor = [UIColor colorTextGrayDark];
        self.leftSubFont = [UIFont fontSmall];

        self.rightImageH = 0;
        self.rightImageW = 0;

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

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorBack, UIColor *, backColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorDarkBack, UIColor *, backDarkColor)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_setData, id, data)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_marginLineLeft, CGFloat, lineLeftMargin)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_marginLineRight, CGFloat, lineRightMargin)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_cellWidth, CGFloat, cellWidth)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_cellHeight, CGFloat, cellHeight)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_selected, BOOL, isSelected)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_lineHidden, BOOL, isHiddenLine)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorLine, UIColor *, lineColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorDarkLine, UIColor *, lineDarkColor)


ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_marginLeft, CGFloat, leftMargin)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_marginRight, CGFloat, rightMargin)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_imageLeftHeight, CGFloat, leftImageH)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_imageLeftWidth, CGFloat, leftImageW)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_imageLeft, id, leftImage)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_ImageLeftPlaceholder, NSString *, leftPlaceholderImage)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_imageLeftRadius, BOOL, isLeftImageRadius)


ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_titleLeft, NSString *, leftTitle)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorLeft, UIColor *, leftColor)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorDarkLeft, UIColor *, leftDarkColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_fontLeft, UIFont *, leftFont)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_alignmentLeft, NSTextAlignment, leftTextAlignment)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_imageRightHeight, CGFloat, rightImageH)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_imageRightWidth, CGFloat, rightImageW)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_imageRight, id, rightImage)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_ImageRightPlaceholder, NSString *, rightPlaceholderImage)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_subTitleLeft, NSString *, leftSubTitle)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorSubLeft, UIColor *, leftSubColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorDarkSubLeft, UIColor *, leftSubDarkColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_fontSubLeft, UIFont *,leftSubFont)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorRight, UIColor *, rightColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorDarkRight, UIColor *, rightDarkColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_fontRight, UIFont *, rightFont)

ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_titleRight, NSString *, rightTitle)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_alignmentRight, NSTextAlignment,rightTextAlignment)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_subTitleRight, NSString *, rightSubTitle)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorSubRight, UIColor *, rightSubColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_colorDarkSubRight, UIColor *, rightSubDarkColor)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_fontSubRight, UIFont *, rightSubFont)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_contentSpaceLeft, CGFloat, leftContentSpace)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_contentSpaceRight, CGFloat, rightContentSpace)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_spaceLine, CGFloat, lineSpace)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_contentLeftWidth, CGFloat, leftContentWidth)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_leftMultiLine, BOOL, isLeftMultiLine)
ZCHAIN_LINECELLMODEL_IMPLEMENTATION(zz_rightMultiLine, BOOL, isRightMultiLine)
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

ZCHAIN_CLASS_CREATE(ZTextFieldModel, NSString *, zz_textCellModel_create, cellTitle)


ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorBack, UIColor *, backColor)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorDarkBack, UIColor *, backDarkColor)

ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_setData, id, data)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_marginLineLeft, CGFloat, lineLeftMargin)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_marginLineRight, CGFloat, lineRightMargin)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_cellWidth, CGFloat, cellWidth)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_cellHeight, CGFloat, cellHeight)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_selected, BOOL, isSelected)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_lineHidden, BOOL, isHiddenLine)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorLine, UIColor *, lineColor)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorDarkLine, UIColor *, lineDarkColor)


ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_marginLeft, CGFloat, leftMargin)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_marginRight, CGFloat, rightMargin)

ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_imageLeftHeight, CGFloat, leftImageH)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_imageLeft, id, leftImage)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_imageLeftRadius, BOOL, isLeftImageRadius)


ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_titleLeft, NSString *, leftTitle)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorLeft, UIColor *, leftColor)

ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorDarkLeft, UIColor *, leftDarkColor)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_fontLeft, UIFont *, leftFont)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_alignmentLeft, NSTextAlignment, leftTextAlignment)

ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_imageRightHeight, CGFloat, rightImageH)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_imageRight, id, rightImage)

ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_subTitleLeft, NSString *, leftSubTitle)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorSubLeft, UIColor *, leftSubColor)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorDarkSubLeft, UIColor *, leftSubDarkColor)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_fontSubLeft, UIFont *,leftSubFont)

ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorRight, UIColor *, rightColor)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorDarkRight, UIColor *, rightDarkColor)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_fontRight, UIFont *, rightFont)

ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_titleRight, NSString *, rightTitle)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_alignmentRight, NSTextAlignment,rightTextAlignment)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_subTitleRight, NSString *, rightSubTitle)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorSubRight, UIColor *, rightSubColor)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorDarkSubRight, UIColor *, rightSubDarkColor)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_fontSubRight, UIFont *, rightSubFont)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_contentSpaceLeft, CGFloat, leftContentSpace)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_contentSpaceRight, CGFloat, rightContentSpace)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_spaceLine, CGFloat, lineSpace)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_contentLeftWidth, CGFloat, leftContentWidth)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_leftMultiLine, BOOL, isLeftMultiLine)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_rightMultiLine, BOOL, isRightMultiLine)
//----------------------------------------------------------------------------

ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorText, UIColor *, textColor)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_colorDarkText, UIColor *, textDarkColor)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_fontText, UIFont *, textFont)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_alignmentText, NSTextAlignment, textAlignment)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_formatter, ZFormatterType, formatterType)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_placeholder, NSString *, placeholderText)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_max, NSInteger, maxLength)

ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_content, NSString *, textContent)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_heightTextField, CGFloat, textFieldHeight)

ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_lineInputHidden, BOOL, isHiddenInputLine)
ZCHAIN_TEXTCELLMODEL_IMPLEMENTATION(zz_textEnabled, BOOL, isTextEnabled)

@end
