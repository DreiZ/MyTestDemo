//
//  ZCircleMineVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineVC.h"
#import "ZCircleMineHeaderView.h"
#import "ZCircleMineSectionView.h"
#import "ZCircleMineDynamicCell.h"

@interface ZCircleMineVC ()

@property (nonatomic,strong) ZCircleMineHeaderView *headView;
@property (nonatomic,strong) ZCircleMineSectionView *sectionView;

@end

@implementation ZCircleMineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zChain_setNavTitle(@"个人中心");
    self.zChain_resetMainView(^{
        self.iTableView.tableHeaderView = self.headView;
    });
    self.zChain_block_setViewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
        if (section == 0) {
            return self.sectionView;;
        }
        return nil;
    });
    self.zChain_block_setHeightForHeaderInSection(^CGFloat(UITableView *tableView, NSInteger section) {
        if (section == 0) {
            return CGFloatIn750(76);
        }
        return 0;
    });
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:nil heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
    });
    
    
    self.zChain_reload_ui();
    
}

#pragma mark - 懒加载--
- (ZCircleMineHeaderView *)headView {
    if (!_headView) {
        CGSize tempSize = [@"这个颜色太神奇了" tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(60), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        _headView = [[ZCircleMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(292)+tempSize.height)];
        
    }
    return _headView;
}

- (ZCircleMineSectionView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[ZCircleMineSectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(76))];
    }
    return _sectionView;
}
@end

