//
//  ZTableViewController.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"

#define  ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(methodName,ZZParamType) ZCHAIN_PROPERTY ZCHAIN_BLOCK(ZTableViewController *, methodName, ZZParamType)

@interface ZTableViewController : ZViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIView *safeFooterView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

#pragma mark - 重写数据方法
@property (nonatomic,strong) void (^updateDataSource)(void);

@property (nonatomic,strong) void (^setMainView)(void);

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(resetDataSource, void (^)(void));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(resetMainView, void (^)(void));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(refreshNetData, void);

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setNavTitle, NSString *);

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(reloadData, void);

#pragma mark - 刷新数据
@property (nonatomic,strong) void (^refreshHead)(void);

@property (nonatomic,strong) void (^refreshMore)(void);

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setRefreshNet, void (^)(void));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setRefreshMoreNet, void (^)(void));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setTableViewGary, void);

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setTableViewWhite, void);

#pragma mark - 设置tableview下拉刷新 空数据代理
ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setRefreshHeader, void);

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setRefreshFooter, void);

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setEmptyDataDelegate, void);

#pragma mark - configArr -------update-----
@property (nonatomic,strong) void (^updateConfigArr)(void (^)(NSMutableArray *));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setUpdateConfigArr, void (^)(void (^)(NSMutableArray *)));

#pragma mark - tableView -------datasource-----
@property (nonatomic,strong) NSInteger (^numberOfSectionsInTableView)(UITableView *);

@property (nonatomic,strong) NSInteger (^numberOfRowsInSection)(UITableView *,NSInteger);

@property (nonatomic,strong) UITableViewCell *(^cellForRowAtIndexPath)(UITableView *,NSIndexPath *);

@property (nonatomic,strong) UIView *(^viewForHeaderInSection)(UITableView *,NSInteger);

@property (nonatomic,strong) UIView *(^viewForFooterInSection)(UITableView *,NSInteger);

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setNumberOfSectionsInTableView, NSInteger (^)(UITableView *));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setNumberOfRowsInSection, NSInteger (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setCellForRowAtIndexPath, UITableViewCell *(^)(UITableView *, NSIndexPath *));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setViewForHeaderInSection, UIView *(^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setViewForFooterInSection, UIView *(^)(UITableView *, NSInteger));


#pragma mark - tableView ------delegate-----
@property (nonatomic,strong) CGFloat (^heightForRowAtIndexPath)(UITableView *,NSIndexPath *);

@property (nonatomic,strong) CGFloat (^heightForHeaderInSection)(UITableView *,NSInteger);

@property (nonatomic,strong) CGFloat (^heightForFooterInSection)(UITableView *,NSInteger);

@property (nonatomic,strong) void (^didSelectRowAtIndexPath)(UITableView *,NSIndexPath *);

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setHeightForRowAtIndexPath, CGFloat (^)(UITableView *, NSIndexPath *));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setHeightForHeaderInSection, CGFloat (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setHeightForFooterInSection, CGFloat (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCONTROLLERCHAIN_PROPERTY(setDidSelectRowAtIndexPath, void (^)(UITableView *, NSIndexPath *));
@end
