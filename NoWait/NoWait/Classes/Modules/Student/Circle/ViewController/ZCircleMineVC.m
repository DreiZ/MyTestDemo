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

#import "ZBaseUnitModel.h"

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
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"个人中心")
    .zChain_setTableViewWhite()
    .zChain_resetMainView(^{
        self.iTableView.tableHeaderView = self.headView;
    }).zChain_block_setViewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
        if (section == 0) {
            return weakSelf.sectionView;;
        }
        return nil;
    }).zChain_block_setHeightForHeaderInSection(^CGFloat(UITableView *tableView, NSInteger section) {
        if (section == 0) {
            return CGFloatIn750(76);
        }
        return 0;
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        if (weakSelf.isCollection) {
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCollectionTableViewCell className] title:@"ZCircleMineDynamicCollectionTableViewCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCollectionTableViewCell z_getCellHeight:@[@"",@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@"",@""]];
            [weakSelf.cellConfigArr addObject:menuCellConfig];
            [weakSelf.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(4))];
        }else{
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@"",@""]];
            [weakSelf.cellConfigArr addObject:menuCellConfig];
            
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@"",@""]];
                [weakSelf.cellConfigArr addObject:menuCellConfig];
            }
            
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@""]];
                [weakSelf.cellConfigArr addObject:menuCellConfig];
            }
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@""]] cellType:ZCellTypeClass dataModel:@[@""]];
                [weakSelf.cellConfigArr addObject:menuCellConfig];
            }
            
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@"",@""]];
                [weakSelf.cellConfigArr addObject:menuCellConfig];
            }
            
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@""]];
                [weakSelf.cellConfigArr addObject:menuCellConfig];
            }
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@""]] cellType:ZCellTypeClass dataModel:@[@""]];
                [weakSelf.cellConfigArr addObject:menuCellConfig];
            }
            
            {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCell className] title:@"ZCircleMineDynamicCell" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleMineDynamicCell z_getCellHeight:@[@"",@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@"",@""]];
                [weakSelf.cellConfigArr addObject:menuCellConfig];
            }
        }
        
    });
    
    
    self.zChain_reload_ui();
    
}

#pragma mark - 懒加载--
- (ZCircleMineHeaderView *)headView {
    if (!_headView) {
        __weak typeof(self) weakSelf = self;
        CGSize tempSize = [@"这个颜色太神奇了" tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(60), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        _headView = [[ZCircleMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(292)+tempSize.height)];
        _headView.handleBlock = ^(NSInteger index) {
            DLog(@"----%ld", (long)index);
            
            if (index == 0) {
                
            }else if(index == 1){
                routePushVC(ZRoute_circle_myFocus, nil, nil);
            }else if(index == 2){
                routePushVC(ZRoute_circle_myFans, nil, nil);
            }else if(index == 4){
                
                //签名
                ZBaseTextVCModel *edit = [[ZBaseTextVCModel alloc] init];
                edit.navTitle = @"设置个性签名";
                edit.formatter = ZFormatterTypeAnyByte;
                edit.max = 90;
                edit.hitStr = @"签名只可有汉字字母数字下划线组成，90字节以内";
                edit.showHitStr = @"你还没有输入任何签名";
                edit.placeholder = @"请输入签名";
                
                routePushVC(ZRoute_mine_textEditVC, edit, ^(id  _Nullable result, NSError * _Nullable error) {
                    weakSelf.zChain_reload_ui();
                });
            }else if(index == 5){
                //关注
            }
        };
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

