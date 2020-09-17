//
//  ZCircleMineCollectionVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineCollectionVC.h"

#import "ZCircleMineDynamicCollectionCell.h"
//#import "ZCircleMineDynamicCollectionListCell.h"
#import "ZNoDataCollectionViewCell.h"

#import "ZCircleMineHeaderView.h"
#import "ZCircleMineSectionView.h"
#import "ZJWaterLayout.h"
#import "ZCircleMineCollectionViewFlowLayout.h"
#import "ZCircleMineViewModel.h"
#import "ZCircleMineModel.h"

#import "ZBaseUnitModel.h"
#import "ZAlertView.h"

@interface ZCircleMineCollectionVC ()
@property (nonatomic,strong) ZCircleMineHeaderView *headView;
@property (nonatomic,strong) ZCircleMineSectionView *sectionView;
@property (nonatomic,assign) BOOL isLike;
@property (nonatomic,strong) ZCircleMineModel *mineModel;
@property (nonatomic,assign) CGFloat headHeight;
@property (nonatomic,strong) UIButton *navRightBtn;

@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZCircleMineCollectionVC

- (void)viewWillAppear:(BOOL)animated {
    self.zChain_block_setNotShouldDecompressImages(^{

    });
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getMineInfo];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.loading = YES;
    self.headHeight = CGFloatIn750(292);
    [self setCollectionViewEmptyDataDelegate];
    [self initCellConfigArr];
    [self.iCollectionView reloadData];
    
    [self setCollectionViewRefreshFooter];
    [self setCollectionViewRefreshHeader];
//    [self setCollectionViewEmptyDataDelegate];
    
    if (self.account && ([self.account isEqualToString:[ZUserHelper sharedHelper].user.userCodeID])) {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
    }
    
    // KVO
    [[[RACSignal combineLatest:@[RACObserve(self, self.mineModel.dynamic), RACObserve(self, self.mineModel.enjoy)]
    reduce:^(NSString *dynamic, NSString *enjoy) {
        NSString *subTitle = [NSString stringWithFormat:@"%@%@",SafeStr(enjoy),SafeStr(dynamic)];
        return subTitle;
    }] distinctUntilChanged]
    subscribeNext:^(NSString *valid) {
        DLog(@"subscribeNext change");
        [self.sectionView setDynamic:self.mineModel.dynamic like:self.mineModel.enjoy];
    }];
    
    // KVO
    [[[RACSignal combineLatest:@[RACObserve(self, self.mineModel.autograph), RACObserve(self, self.mineModel.follow), RACObserve(self, self.mineModel.follow_status), RACObserve(self, self.mineModel.fans), RACObserve(self, self.mineModel.dynamic)]
    reduce:^(NSString *autograph, NSString *follow, NSString *follow_status, NSString *fans, NSString *dynamic) {
        NSString *subTitle = [NSString stringWithFormat:@"%@%@%@%@%@",SafeStr(autograph),SafeStr(follow),SafeStr(follow_status),SafeStr(fans),SafeStr(dynamic)];
        return subTitle;
    }] distinctUntilChanged]
    subscribeNext:^(NSString *valid) {
        DLog(@"subscribeNext change");
        self.headView.model = self.mineModel;
    }];
}


- (void)setDataSource {
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    [super setDataSource];
    
    self.param = @{}.mutableCopy;
    self.headHeight = CGFloatIn750(292);
    self.edgeInsets = UIEdgeInsetsMake(CGFloatIn750(40), CGFloatIn750(30), CGFloatIn750(40), CGFloatIn750(30));
    self.minimumLineSpacing = CGFloatIn750(4);
    self.minimumInteritemSpacing = CGFloatIn750(4);
    self.iCollectionView.scrollEnabled = YES;
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"个人中心"];
}

- (void)setupMainView {
    [super setupMainView];
    self.iCollectionView.delegate = self;
    
    ZCircleMineCollectionViewFlowLayout *flowLayout = [[ZCircleMineCollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(KScreenWidth, CGFloatIn750(80));
    
    //设置headerView大小
    [self.iCollectionView registerClass:[ZCircleMineSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZCircleMineSectionView"];  //  一定要设置
    [self.iCollectionView setCollectionViewLayout:flowLayout];
    [self.iCollectionView addSubview:self.headView];
    self.headView.frame = CGRectMake(0, -self.headHeight, KScreenWidth, self.headHeight);
    self.iCollectionView.contentInset = UIEdgeInsetsMake(self.headHeight, 0, 0, 0);
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    [self.cellConfigArr removeAllObjects];
    if (ValidArray(self.dataSources)) {
        [self.dataSources enumerateObjectsUsingBlock:^(ZCircleMineDynamicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCollectionCell className] title:[ZCircleMineDynamicCollectionCell className] showInfoMethod:@selector(setModel:) sizeOfCell:CGSizeMake((KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3-0.5, (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3 *(160.0f)/(142.0)) cellType:ZCellTypeClass dataModel:obj];
            
            
            [self.cellConfigArr addObject:cellConfig];
        }];
    }else{
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZNoDataCollectionViewCell className] title:[ZNoDataCollectionViewCell className] showInfoMethod:@selector(setTitle:) sizeOfCell:CGSizeMake((KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))-0.5, (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10)) *(160.0f)/(142.0)) cellType:ZCellTypeClass dataModel:@"暂无动态"];
        
        
        [self.cellConfigArr addObject:cellConfig];
    }
}

