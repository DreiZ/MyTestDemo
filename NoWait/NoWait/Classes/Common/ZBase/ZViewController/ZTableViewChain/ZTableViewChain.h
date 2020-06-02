//
//  ZTableViewChain.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/1.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseModel.h"
#import "UtilsMacros.h"
#import "ZChainCommon.h"


#define  ZCHAIN_TABLEVIEWCHAIN_PROPERTY(methodName,ZZParamType) ZCHAIN_PROPERTY ZCHAIN_BLOCK(ZTableViewChain *, methodName, ZZParamType)

#define ZCHAIN_TABLEVIEWCHAIN_IMPLEMENTATION(methodName,ZZParamType,attribute) ZCHAIN_IMPLEMENTATION(ZTableViewChain *,methodName,ZZParamType,attribute)

#define ZCHAIN_TABLEVIEWCHAIN_BLOCK_IMPLEMENTATION(methodName,ZZParamType,ZZParamBackType,attribute)    ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewChain *,methodName,ZZParamType,ZZParamBackType,attribute)

@interface ZTableViewChain : ZBaseModel
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *emptyDataStr;
@property (nonatomic,strong) UIColor *tableViewColor;

@property (nonatomic,strong) NSMutableArray *(^configArr)(void);
@property (nonatomic,strong) void (^refreshHeader)(void);
@property (nonatomic,strong) void (^refreshFooter)(void);
@property (nonatomic,strong) void (^emptyDelegate)(void);

#pragma mark - tableview - datasource - delegate
@property (nonatomic,strong) NSInteger (^numberOfSectionsInTableView)(UITableView *);
@property (nonatomic,strong) NSInteger (^numberOfRowsInSection)(UITableView *,NSInteger);
@property (nonatomic,strong) UITableViewCell *(^cellForRowAtIndexPath)(UITableView *,NSIndexPath *);
@property (nonatomic,strong) CGFloat (^heightForRowAtIndexPath)(UITableView *,NSIndexPath *);
@property (nonatomic,strong) CGFloat (^heightForHeaderInSection)(UITableView *,NSInteger);
@property (nonatomic,strong) CGFloat (^heightForFooterInSection)(UITableView *,NSInteger);
@property (nonatomic,strong) UIView *(^viewForHeaderInSection)(UITableView *,NSInteger);
@property (nonatomic,strong) UIView *(^viewForFooterInSection)(UITableView *,NSInteger);
@property (nonatomic,strong) void (^didSelectRowAtIndexPath)(UITableView *,NSIndexPath *);

ZCHAIN_OBJ_CREATE(ZTableViewChain *, NSString *, zz_tableViewChain_create)

//ZCHAIN_TABLEVIEWCHAIN_PROPERTY(sett, UIColor *);
ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setEmptyStr, NSString *);

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setConfigArr, NSMutableArray *(^)(void));
ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setRefreshHeader, void (^)(void));
ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setRefreshFooter, void (^)(void));
ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setEmptyDelegate, void (^)(void));

#pragma mark - tableview block- datasource - delegate
ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setNumberOfSectionsInTableView, NSInteger (^)(UITableView *));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setNumberOfRowsInSection, NSInteger (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setCellForRowAtIndexPath, UITableViewCell *(^)(UITableView *, NSIndexPath *));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setHeightForRowAtIndexPath, CGFloat (^)(UITableView *, NSIndexPath *));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setHeightForHeaderInSection, CGFloat (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setHeightForFooterInSection, CGFloat (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setViewForHeaderInSection, UIView *(^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setViewForFooterInSection, UIView *(^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setDidSelectRowAtIndexPath, void (^)(UITableView *, NSIndexPath *));
@end
