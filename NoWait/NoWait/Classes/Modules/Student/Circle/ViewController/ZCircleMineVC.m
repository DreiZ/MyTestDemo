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
#import "ZCircleMineDynamicCollectionTableViewCell.h"
@interface ZCircleMineVC ()

@property (nonatomic,strong) ZCircleMineHeaderView *headView;
@property (nonatomic,strong) ZCircleMineSectionView *sectionView;
@property (nonatomic,assign) BOOL isCollection;
@end

@implementation ZCircleMineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zChain_setNavTitle(@"个人中心")
    .zChain_setTableViewWhite()
    .zChain_resetMainView(^{
        self.iTableView.tableHeaderView = self.headView;
    }).zChain_block_setViewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
        if (section == 0) {
            return self.sectionView;;
        }
        return nil;
    }).zChain_block_setHeightForHeaderInSection(^CGFloat(UITableView *tableView, NSInteger section) {
        if (section == 0) {
            return CGFloatIn750(76);
        }
        return 0;
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        
        if (self.isCollection) {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCollectionTableViewCell className] title:@"ZCircleMineDynamicCollectionTableViewCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCollectionTableViewCell z_getCellHeight:@[@"",@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@"",@""]];
            [self.cellConfigArr addObject:menuCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(4))];
            [self.cellConfigArr addObject:menuCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(4))];
            [self.cellConfigArr addObject:menuCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(4))];
            [self.cellConfigArr addObject:menuCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(4))];
            [self.cellConfigArr addObject:menuCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(4))];
            [self.cellConfigArr addObject:menuCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(4))];
            [self.cellConfigArr addObject:menuCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(4))];
            [self.cellConfigArr addObject:menuCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(4))];
            [self.cellConfigArr addObject:menuCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(4))];
            [self.cellConfigArr addObject:menuCellConfig];
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(4))];
            [self.cellConfigArr addObject:menuCellConfig];
        }else{
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@"",@""]];
            [self.cellConfigArr addObject:menuCellConfig];
            
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@"",@""]];
                [self.cellConfigArr addObject:menuCellConfig];
            }
            
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@""]];
                [self.cellConfigArr addObject:menuCellConfig];
            }
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@""]] cellType:ZCellTypeClass dataModel:@[@""]];
                [self.cellConfigArr addObject:menuCellConfig];
            }
            
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@"",@""]];
                [self.cellConfigArr addObject:menuCellConfig];
            }
            
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@""]];
                [self.cellConfigArr addObject:menuCellConfig];
            }
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@""]] cellType:ZCellTypeClass dataModel:@[@""]];
                [self.cellConfigArr addObject:menuCellConfig];
            }
            
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@"",@""]];
                [self.cellConfigArr addObject:menuCellConfig];
            }
        }
        
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
        __weak typeof(self) weakSelf = self;
        _sectionView = [[ZCircleMineSectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(76))];
        _sectionView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                weakSelf.isCollection = NO;
            }else{
                weakSelf.isCollection = YES;
            }
            weakSelf.zChain_reload_ui();
        };
    }
    return _sectionView;
}
@end

