//
//  ZOrganizationPhotoManageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationPhotoManageVC.h"
#import "ZOrganizationPhotoListCell.h"
#import "ZOrganizationPhotoCollectionVC.h"
#import "ZOriganizationPhotoViewModel.h"

@interface ZOrganizationPhotoManageVC ()
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZOrganizationPhotoManageVC

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewGaryBack];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"相册管理"];
}

- (void)setDataSource {
    [super setDataSource];
    _param = @{}.mutableCopy;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    NSArray *stemparr = @[@"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcnimudx9rj30u0190x6r.jpg",
      @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcnik9gg1zj30rt167qv5.jpg",
      @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcnih592ymj30u012mkjl.jpg",
    @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcnifebkgxj30u011i41n.jpg",
    @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcni9yq6txj30in0skdh8.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcni67jfp0j30u01907wi.jpg",
    @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcni0ntc2oj30ia0rfgpz.jpg",
    @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcnhw86vyej30rs15ojti.jpg",
    @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcnhm4ar5rj30m90xc4mp.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcnhgm151mj30tm18gwrz.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcnhcwlaihj30u011in00.jpg",
    @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcnhbdlq2fj30hs0hsdin.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcnh64taa2j30u011iqfx.jpg",
    @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gcnh1f4yvfj30u0140dsy.jpg",
    @"http://tva1.sinaimg.cn/mw600/00831rSTly1gcngrcu9g5j30hs0m7ta9.jpg",
    ];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationPhotoListCell className] title:@"ZOrganizationPhotoListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationPhotoListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationPhotoListCell"]) {
        ZOriganizationPhotoListModel *model = (ZOriganizationPhotoListModel *)cellConfig.dataModel;
        ZOrganizationPhotoCollectionVC *lvc = [[ZOrganizationPhotoCollectionVC alloc] init];
        lvc.model = model;
        [self.navigationController pushViewController:lvc animated:YES];
    }
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self setPostCommonData];
    [self refreshHeadData:_param];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationPhotoViewModel getStoresImageList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationPhotoViewModel getStoresImageList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshAllData {
    self.loading = YES;
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [_param setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
}
@end
