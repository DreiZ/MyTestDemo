//
//  ZBaseCellModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilsMacros.h"

#define kCellTitleFont CGFloatIn750(30)

#define kCellLeftMargin CGFloatIn750(30)
#define kCellRightMargin CGFloatIn750(30)

#define kCellContentSpace CGFloatIn750(20)
#define kCellContentLittleSpace CGFloatIn750(10)  //图片内容小间距
#define kCellNormalHeight CGFloatIn750(100) //默认单列高度

@interface ZBaseCellModel : NSObject
//左侧间距
@property (nonatomic,assign) CGFloat leftMargin;
//右侧间距
@property (nonatomic,assign) CGFloat rightMargin;

//底部线条
@property (nonatomic,assign) BOOL isHiddenLine;
@property (nonatomic,strong) UIColor *lineColor;

//cellConfig Title
@property (nonatomic,strong) NSString *cellTitle;

@property (nonatomic,assign) CGFloat titleWidth;
@property (nonatomic,assign) CGFloat lineLeftMargin;
@property (nonatomic,assign) CGFloat lineRightMargin;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGFloat cellWidth;//cell的宽度
@property (nonatomic,strong) id data;

@end


@interface ZBaseSingleCellModel : ZBaseCellModel
@property (nonatomic,strong) NSString *leftImage;
@property (nonatomic,strong) NSString *leftTitle;
@property (nonatomic,strong) UIColor *leftColor;
@property (nonatomic,strong) UIColor *leftDarkColor;
@property (nonatomic,strong) UIFont *leftFont;

@property (nonatomic,strong) NSString *rightImage;
@property (nonatomic,strong) UIColor *rightColor;
@property (nonatomic,strong) UIColor *rightDarkColor;
@property (nonatomic,strong) UIFont *rightFont;
@property (nonatomic,strong) NSString *rightTitle;

//内容之间间距
@property (nonatomic,assign) CGFloat leftContentSpace;
@property (nonatomic,assign) CGFloat rightContentSpace;

@property (nonatomic,assign) BOOL isSelected;
@end


//文字多列
@interface ZBaseMultiseriateCellModel : ZBaseSingleCellModel
@property (nonatomic,assign) CGFloat lineSpace;
@property (nonatomic,assign) CGFloat leftImageWidth;
@property (nonatomic,assign) CGFloat rightImageWidth;
@property (nonatomic,assign) CGFloat singleCellHeight;

@end

//textField cell model
@interface ZBaseTextFieldCellModel : ZBaseCellModel
//标题默认宽220
@property (nonatomic,assign) CGFloat leftContentWidth;
@property (nonatomic,assign) CGFloat textFieldHeight;

//输入框字体颜色
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *textDarkColor;
@property (nonatomic,strong) UIFont *textFont;

@property (nonatomic,strong) UIColor *leftColor;
@property (nonatomic,strong) UIColor *leftDarkColor;
@property (nonatomic,strong) UIFont *leftFont;

@property (nonatomic,strong) UIColor *rightColor;
@property (nonatomic,strong) UIColor *rightDarkColor;
@property (nonatomic,strong) UIFont *rightFont;

@property (nonatomic,strong) UIColor *subTitleColor;
@property (nonatomic,strong) UIColor *subTitleDarkColor;
@property (nonatomic,strong) UIFont *subTitleFont;

//内容之间间距
@property (nonatomic,assign) CGFloat contentSpace;
@property (nonatomic,assign) ZFormatterType formatterType;
@property (nonatomic,assign) NSTextAlignment textAlignment;
@property (nonatomic,assign) CGFloat rightImageWidth;

@property (nonatomic,strong) NSString *placeholder;
@property (nonatomic,assign) NSInteger max;

@property (nonatomic,strong) NSString *leftTitle;
@property (nonatomic,strong) NSString *rightTitle;
@property (nonatomic,strong) NSString *rightImage;
@property (nonatomic,strong) NSString *subTitle;


@property (nonatomic,strong) NSString *content;
@property (nonatomic,assign) BOOL isHiddenInputLine;
@property (nonatomic,assign) BOOL isTextEnabled;
@end
