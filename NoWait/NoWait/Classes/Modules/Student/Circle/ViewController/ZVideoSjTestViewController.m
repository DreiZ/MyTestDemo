//
//  ZVideoSjTestViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZVideoSjTestViewController.h"

@interface ZVideoSjTestViewController ()

@end

@implementation ZVideoSjTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"sjvideo")
    .zChain_addEmptyDataDelegate()
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter();
    
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        ZLineCellModel *sModel = ZLineCellModel.zz_lineCellModel_create(@"stuentTitle")
        .zz_titleLeft(@"已选标签")
        .zz_fontLeft([UIFont boldFontMaxTitle])
        .zz_cellHeight(CGFloatIn750(88))
        .zz_lineHidden(YES);
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:@"title" showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:sModel] cellType:ZCellTypeClass dataModel:sModel];
        
        [self.cellConfigArr addObject:titleCellConfig];
        [self.cellConfigArr addObject:titleCellConfig];
        [self.cellConfigArr addObject:titleCellConfig];
        [self.cellConfigArr addObject:titleCellConfig];
        [self.cellConfigArr addObject:titleCellConfig];
        [self.cellConfigArr addObject:titleCellConfig];
        [self.cellConfigArr addObject:titleCellConfig];
        
    });
    
    self.zChain_reload_ui();
}
@end
