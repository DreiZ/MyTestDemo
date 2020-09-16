//
//  ZStudentSignDetailListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentSignDetailListVC.h"
#import "ZMineStudentClassSignDetailImageCell.h"
#import "ZMineStudentClassSignDetailSummaryCell.h"

@interface ZStudentSignDetailListVC ()

@end

@implementation ZStudentSignDetailListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"签课详情")
    .zChain_addEmptyDataDelegate()
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_resetMainView(^{
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view);
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(20));
            make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(20));
        }];
        self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        self.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }).zChain_updateDataSource(^{
        
    }).zChain_block_setRefreshHeaderNet(^{
        
    }).zChain_block_setRefreshMoreNet(^{
        
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        
        for (int i = 0; i < 10; i++) {
            NSMutableArray *sectionArr = @[].mutableCopy;
            
//            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title");
//            model.zz_titleLeft(@"初级游泳课")
//            .zz_titleRight(@"李梓萌")
//            .zz_fontLeft([UIFont boldFontContent])
//            .zz_fontRight([UIFont boldFontContent])
//            .zz_colorLeft([UIColor colorMain])
//            .zz_colorRight([UIColor colorMain])
//            .zz_colorDarkLeft([UIColor colorMain])
//            .zz_colorDarkRight([UIColor colorMain])
//            .zz_cellHeight(CGFloatIn750(90));
//
//            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
//            [sectionArr addObject:menuCellConfig];
            
            {
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title");
                model.zz_titleLeft(@"上课进度")
                .zz_titleRight(@"4/10节")
                .zz_fontLeft([UIFont fontContent])
                .zz_fontRight([UIFont fontContent])
                .zz_cellHeight(CGFloatIn750(80));
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [sectionArr addObject:menuCellConfig];
            }
            {
                [sectionArr addObject:getEmptyCellWithHeight(CGFloatIn750(18))];
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentClassSignDetailSummaryCell className] title:@"ZMineStudentClassSignDetailSummaryCell" showInfoMethod:nil heightOfCell:[ZMineStudentClassSignDetailSummaryCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
                [sectionArr addObject:menuCellConfig];
                
                [sectionArr addObject:getEmptyCellWithHeight(CGFloatIn750(28))];
            }
            {
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title");
                model.zz_titleLeft(@"第3节")
                .zz_titleRight(@"2018.01.21 14:30")
                .zz_fontLeft([UIFont boldFontContent])
                .zz_fontRight([UIFont fontSmall])
                .zz_cellHeight(CGFloatIn750(90));
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [sectionArr addObject:menuCellConfig];
                
                ZCellConfig *imageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentClassSignDetailImageCell className] title:model.cellTitle showInfoMethod:@selector(setImage:) heightOfCell:[ZMineStudentClassSignDetailImageCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"http://wx4.sinaimg.cn/mw600/0076BSS5ly1girf1ig4ouj30u018ztma.jpg"];
                [sectionArr addObject:imageCellConfig];
                
            }
            {
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title");
                model.zz_titleLeft(@"班级名称")
                .zz_titleRight(@"已扫码签课")
                .zz_cellHeight(CGFloatIn750(90));
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [sectionArr addObject:menuCellConfig];
            }
            {
                [sectionArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title");
                model.zz_lineHidden(NO)
                .zz_marginLineLeft(CGFloatIn750(30))
                .zz_marginLineRight(CGFloatIn750(30))
                .zz_cellHeight(CGFloatIn750(4));
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [sectionArr addObject:menuCellConfig];
            }
            
            [sectionArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
            
            [weakSelf.cellConfigArr addObject:sectionArr];
        }
    }).zChain_block_setViewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(90))];
        sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlack]);
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textColor = [UIColor colorMain];
        titleLabel.text = @"初级游泳课";
        titleLabel.numberOfLines = 0;
        [titleLabel setFont:[UIFont boldFontContent]];
        [sectionView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sectionView.mas_left).offset(CGFloatIn750(30));
            make.centerY.equalTo(sectionView.mas_centerY);
        }];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLabel.textColor = [UIColor colorMain];
        nameLabel.text = @"李梓萌";
        nameLabel.numberOfLines = 0;
        [nameLabel setFont:[UIFont boldFontContent]];
        [sectionView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(sectionView.mas_right).offset(-CGFloatIn750(30));
            make.centerY.equalTo(sectionView.mas_centerY);
        }];
        
        return sectionView;
    });
    self.zChain_block_setHeightForHeaderInSection(^CGFloat(UITableView *tableView, NSInteger section) {
        return CGFloatIn750(90);
    });
    
    self.zChain_reload_ui();
}

@end

#pragma mark - RouteHandler
@interface ZStudentSignDetailListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentSignDetailListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_signDetailList;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentSignDetailListVC *routevc = [[ZStudentSignDetailListVC alloc] init];
    
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
