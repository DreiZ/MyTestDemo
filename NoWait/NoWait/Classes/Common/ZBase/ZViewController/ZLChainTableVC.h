//
//  ZLChainTableVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/8/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"

#define  ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(methodName,ZZParamType) ZCHAIN_PROPERTY ZCHAIN_BLOCK(ZLChainTableVC *, methodName, ZZParamType)


@interface ZLChainTableVC : ZViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIView *safeFooterView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@property (nonatomic,strong) NSMutableArray *headSectionArr;
@property (nonatomic,strong) NSMutableArray *footerSectionArr;

#pragma mark - Chain function 调用方法(设置数据、UI)
//更新DataSource
ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_updateDataSource, void (^)(void));

//更新mainview
ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_resetMainView, void (^)(void));

//设置nav title
ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_setNavTitle, NSString *);

//tableView颜色
ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_setTableViewGary, void);

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_setTableViewWhite, void);

//刷新数据
ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_reload_Net, void);

//刷新UI
ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_reload_ui, void);


#pragma mark - Chain function tableview下拉刷新 空数据代理
ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_addRefreshHeader, void);

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_addLoadMoreFooter, void);

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_addEmptyDataDelegate, void);


#pragma mark - Chain block 设置刷新数据Block
ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setRefreshHeaderNet, void (^)(void));

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setRefreshMoreNet, void (^)(void));


#pragma mark -  Chain block configArr -------update-----
ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setUpdateCellConfigData, void (^)(void (^)(NSMutableArray *)));


#pragma mark -  Chain block tableView -------datasource-----
ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setNumberOfSectionsInTableView, NSInteger (^)(UITableView *));

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setNumberOfRowsInSection, NSInteger (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setCellForRowAtIndexPath, UITableViewCell *(^)(UITableView *, NSIndexPath *));

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setViewForHeaderInSection, UIView *(^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setViewForFooterInSection, UIView *(^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setCellConfigForRowAtIndexPath, void(^)(UITableView *, NSIndexPath *, UITableViewCell *, ZCellConfig *));


#pragma mark - Chain block tableView ------delegate-----
ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setHeightForRowAtIndexPath, CGFloat (^)(UITableView *, NSIndexPath *));

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setHeightForHeaderInSection, CGFloat (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setHeightForFooterInSection, CGFloat (^)(UITableView *, NSInteger));

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setDidSelectRowAtIndexPath, void (^)(UITableView *, NSIndexPath *));

ZCHAIN_TABLEVIEWCONTROLLER_PROPERTY(zChain_block_setConfigDidSelectRowAtIndexPath, void(^)(UITableView *, NSIndexPath *, ZCellConfig *));


#pragma mark - add cell
ZCHAIN_PROPERTY ZCHAIN_BLOCK(ZCellConfig *, addCell, NSString *);

ZCHAIN_PROPERTY ZCHAIN_BLOCKTWO(ZCellConfig *, addSectionCell, NSString *,NSInteger);

#pragma mark - add section
ZCHAIN_PROPERTY ZCHAIN_BLOCK(ZSectionConfig *, addHeaderSection, NSString *);

ZCHAIN_PROPERTY ZCHAIN_BLOCK(ZSectionConfig *, addFooterSection, NSString *);
@end