#pragma mark - lazy loading view
- (ZCircleMineHeaderView *)headView {
    if (!_headView) {
        __weak typeof(self) weakSelf = self;
        _headView = [[ZCircleMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, self.headHeight)];
        _headView.handleBlock = ^(NSInteger index) {
            DLog(@"----%ld", (long)index);
            if (index == 0) {
                
            }else if(index == 1){
                if (weakSelf.account) {
                    routePushVC(ZRoute_circle_myFocus, @{@"id":SafeStr(weakSelf.account)}, nil);
                }else{
                    routePushVC(ZRoute_circle_myFocus, @{@"id":SafeStr([ZUserHelper sharedHelper].user.userCodeID)}, nil);
                }
            }else if(index == 2){
                if (weakSelf.account) {
                    routePushVC(ZRoute_circle_myFans, @{@"id":SafeStr(weakSelf.account)}, nil);
                }else{
                    routePushVC(ZRoute_circle_myFans, @{@"id":SafeStr([ZUserHelper sharedHelper].user.userCodeID)}, nil);
                }
            }else if(index == 4){
                //签名
                ZBaseTextVCModel *edit = [[ZBaseTextVCModel alloc] init];
                edit.navTitle = @"设置个性签名";
                edit.formatter = ZFormatterTypeAnyByte;
                edit.max = 90;
                edit.hitStr = @"签名只可有汉字字母数字下划线组成，90字节以内";
                edit.showHitStr = @"你还没有输入任何签名";
                edit.placeholder = @"请输入签名";
                edit.text = [weakSelf.mineModel.autograph isEqualToString:@"您还没有填写签名"]?@"":weakSelf.mineModel.autograph;
                
                routePushVC(ZRoute_mine_textEditVC, edit, ^(NSString *text, NSError * _Nullable error) {
                    weakSelf.mineModel.autograph = SafeStr(text);
                    [weakSelf updateUserInfo:SafeStr(text)];
                });
            }else if(index == 5){
                //关注
                if ([self.mineModel.follow_status intValue] == 1) {
                    [weakSelf followAccount:weakSelf.mineModel.account];
                }else{
                    [weakSelf cancleFollowAccount:weakSelf.mineModel.account];
                }
            }
        };
    }
    return _headView;
}


- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navRightBtn setTitle:@"上传列表" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        _navRightBtn.titleLabel.font = [UIFont fontSmall];
        [_navRightBtn bk_addEventHandler:^(id sender) {
            routePushVC(ZRoute_circle_releaseUpload, nil, nil);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navRightBtn;
}
//
//- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//    [headerView addSubview:self.headView];
//    return headerView;
//}

- (void)zz_collectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZCircleMineDynamicCollectionCell"]) {
        ZCircleMineDynamicCollectionCell *lcell = (ZCircleMineDynamicCollectionCell *)cell;
        lcell.handleBlock = ^(ZCircleMineDynamicModel *model) {
            if (!weakSelf.isLike) {
                if (!weakSelf.account || [weakSelf.account isEqualToString:[ZUserHelper sharedHelper].user.userCodeID]) {
                    [ZAlertView setAlertWithTitle:@"提示" subTitle:@"删除此动态？" leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
                        if (index == 1) {
                            [weakSelf removeDynamic:model.dynamic];
                        }
                    }];
                }
            }
        };
    }
}

-(void)zz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZCircleMineDynamicCollectionCell"]) {
        ZCircleMineDynamicModel *model = cellConfig.dataModel;
        if ([model.remove intValue] == 1) {
            if ([[ZUserHelper sharedHelper].user.userCodeID isEqualToString:self.mineModel.account]) {
                [ZAlertView setAlertWithTitle:@"小提醒" subTitle:@"动态已被删除，是否取消喜欢？" leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
                    if (index == 1) {
                        [self cancleEnjoyDynamic:model];
                    }
                }];
            }else{
                [ZAlertView setAlertWithTitle:@"小提醒" subTitle:@"动态已被删除" btnTitle:@"确定" handlerBlock:^(NSInteger index) {
                    
                }];
            }
        }else{
            routePushVC(ZRoute_circle_detial, @{@"id":SafeStr(model.dynamic)}, nil);
        }
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        ZCircleMineSectionView *sectionView = nil;
        __weak typeof(self) weakSelf = self;
        if (sectionView==nil) {
            sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZCircleMineSectionView" forIndexPath:indexPath];
            sectionView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
            sectionView.frame = CGRectMake(0, 0, KScreenWidth, CGFloatIn750(80));
            sectionView.handleBlock = ^(NSInteger index) {
                if (index == 0) {
                    weakSelf.isLike = NO;
                }else{
                    weakSelf.isLike = YES;
                }
                [weakSelf refreshData];
            };
            [sectionView setDynamic:self.mineModel.dynamic like:self.mineModel.enjoy];
            self.sectionView = sectionView;
        }
        return sectionView;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0 &&  scrollView.contentOffset.y > -self.headHeight) {
        self.iCollectionView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else if (scrollView.contentOffset.y >= 0) {
        self.iCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        self.iCollectionView.contentInset = UIEdgeInsetsMake(self.headHeight, 0, 0, 0);
    }
}

