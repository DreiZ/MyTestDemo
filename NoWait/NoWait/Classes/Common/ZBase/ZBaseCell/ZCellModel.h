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

ZCHAIN_LINECELLMODEL_PROPERTY(selected, BOOL)
ZCHAIN_LINECELLMODEL_PROPERTY(width, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(height, CGFloat)

ZCHAIN_LINECELLMODEL_PROPERTY(lineHidden, BOOL)
ZCHAIN_LINECELLMODEL_PROPERTY(colorLine, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(colorDarkLine, UIColor *)

ZCHAIN_LINECELLMODEL_PROPERTY(marginLineLeft, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(marginLineRight, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(setData, id)

ZCHAIN_LINECELLMODEL_PROPERTY(marginLeft, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(marginRight, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(imageLeftHeight, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(imageLeft, id)
ZCHAIN_LINECELLMODEL_PROPERTY(imageLeftRadius, BOOL)


ZCHAIN_LINECELLMODEL_PROPERTY(titleLeft, NSString *)
ZCHAIN_LINECELLMODEL_PROPERTY(colorLeft, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(colorDarkLeft, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(fontLeft, UIFont *)
ZCHAIN_LINECELLMODEL_PROPERTY(alignmentLeft, NSTextAlignment)

ZCHAIN_LINECELLMODEL_PROPERTY(imageRightHeight, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(imageRight, id)

ZCHAIN_LINECELLMODEL_PROPERTY(subTitleLeft, NSString *)
ZCHAIN_LINECELLMODEL_PROPERTY(colorSubLeft, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(colorDarkSubLeft, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(fontSubLeft, UIFont *)

ZCHAIN_LINECELLMODEL_PROPERTY(colorRight, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(colorDarkRight, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(fontRight, UIFont *)

ZCHAIN_LINECELLMODEL_PROPERTY(titleRight, NSString *)
ZCHAIN_LINECELLMODEL_PROPERTY(alignmentRight, NSTextAlignment)
ZCHAIN_LINECELLMODEL_PROPERTY(subTitleRight, NSString *)
ZCHAIN_LINECELLMODEL_PROPERTY(colorSubRight, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(colorDarkSubRight, UIColor *)
ZCHAIN_LINECELLMODEL_PROPERTY(fontSubRight, UIFont *)
ZCHAIN_LINECELLMODEL_PROPERTY(contentSpaceLeft, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(contentSpaceRight, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(spaceLine, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(contentLeftWidth, CGFloat)
ZCHAIN_LINECELLMODEL_PROPERTY(leftMultiLine, BOOL)
ZCHAIN_LINECELLMODEL_PROPERTY(rightMultiLine, BOOL)
@end


