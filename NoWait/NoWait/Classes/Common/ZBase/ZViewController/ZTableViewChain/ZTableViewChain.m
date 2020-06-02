//
//  ZTableViewChain.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/1.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewChain.h"


@implementation ZTableViewChain

ZCHAIN_CLASS_CREATE(ZTableViewChain, NSString *, zz_tableViewChain_create, title)

ZCHAIN_TABLEVIEWCHAIN_IMPLEMENTATION(setTableColor, UIColor *, tableViewColor)
ZCHAIN_TABLEVIEWCHAIN_IMPLEMENTATION(setEmptyStr, NSString *, emptyDataStr)

ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewChain *, setConfigArr, configArr, NSMutableArray *, void)
ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewChain *, setRefreshHeader, refreshHeader, void, void)
ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewChain *, setRefreshFooter, refreshFooter, void, void)
ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewChain *, setEmptyDelegate, emptyDelegate, void, void)

#pragma mark - tableview block- datasource - delegate
ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewChain *, setNumberOfSectionsInTableView, numberOfSectionsInTableView, NSInteger, UITableView *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewChain *, setNumberOfRowsInSection, numberOfRowsInSection, NSInteger, UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewChain *, setCellForRowAtIndexPath, cellForRowAtIndexPath, UITableViewCell *, UITableView *, NSIndexPath *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewChain *, setHeightForRowAtIndexPath, heightForRowAtIndexPath, CGFloat , UITableView *, NSIndexPath *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewChain *, setHeightForHeaderInSection, heightForHeaderInSection, CGFloat , UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewChain *, setHeightForFooterInSection, heightForFooterInSection, CGFloat , UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewChain *, setViewForHeaderInSection, viewForHeaderInSection, UIView *, UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewChain *, setViewForFooterInSection, viewForFooterInSection, UIView *, UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewChain *, setDidSelectRowAtIndexPath, didSelectRowAtIndexPath, void, UITableView *, NSIndexPath *)
@end