- (void)setHeadViewHeight {
    if (ValidStr(self.mineModel.autograph)) {
        CGSize tempSize = [self.mineModel.autograph tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(60), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        self.headHeight = tempSize.height + CGFloatIn750(292);
    }else if(self.mineModel.isMine){
        self.headHeight = CGFloatIn750(318);
    }
    
    self.headView.frame = CGRectMake(0, -self.headHeight, KScreenWidth, self.headHeight);
    self.iCollectionView.contentInset = UIEdgeInsetsMake(self.headHeight, 0, 0, 0);
}

#pragma mark - 获取数据
- (void)getMineInfo {
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel getCircleMineData:@{@"account":self.account?self.account:[ZUserHelper sharedHelper].user.userCodeID} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && [data isKindOfClass:[ZCircleMineModel class]]) {
            if (!weakSelf.account || ([weakSelf.account isEqualToString:[ZUserHelper sharedHelper].user.userCodeID])) {
                weakSelf.mineModel.isMine = YES;
            }
            weakSelf.mineModel = data;
            [weakSelf setHeadViewHeight];
            [weakSelf.navigationItem setTitle:weakSelf.mineModel.nick_name];
        }
    }];
}


- (void)updateUserInfo:(NSString *)text {
    [ZCircleMineViewModel updateUserAutograph:@{@"autograph":SafeStr(text)} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility showInfoHint:data];
    }];
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
    [ZCircleMineViewModel getDynamicsList:param isLike:self.isLike completeBlock:^(BOOL isSuccess, ZCircleMineDynamicNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
            [weakSelf initCellConfigArr];
            [weakSelf.iCollectionView reloadData];
            
            [weakSelf.iCollectionView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 12) {
                [weakSelf.iCollectionView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iCollectionView tt_endLoadMore];
            }
        }else{
            [weakSelf.iCollectionView reloadData];
            [weakSelf.iCollectionView tt_endRefreshing];
            [weakSelf.iCollectionView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel getDynamicsList:self.param isLike:self.isLike completeBlock:^(BOOL isSuccess, ZCircleMineDynamicNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iCollectionView reloadData];
            
            [weakSelf.iCollectionView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 12) {
                [weakSelf.iCollectionView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iCollectionView tt_endLoadMore];
            }
        }else{
            [weakSelf.iCollectionView reloadData];
            [weakSelf.iCollectionView tt_endRefreshing];
            [weakSelf.iCollectionView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshAllData {
    self.loading = YES;
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 12] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.param setObject:@"12" forKey:@"page_size"];
    [self.param setObject:self.account? self.account:[ZUserHelper sharedHelper].user.userCodeID forKey:@"account"];
}


- (void)followAccount:(NSString *)account {
    [TLUIUtility showLoading:nil];
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel followUser:@{@"follow":SafeStr(account)} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            weakSelf.mineModel.follow_status = data;
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}

- (void)cancleFollowAccount:(NSString *)account {
    [TLUIUtility showLoading:nil];
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel cancleFollowUser:@{@"follow":SafeStr(account)} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            weakSelf.mineModel.follow_status = data;
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}

- (void)removeDynamic:(NSString *)dynamic {
    [TLUIUtility showLoading:nil];
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel removeDynamic:@{@"dynamic":SafeStr(dynamic)} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
           [TLUIUtility showSuccessHint:data];
            if ([weakSelf.mineModel.dynamic intValue] > 0) {
                weakSelf.mineModel.dynamic = [NSString stringWithFormat:@"%d",[weakSelf.mineModel.dynamic intValue] - 1];
                
                [weakSelf.dataSources enumerateObjectsUsingBlock:^(ZCircleMineDynamicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.dynamic isEqualToString:dynamic]) {
                        [weakSelf.dataSources removeObjectAtIndex:idx];
                    }
                }];
                [weakSelf initCellConfigArr];
                [weakSelf.iCollectionView reloadData];
            }
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}

- (void)cancleEnjoyDynamic:(ZCircleMineDynamicModel *)model {
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel cancleEnjoyDynamic:@{@"dynamic":SafeStr(model.dynamic)} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess) {
            weakSelf.mineModel.enjoy = [NSString stringWithFormat:@"%d",[weakSelf.mineModel.enjoy intValue] - 1];
            
            [weakSelf.dataSources removeObject:model];
            [weakSelf initCellConfigArr];
            [weakSelf.iCollectionView reloadData];
        }else{
            [TLUIUtility showInfoHint:data];
        }
    }];
}
@end
#pragma mark - RouteHandler
@interface ZCircleMineCollectionVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZCircleMineCollectionVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_circle_mine;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZCircleMineCollectionVC *routevc = [[ZCircleMineCollectionVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]] && [request.prts objectForKey:@"id"]) {
        routevc.account = request.prts[@"id"];
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
