//
//  ZTableViewController.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"

#define  ZCHAIN_TABLEVIEWCHAIN_PROPERTY(methodName,ZZParamType) ZCHAIN_PROPERTY ZCHAIN_BLOCK(ZTableViewController *, methodName, ZZParamType)

#define ZCHAIN_TABLEVIEWCHAIN_IMPLEMENTATION(methodName,ZZParamType,attribute) ZCHAIN_IMPLEMENTATION(ZTableViewController *,methodName,ZZParamType,attribute)

#define ZCHAIN_TABLEVIEWCHAIN_BLOCK_IMPLEMENTATION(methodName,ZZParamType,ZZParamBackType,attribute)    ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewController *,methodName,ZZParamType,ZZParamBackType,attribute)


@interface ZTableViewController : ZViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIView *safeFooterView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

- (void)setupMainView;
- (void)setDataSource;
#pragma mark - 重写数据方法
ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setNavTitle, NSString *);

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(reloadData, void);

@property (nonatomic,strong) void (^refreshHead)(void);

@property (nonatomic,strong) void (^refreshMore)(void);

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setRefreshNet, void (^)(void));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setRefreshMoreNet, void (^)(void));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setTableViewGary, void);

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setTableViewWhite, void);

#pragma mark - 设置tableview 刷新数据 空数据代理
ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setRefreshHeader, void);

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setRefreshFooter, void);

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setEmptyDataDelegate, void);

#pragma mark - configArr -------update-----
@property (nonatomic,strong) void (^updateConfigArr)(void (^)(NSMutableArray *));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setUpdateConfigArr, void (^)(void (^)(NSMutableArray *)));

#pragma mark - tableView -------datasource-----
@property (nonatomic,strong) NSInteger (^numberOfSectionsInTableView)(UITableView *);

@property (nonatomic,strong) NSInteger (^numberOfRowsInSection)(UITableView *,NSInteger);

@property (nonatomic,strong) UITableViewCell *(^cellForRowAtIndexPath)(UITableView *,NSIndexPath *);

@property (nonatomic,strong) UIView *(^viewForHeaderInSection)(UITableView *,NSInteger);

@property (nonatomic,strong) UIView *(^viewForFooterInSection)(UITableView *,NSInteger);

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setNumberOfSectionsInTableView, NSInteger (^)(UITableView *));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setNumberOfRowsInSection, NSInteger (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setCellForRowAtIndexPath, UITableViewCell *(^)(UITableView *, NSIndexPath *));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setViewForHeaderInSection, UIView *(^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setViewForFooterInSection, UIView *(^)(UITableView *, NSInteger));


#pragma mark tableView ------delegate-----
@property (nonatomic,strong) CGFloat (^heightForRowAtIndexPath)(UITableView *,NSIndexPath *);

@property (nonatomic,strong) CGFloat (^heightForHeaderInSection)(UITableView *,NSInteger);

@property (nonatomic,strong) CGFloat (^heightForFooterInSection)(UITableView *,NSInteger);

@property (nonatomic,strong) void (^didSelectRowAtIndexPath)(UITableView *,NSIndexPath *);

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setHeightForRowAtIndexPath, CGFloat (^)(UITableView *, NSIndexPath *));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setHeightForHeaderInSection, CGFloat (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setHeightForFooterInSection, CGFloat (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCHAIN_PROPERTY(setDidSelectRowAtIndexPath, void (^)(UITableView *, NSIndexPath *));
@end

