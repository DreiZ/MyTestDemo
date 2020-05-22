


//
//  WMZDropMenuParam.m
//  WMZDropDownMenu
//
//  Created by wmz on 2019/11/19.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZDropMenuParam.h"

@implementation WMZDropMenuParam
WMZDropMenuParam * MenuParam(void){
    return  [WMZDropMenuParam  new];
}
WMZMenuSetFuncImplementation(WMZDropMenuParam, UIColor*,           wShadowColor)
WMZMenuSetFuncImplementation(WMZDropMenuParam, UIColor*,           wCollectionViewCellBgColor)
WMZMenuSetFuncImplementation(WMZDropMenuParam, UIColor*,           wCollectionViewCellTitleColor)
WMZMenuSetFuncImplementation(WMZDropMenuParam, UIColor*,           wCollectionViewCellSelectBgColor)
WMZMenuSetFuncImplementation(WMZDropMenuParam, UIColor*,           wCollectionViewCellSelectTitleColor)
WMZMenuSetFuncImplementation(WMZDropMenuParam, NSTextAlignment,    wTextAlignment)
WMZMenuSetFuncImplementation(WMZDropMenuParam, NSArray* ,          wTableViewColor)
WMZMenuSetFuncImplementation(WMZDropMenuParam, NSArray*,           wReginerCollectionCells)
WMZMenuSetFuncImplementation(WMZDropMenuParam, NSArray*,           wReginerCollectionHeadViews)
WMZMenuSetFuncImplementation(WMZDropMenuParam, NSArray*,           wReginerCollectionFootViews)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wCollectionViewCellSpace)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wShadowAlpha)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wFixDataViewHeight)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wMainRadius)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wCollectionViewCellBorderWith)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wMaxWidthScale)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wMaxHeightScale)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wPopViewWidth)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wFixBtnWidth)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wCollectionViewDefaultFootViewMarginY)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wCollectionViewDefaultFootViewPaddingY)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wPopOraignY)
WMZMenuSetFuncImplementation(WMZDropMenuParam, CGFloat,            wDefaultConfirmHeight)
WMZMenuSetFuncImplementation(WMZDropMenuParam, NSInteger,          wMenuTitleEqualCount)
WMZMenuSetFuncImplementation(WMZDropMenuParam, NSInteger,          wCollectionViewSectionShowExpandCount)
WMZMenuSetFuncImplementation(WMZDropMenuParam, NSInteger,          wCollectionViewSectionRecycleCount)
WMZMenuSetFuncImplementation(WMZDropMenuParam, MenuCustomLine,                wJDCustomLine)
WMZMenuSetFuncImplementation(WMZDropMenuParam, BOOL,               wShadowCanTap)
WMZMenuSetFuncImplementation(WMZDropMenuParam, BOOL,               wShadowShow)
WMZMenuSetFuncImplementation(WMZDropMenuParam, BOOL,               wBorderShow)
WMZMenuSetFuncImplementation(WMZDropMenuParam, BOOL,               wCellSelectShowCheck)
WMZMenuSetFuncImplementation(WMZDropMenuParam, BOOL,               wMenuLine)
- (instancetype)init{
    if (self = [super init]) {
        _wShadowAlpha = 0.4f;
        _wMainRadius = 15.0f;
        _wShadowColor = adaptAndDarkColor(MenuColor(0x333333), MenuColor(0x999999));
        _wShadowCanTap = YES;
        _wShadowShow = YES;
        _wTableViewColor = @[adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlack]),
                             adaptAndDarkColor(MenuColor(0xF6F7FA), MenuColor(0x202020)),
                             adaptAndDarkColor(MenuColor(0xEBECF0), MenuColor(0x505050)),
                             adaptAndDarkColor(MenuColor(0xEBECF0), MenuColor(0x909090))];
        _wTextAlignment = NSTextAlignmentLeft;
        _wCollectionViewCellSpace = Menu_GetWNum(20);
        _wCollectionViewCellBgColor = adaptAndDarkColor(MenuColor(0xf2f2f2), MenuColor(0x2f2f2f));
        _wCollectionViewCellTitleColor = adaptAndDarkColor(MenuColor(0x666666), MenuColor(0x999999));
        _wCollectionViewCellSelectTitleColor = [UIColor redColor];
        _wCollectionViewCellSelectBgColor = adaptAndDarkColor(MenuColor(0xffeceb), MenuColor(0x001213));
        _wMaxWidthScale = 0.9f;
        _wMaxHeightScale = 0.4f;
        _wCollectionViewSectionShowExpandCount = 6;
        _wMenuTitleEqualCount = 3;
        _wDefaultConfirmHeight = 40.0f;
        _wPopViewWidth = Menu_Width/3;
        _wFixBtnWidth = 80;
        _wCellSelectShowCheck = YES;
    }
    return self;
}

@end
