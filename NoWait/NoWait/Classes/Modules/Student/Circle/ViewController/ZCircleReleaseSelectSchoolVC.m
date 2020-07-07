//
//  ZCircleReleaseSelectSchoolVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseSelectSchoolVC.h"
#import "ZCircleReleaseSchoolListCell.h"
#import "ZCircleSearchTextView.h"

@interface ZCircleReleaseSelectSchoolVC ()
@property (nonatomic,strong) ZCircleSearchTextView *searchView;

@end

@implementation ZCircleReleaseSelectSchoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.zChain_setNavTitle(@"选择校区")
    .zChain_resetMainView(^{
        [self.view addSubview:self.searchView];
        [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.searchView.mas_bottom);
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseSchoolListCell className] title:@"ZCircleReleaseSchoolListCell" showInfoMethod:nil heightOfCell:[ZCircleReleaseSchoolListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];

        [self.cellConfigArr  addObject:menuCellConfig];
        [self.cellConfigArr  addObject:menuCellConfig];
        [self.cellConfigArr  addObject:menuCellConfig];
        [self.cellConfigArr  addObject:menuCellConfig];
        [self.cellConfigArr  addObject:menuCellConfig];
        [self.cellConfigArr  addObject:menuCellConfig];
    });
    
    self.zChain_reload_ui();
}

- (ZCircleSearchTextView *)searchView {
    if (!_searchView) {
        _searchView = [[ZCircleSearchTextView alloc] init];
        _searchView.searchBlock = ^(NSString * text) {
            
        };
        
        _searchView.textChangeBlock = ^(NSString * text) {
            
        };
    }
    return _searchView;
}
@end
