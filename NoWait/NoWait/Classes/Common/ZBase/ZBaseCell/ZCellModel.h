//
//  ZCellModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/30.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilsMacros.h"

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
@end


@interface ZLineCellModel : ZCellModel
@property (nonatomic,assign) CGFloat leftMargin;
@property (nonatomic,assign) CGFloat rightMargin;

@property (nonatomic,assign) CGFloat leftImageH;
@property (nonatomic,strong) id leftImage;

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
@end


