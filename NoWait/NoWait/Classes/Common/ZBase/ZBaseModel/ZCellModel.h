//
//  ZCellModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/30.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilsMacros.h"
#import "ZChainCommon.h"
//
////ZCellModel
//#define  ZCHAIN_CELLMODEL_PROPERTY(methodName,ZZParamType) ZCHAIN_PROPERTY ZCHAIN_BLOCK(ZCellModel *, methodName, ZZParamType)
//
//
//#define ZCHAIN_CELLMODEL_IMPLEMENTATION(methodName,ZZParamType,attribute) ZCHAIN_IMPLEMENTATION(ZCellModel *,methodName,ZZParamType,attribute)


//ZLineCellModel
#define  ZCHAIN_LINECELLMODEL_PROPERTY(methodName,ZZParamType) ZCHAIN_PROPERTY ZCHAIN_BLOCK(ZLineCellModel *, methodName, ZZParamType)

#define ZCHAIN_LINECELLMODEL_IMPLEMENTATION(methodName,ZZParamType,attribute) ZCHAIN_IMPLEMENTATION(ZLineCellModel *,methodName,ZZParamType,attribute)



#define kLineLeftMargin CGFloatIn750(30)
#define kLineRightMargin CGFloatIn750(0)

#define kCellContentSpace CGFloatIn750(20)
#define kCellNormalWidth KScreenWidth
#define kCellNormalHeight CGFloatIn750(100)

#define kLeftMargin CGFloatIn750(30)
#define kRightMargin CGFloatIn750(30)
#define kCellSubContentSpace CGFloatIn750(20)

#define kLineSpace CGFloatIn750(12)


@interface ZCellModel : NSObject

@end


@interface ZLineCellModel : ZCellModel
@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,strong) NSString *cellTitle;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGFloat cellWidth;

//底部线条
@property (nonatomic,assign) BOOL isHiddenLine;
@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,strong) UIColor *lineDarkColor;

@property (nonatomic,assign) CGFloat lineLeftMargin;
@property (nonatomic,assign) CGFloat lineRightMargin;

@property (nonatomic,strong) id data;

@property (nonatomic,assign) CGFloat leftMargin;
@property (nonatomic,assign) CGFloat rightMargin;
@property (nonatomic,assign) CGFloat leftImageH;
@property (nonatomic,strong) id leftImage;
@property (nonatomic,assign) BOOL isLeftImageRadius;

@property (nonatomic,strong) NSString *leftTitle;
@property (nonatomic,strong) UIColor *leftColor;
@property (nonatomic,strong) UIColor *leftDarkColor;
@property (nonatomic,strong) UIFont *leftFont;
@property (nonatomic,assign) NSTextAlignment leftTextAlignment;

@property (nonatomic,strong) NSString *leftSubTitle;
@property (nonatomic,strong) UIColor *leftSubColor;
@property (nonatomic,strong) UIColor *leftSubDarkColor;
@property (nonatomic,strong) UIFont *leftSubFont;

@property (nonatomic,assign) CGFloat rightImageH;
@property (nonatomic,strong) id rightImage;

@property (nonatomic,strong) UIColor *rightColor;
@property (nonatomic,strong) UIColor *rightDarkColor;
@property (nonatomic,strong) UIFont *rightFont;
@property (nonatomic,strong) NSString *rightTitle;
@property (nonatomic,assign) NSTextAlignment rightTextAlignment;

@property (nonatomic,strong) NSString *rightSubTitle;
@property (nonatomic,strong) UIColor *rightSubColor;
@property (nonatomic,strong) UIColor *rightSubDarkColor;
@property (nonatomic,strong) UIFont *rightSubFont;

//内容之间间距
@property (nonatomic,assign) CGFloat leftContentSpace;
@property (nonatomic,assign) CGFloat rightContentSpace;

@property (nonatomic,assign) CGFloat lineSpace;
@property (nonatomic,assign) CGFloat leftContentWidth;

@property (nonatomic,assign) BOOL isLeftMultiLine;
@property (nonatomic,assign) BOOL isRightMultiLine;

ZCHAIN_OBJ_CREATE(ZLineCellModel *, NSString *,zz_lineCellModel_create)

ZCHAIN_LINECELLMODEL_PROPERTY(zz_selected, BOOL)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_cellWidth, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_cellHeight, CGFloat)

ZCHAIN_LINECELLMODEL_PROPERTY(zz_lineHidden, BOOL)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorLine, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorDarkLine, UIColor *)

ZCHAIN_LINECELLMODEL_PROPERTY(zz_marginLineLeft, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_marginLineRight, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_setData, id)

ZCHAIN_LINECELLMODEL_PROPERTY(zz_marginLeft, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_marginRight, CGFloat)

ZCHAIN_LINECELLMODEL_PROPERTY(zz_imageLeftHeight, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_imageLeft, id)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_imageLeftRadius, BOOL)


ZCHAIN_LINECELLMODEL_PROPERTY(zz_titleLeft, NSString *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorLeft, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorDarkLeft, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_fontLeft, UIFont *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_alignmentLeft, NSTextAlignment)

ZCHAIN_LINECELLMODEL_PROPERTY(zz_imageRightHeight, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_imageRight, id)

ZCHAIN_LINECELLMODEL_PROPERTY(zz_subTitleLeft, NSString *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorSubLeft, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorDarkSubLeft, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_fontSubLeft, UIFont *)

ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorRight, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorDarkRight, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_fontRight, UIFont *)

ZCHAIN_LINECELLMODEL_PROPERTY(zz_titleRight, NSString *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_alignmentRight, NSTextAlignment)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_subTitleRight, NSString *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorSubRight, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorDarkSubRight, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_fontSubRight, UIFont *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_contentSpaceLeft, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_contentSpaceRight, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_spaceLine, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_contentLeftWidth, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_leftMultiLine, BOOL)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_rightMultiLine, BOOL)
@end


@interface ZTextFieldModel : ZLineCellModel

@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *textDarkColor;
@property (nonatomic,strong) UIFont *textFont;

@property (nonatomic,assign) ZFormatterType formatterType;
@property (nonatomic,assign) NSTextAlignment textAlignment;

@property (nonatomic,strong) NSString *placeholderText;
@property (nonatomic,assign) NSInteger maxLength;
@property (nonatomic,strong) NSString *textContent;
@property (nonatomic,assign) CGFloat textFieldHeight;

@property (nonatomic,assign) BOOL isHiddenInputLine;
@property (nonatomic,assign) BOOL isTextEnabled;

ZCHAIN_OBJ_CREATE(ZTextFieldModel *, NSString *,zz_textCellModel_create)

ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorText, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_colorDarkText, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_fontText, UIFont *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_alignmentText, NSTextAlignment)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_formatter, ZFormatterType)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_placeholder, NSString *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_max, NSInteger)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_content, NSString *)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_heightTextField, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_lineInputHidden, BOOL)
ZCHAIN_LINECELLMODEL_PROPERTY(zz_textEnabled, BOOL)
@end
