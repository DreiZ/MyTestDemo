//
//  ZCircleDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailVC.h"
#import "ZCircleDetailHeaderView.h"
#import "ZCircleDetailBottomView.h"

#import "ZNoDataCell.h"
#import "ZCircleDetailUserCell.h"
#import "ZCircleDetailLabelCell.h"
#import "ZCircleDetailSchoolCell.h"
#import "ZCircleDetailEvaListCell.h"
#import "ZCircleDetailPhotoListCell.h"
#import "ZCircleDetailAddressCell.h"
#import "ZStudentMineSettingBottomCell.h"

#import "ZStudentCollectionViewModel.h"
#import "ZCircleDetailEvaSectionView.h"
#import "ZCircleMineViewModel.h"
#import "ZCircleMineModel.h"

#import <IQKeyboardManager.h>
#import "XHInputView.h"
#import "ZAlertView.h"
#import "SJVideoPlayer.h"

@interface ZCircleDetailVC ()<XHInputViewDelagete>
@property (nonatomic,strong) ZCircleDetailHeaderView *headerView;
@property (nonatomic,strong) ZCircleDetailBottomView *bottomView;
@property (nonatomic,strong) ZCircleDetailEvaSectionView *sectionView;

@property (nonatomic,strong) ZCircleDynamicInfo *infoModel;

@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) NSMutableArray *likeList;
@property (nonatomic,strong) NSMutableArray *evaList;
@property (nonatomic,assign) BOOL isLike;
@property (nonatomic,assign) BOOL isNoData;
@property (nonatomic,assign) BOOL isRemove;
@end

@implementation ZCircleDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[ZVideoPlayerManager sharedInstance].player vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[ZVideoPlayerManager sharedInstance].player vc_viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[ZVideoPlayerManager sharedInstance].player vc_viewDidDisappear];
    [ZVideoPlayerManager sharedInstance].player = nil;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    self.zChain_addEmptyDataDelegate()
    .zChain_addLoadMoreFooter()
    .zChain_updateDataSource(^{
        self.param = @{}.mutableCopy;
        self.likeList = @[].mutableCopy;
        self.evaList = @[].mutableCopy;
        self.isLike = NO;
    }).zChain_resetMainView(^{
        self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        self.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        self.iTableView.layer.cornerRadius = CGFloatIn750(16);
        
        [self.view addSubview:self.headerView];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(90) + safeAreaTop());
        }];
        
        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(90) + safeAreaBottom());
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
            make.top.equalTo(self.headerView.mas_bottom).offset(CGFloatIn750(20));
            make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(20));
        }];
        
    }).zChain_block_setRefreshHeaderNet(^{
        [weakSelf refreshData];
    }).zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMoreData];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        if (weakSelf.isRemove) {
            weakSelf.emptyDataStr = @"动态已被移除";
            weakSelf.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
            [weakSelf.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(weakSelf.view);
                make.top.equalTo(weakSelf.view.mas_bottom);
                make.height.mas_equalTo(CGFloatIn750(90) + safeAreaBottom());
            }];

            [weakSelf.headerView setRightHidden];
            return;
        }

        NSMutableArray *section1Arr = @[].mutableCopy;
        {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailUserCell className] title:@"ZCircleDetailUserCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleDetailUserCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:weakSelf.infoModel];
            [section1Arr addObject:menuCellConfig];
        }

        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_cellHeight(CGFloatIn750(40))
            .zz_lineHidden(YES)
            .zz_titleLeft(SafeStr(weakSelf.infoModel.title))
            .zz_leftMultiLine(YES)
            .zz_fontLeft([UIFont boldFontTitle])
            .zz_spaceLine(CGFloatIn750(8))
            .zz_cellWidth(KScreenWidth - CGFloatIn750(60));

            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [section1Arr addObject:menuCellConfig];
        }
        {
            NSMutableArray *photos = @[].mutableCopy;
            for (int i = 0; i < weakSelf.infoModel.video.count; i++) {
                ZFileUploadDataModel *dataModel = [[ZFileUploadDataModel alloc] init];
                dataModel.taskType = ZUploadTypeVideo;
                dataModel.image_url = weakSelf.infoModel.cover.url;
                dataModel.taskState = ZUploadStateWaiting;
                [photos addObject:dataModel];
            }
            for (int i = 0; i < weakSelf.infoModel.image.count; i++) {
                ZFileUploadDataModel *dataModel = [[ZFileUploadDataModel alloc] init];
                dataModel.taskType = ZUploadTypeImage;
                dataModel.image_url = weakSelf.infoModel.image[i];
                dataModel.taskState = ZUploadStateWaiting;
                [photos addObject:dataModel];
            }

            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailPhotoListCell className] title:@"ZCircleDetailPhotoListCell" showInfoMethod:@selector(setImageList:) heightOfCell:[ZCircleDetailPhotoListCell z_getCellHeight:photos] cellType:ZCellTypeClass dataModel:photos];
            [section1Arr addObject:menuCellConfig];

            if (ValidStr(weakSelf.infoModel.address)) {
                ZCellConfig *addressCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailAddressCell className] title:@"ZCircleDetailAddressCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleDetailAddressCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:weakSelf.infoModel];
                [section1Arr addObject:addressCellConfig];
            }
        }
        if(ValidStr(weakSelf.infoModel.content)){
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"info")
            .zz_cellHeight(CGFloatIn750(42))
            .zz_lineHidden(YES)
            .zz_titleLeft(weakSelf.infoModel.content)
            .zz_leftMultiLine(YES)
            .zz_fontLeft([UIFont fontContent])
            .zz_spaceLine(CGFloatIn750(16))
            .zz_cellWidth(KScreenWidth - CGFloatIn750(60));

            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [section1Arr addObject:menuCellConfig];
        }
        if (ValidArray(weakSelf.infoModel.tags)) {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailLabelCell className] title:@"label" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleDetailLabelCell z_getCellHeight:weakSelf.infoModel.tags] cellType:ZCellTypeClass dataModel:weakSelf.infoModel.tags];
            [section1Arr addObject:menuCellConfig];
        }
        {
            if (ValidStr(weakSelf.infoModel.store_id) && ValidStr(weakSelf.infoModel.store_name)) {
                [section1Arr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailSchoolCell className] title:@"school" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleDetailSchoolCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:weakSelf.infoModel];
                [section1Arr addObject:menuCellConfig];
            }else{
                [section1Arr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
            }
        }
        [section1Arr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
        [weakSelf.cellConfigArr addObject:section1Arr];
        {
            NSMutableArray *section2Arr = @[].mutableCopy;
            if (weakSelf.isLike) {
                if (ValidArray(weakSelf.likeList)) {
                    for (int i = 0; i < weakSelf.likeList.count; i++) {
                        ZCircleMinePersonModel *smodel = weakSelf.likeList[i];

                        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"user").zz_titleLeft(smodel.nick_name)
                        .zz_imageLeft(smodel.image)
                        .zz_cellHeight(CGFloatIn750(90))
                        .zz_imageLeftRadius(YES)
                        .zz_imageLeftHeight(CGFloatIn750(54))
                        .zz_marginLineLeft(CGFloatIn750(74))
                        .zz_marginLineRight(CGFloatIn750(20))
                        .zz_cellWidth(KScreenWidth - CGFloatIn750(60))
                        .zz_setData(smodel);

                        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                        [section2Arr addObject:menuCellConfig];
                    }
                    if (weakSelf.isNoData) {
                        ZCellConfig *noEvaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"nodata" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(60) cellType:ZCellTypeClass dataModel:@"没有更多内容了~"];
                        [section2Arr addObject:noEvaCellConfig];
//                        [section2Arr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
                    }
                }else{
                    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZNoDataCell className] title:@"noLike" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(460) cellType:ZCellTypeClass dataModel:@"暂无喜欢"];
                    [section2Arr addObject:menuCellConfig];
                }
            }else{
                if (ValidArray(weakSelf.evaList)) {
                    for (int i = 0; i < weakSelf.evaList.count; i++) {
                        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailEvaListCell className] title:@"ZCircleDetailEvaListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleDetailEvaListCell z_getCellHeight:weakSelf.evaList[i]] cellType:ZCellTypeClass dataModel:weakSelf.evaList[i]];
                       [section2Arr addObject:menuCellConfig];
                    }
                    if (weakSelf.isNoData) {
                        ZCellConfig *noEvaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"nodata" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(60) cellType:ZCellTypeClass dataModel:@"没有更多内容了~"];
                        [section2Arr addObject:noEvaCellConfig];
//                        [section2Arr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
                    }
                }else{
                    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZNoDataCell className] title:@"noLike" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(460) cellType:ZCellTypeClass dataModel:@"暂无评价"];
                    [section2Arr addObject:menuCellConfig];
                }
            }
            [weakSelf.cellConfigArr addObject:section2Arr];
        }
    }).zChain_block_setViewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
        if (section == 1) {
            weakSelf.sectionView.isLike = weakSelf.isLike;
            [weakSelf.sectionView setLikeNum:weakSelf.infoModel.enjoy evaNum:weakSelf.infoModel.comment_number];
            return weakSelf.sectionView;
        }else {
            return nil;
        }
    }).zChain_block_setHeightForHeaderInSection(^CGFloat(UITableView *tableView, NSInteger section) {
        if (section == 1) {
            return CGFloatIn750(80);
        }
        return 0;
    }).zChain_block_setNumberOfSectionsInTableView(^NSInteger(UITableView *tableView) {
        return weakSelf.cellConfigArr.count;
    }).zChain_block_setNumberOfRowsInSection(^NSInteger(UITableView *tableView, NSInteger section) {
        NSArray *sectionArr = weakSelf.cellConfigArr[section];
        return sectionArr.count;
    }).zChain_block_setCellForRowAtIndexPath(^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        NSArray *sectionArr = weakSelf.cellConfigArr[indexPath.section];
        ZCellConfig *cellConfig = [sectionArr objectAtIndex:indexPath.row];
           ZBaseCell *cell;
        cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
        if ([cellConfig.title isEqualToString:@"nodata"]) {
            ZStudentMineSettingBottomCell *lcell = (ZStudentMineSettingBottomCell *)cell;
            lcell.titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
            lcell.titleLabel.font = [UIFont fontSmall];
        }else if([cellConfig.title isEqualToString:@"ZCircleDetailUserCell"]){
            ZCircleDetailUserCell *lcell = (ZCircleDetailUserCell *)cell;
            lcell.handleBlock = ^(NSInteger index) {
                if (index == 1) {
                    [[ZUserHelper sharedHelper] checkLogin:^{
                        if ([weakSelf.infoModel.follow_status intValue] == 1) {
                            [weakSelf followAccount:weakSelf.infoModel.account];
                        }else{
                            [weakSelf cancleFollowAccount:weakSelf.infoModel.account];
                        }
                    }];
                }else{
                    routePushVC(ZRoute_circle_mine, weakSelf.infoModel.account, nil);
                }
            };
        }else if([cellConfig.title isEqualToString:@"ZCircleDetailPhotoListCell"]){
            ZCircleDetailPhotoListCell *lcell = (ZCircleDetailPhotoListCell *)cell;
            lcell.seeBlock = ^(NSInteger index) {

            };
            lcell.handleBlock = ^(ZBaseCell * cell, UICollectionView * iCollectionView, NSIndexPath *indexPath, ZFileUploadDataModel* model) {
                if (isVideo(model.image_url)) {
                    [weakSelf cell:cell coverItemWasTappedInCollectionView:iCollectionView atIndexPath:indexPath model:model];
                }else{
                    NSMutableArray *photos = @[].mutableCopy;
                    for (int i = 0; i < weakSelf.infoModel.video.count; i++) {
                        [photos addObject:weakSelf.infoModel.video[i]];
                    }
                    for (int i = 0; i < weakSelf.infoModel.image.count; i++) {
                        [photos addObject:weakSelf.infoModel.image[i]];
                    }
                    if (indexPath.row < photos.count) {
                        [[ZImagePickerManager sharedManager] showBrowser:photos withIndex:indexPath.row];
                    }
                }
            };
        }else if([cellConfig.title isEqualToString:@"school"]){
            ZCircleDetailSchoolCell *lcell = (ZCircleDetailSchoolCell *)cell;
            lcell.handleBlock = ^(NSInteger index) {
                if (index == 0) {
                    ZStoresListModel *lmodel = [[ZStoresListModel alloc] init];
                    lmodel.stores_id = weakSelf.infoModel.store_id;
                    lmodel.name = weakSelf.infoModel.store_name;
                    
                    routePushVC(ZRoute_main_organizationDetail, lmodel, nil);
                }else{
                    [[ZUserHelper sharedHelper] checkLogin:^{
                        if ([weakSelf.infoModel.store_collection intValue] == 1) {
                            [weakSelf collectionStore:NO];
                        }else{
                            [weakSelf collectionStore:YES];
                        }
                    }];
                }
            };
        }else if([cellConfig.title isEqualToString:@"ZCircleDetailEvaListCell"]){
            ZCircleDetailEvaListCell *lcell = (ZCircleDetailEvaListCell *)cell;
            lcell.userBlock = ^(ZCircleDynamicEvaModel *model) {
                routePushVC(ZRoute_circle_mine, model.account, nil);
            };

            lcell.delBlock = ^(ZCircleDynamicEvaModel *model) {
                [weakSelf delEvaDynamic:model];
            };
        }

        return cell;
    }).zChain_block_setHeightForRowAtIndexPath(^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        NSArray *sectionArr = weakSelf.cellConfigArr[indexPath.section];
        ZCellConfig *cellConfig = sectionArr[indexPath.row];
        CGFloat cellHeight =  cellConfig.heightOfCell;
        return cellHeight;
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
         if([cellConfig.title isEqualToString:@"user"]){
            ZLineCellModel *cellModel = (ZLineCellModel *)cellConfig.dataModel;
            ZCircleMinePersonModel *smodel = cellModel.data;

            routePushVC(ZRoute_circle_mine, smodel.account, nil);
        }
    });
    
    // KVO
    [RACObserve(self, self.infoModel.title) subscribeNext:^(NSString *enjoy) {
        DLog(@"title------change");
        // 用户名发生了变化
        weakSelf.headerView.title = weakSelf.infoModel.title;
    }];
    
    [[[RACSignal combineLatest:@[RACObserve(self, self.infoModel.enjoy), RACObserve(self, self.infoModel.enjoy_status), RACObserve(self, self.infoModel.comment_number)]
    reduce:^(NSString *enjoy, NSString *enjoy_status, NSString *comment_number) {
        NSString *subTitle = [NSString stringWithFormat:@"%@%@%@",SafeStr(enjoy),SafeStr(enjoy_status),SafeStr(comment_number)];
        return subTitle;
    }] distinctUntilChanged]
    subscribeNext:^(NSString *valid) {
        weakSelf.bottomView.model = weakSelf.infoModel;
        [weakSelf.sectionView setLikeNum:weakSelf.infoModel.enjoy evaNum:weakSelf.infoModel.comment_number];
    }];
    
    self.zChain_reload_ui();
    self.zChain_reload_Net();
    [self getDetailInfo];
}

#pragma mark - lazy loading
- (ZCircleDetailHeaderView *)headerView {
    if (!_headerView) {
        __weak typeof(self) weakSelf = self;
        _headerView = [[ZCircleDetailHeaderView alloc] init];
        _headerView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [[ZUserHelper sharedHelper] checkLogin:^{
                    routePushVC(ZRoute_main_report, @{@"sTitle":SafeStr(weakSelf.infoModel.title),@"dynamic":SafeStr(weakSelf.infoModel.dynamic)}, nil);
                }];
            }
        };
        _headerView.title = @"详情";
    }
    
    return _headerView;
}

- (ZCircleDetailBottomView *)bottomView {
    if (!_bottomView) {
        __weak typeof(self) weakSelf = self;
        _bottomView = [[ZCircleDetailBottomView alloc] init];
        _bottomView.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                [[ZUserHelper sharedHelper] checkLogin:^{
                    [weakSelf showXHInputViewWithStyle:InputViewStyleLarge];
                }];
            }else if(index == 1){
                weakSelf.isNoData = NO;
                weakSelf.isLike = NO;
                weakSelf.sectionView.isLike = NO;
                [weakSelf refreshData];
            }else if(index == 2){
                [weakSelf enjoyDynamic];
            }
        };
    }
    return _bottomView;
}

- (ZCircleDetailEvaSectionView *)sectionView {
    if (!_sectionView) {
        __weak typeof(self) weakSelf = self;
        _sectionView = [[ZCircleDetailEvaSectionView alloc] init];
        _sectionView.handleBlock = ^(NSInteger index) {
            weakSelf.isNoData = NO;
            if (index == 0) {
                weakSelf.isLike = YES;
            }else{
                weakSelf.isLike = NO;
            }
            weakSelf.sectionView.isLike = weakSelf.isLike;
            [weakSelf refreshData];
        };
    }
    return _sectionView;
}

#pragma mark - 视频播放
- (void)cell:(ZBaseCell *)cell coverItemWasTappedInCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath model:(ZFileUploadDataModel *)model{
    
    // 视图层次第一层
    SJPlayModel *playModel = [SJPlayModel playModelWithCollectionView:collectionView indexPath:indexPath];
    // 视图层次第二层
    // 通过`nextPlayModel`把它们链起来. 有多少层, 就链多少层
    playModel.nextPlayModel = [SJPlayModel playModelWithTableView:self.iTableView indexPath:[self.iTableView indexPathForCell:cell]];
    
    // 进行播放
    [ZVideoPlayerManager sharedInstance].player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:model.image_url] playModel:playModel];
}

#pragma mark - 输入框
-(void)showXHInputViewWithStyle:(InputViewStyle)style{
    [XHInputView showWithStyle:style configurationBlock:^(XHInputView *inputView) {
        inputView.delegate = self;
        inputView.font = [UIFont fontContent];
        inputView.placeholderColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        inputView.sendButtonBackgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        inputView.sendButtonFont = [UIFont fontTitle];
        inputView.sendButtonTitle = @"发布";
        inputView.placeholder = @"留下您的精彩评论吧";
        if (self.infoModel) {
            inputView.placeholder = [NSString stringWithFormat:@"评论：%@",self.infoModel.title];
        }
        inputView.maxCount = 300;
        inputView.textViewBackgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    } sendBlock:^BOOL(NSString *text) {
        if(text.length){
            DLog(@"输入的信息为:%@",text);
            [self evaDynamic:text];
            return YES;//return YES,收起键盘
        }else{
            DLog(@"显示提示框-请输入要评论的的内容");
            [TLUIUtility showInfoHint:@"请输入要评论的的内容"];
            return NO;//return NO,不收键盘
        }
    }];
}

#pragma mark - XHInputViewDelagete
/** XHInputView 将要显示 */
-(void)xhInputViewWillShow:(XHInputView *)inputView{
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].enable = NO;
}

/** XHInputView 将要影藏 */
-(void)xhInputViewWillHide:(XHInputView *)inputView{
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].enable = YES;
}

#pragma mark - 网络请求
- (void)getDetailInfo {
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel getCircleDynamicInfo:@{@"dynamic":self.dynamic} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && [data isKindOfClass:[ZCircleDynamicInfo class]]) {
            weakSelf.isRemove = NO;
            weakSelf.infoModel = data;
            weakSelf.zChain_reload_ui();
        }else{
            if ([data isKindOfClass:[NSString class]] && [data isEqualToString:@"动态已被移除"]) {
                weakSelf.isRemove = YES;
                weakSelf.zChain_reload_ui();
            }
        }
    }];
}

- (void)followAccount:(NSString *)account {
    [TLUIUtility showLoading:nil];
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel followUser:@{@"follow":SafeStr(account)} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            weakSelf.infoModel.follow_status = data;
            weakSelf.zChain_reload_ui();
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
            weakSelf.infoModel.follow_status = data;
            weakSelf.zChain_reload_ui();
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}

- (void)collectionStore:(BOOL)isCollection {
    [TLUIUtility showLoading:@""];
    __weak typeof(self) weakSelf = self;
    [ZStudentCollectionViewModel collectionStore:@{@"store":SafeStr(self.infoModel.store_id),@"type":isCollection ? @"1":@"2"} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            if (isCollection) {
                weakSelf.infoModel.store_collection = @"1";
            }else{
                weakSelf.infoModel.store_collection = @"0";
            }
            weakSelf.zChain_reload_ui();
            [TLUIUtility showSuccessHint:data];
        }else{
            [TLUIUtility showInfoHint:data];
        }
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
    if (self.isLike) {
        [ZCircleMineViewModel getDynamicLikeList:param completeBlock:^(BOOL isSuccess, ZCircleMinePersonNetModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                [weakSelf.likeList removeAllObjects];
                [weakSelf.likeList addObjectsFromArray:data.list];
                
                if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                    weakSelf.isNoData = YES;
                }else{
                    weakSelf.isNoData = NO;
                }
                weakSelf.zChain_reload_ui();
                
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
    }else{
        [ZCircleMineViewModel getEvaList:param completeBlock:^(BOOL isSuccess, ZCircleMinePersonNetModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                [weakSelf.evaList removeAllObjects];
                [weakSelf.evaList addObjectsFromArray:data.list];
                
                if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                    weakSelf.isNoData = YES;
                }else{
                    weakSelf.isNoData = NO;
                }
                weakSelf.zChain_reload_ui();
                
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
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    if (self.isLike) {
        [ZCircleMineViewModel getDynamicLikeList:self.param completeBlock:^(BOOL isSuccess, ZCircleMinePersonNetModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                [weakSelf.likeList addObjectsFromArray:data.list];
                
                if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                    weakSelf.isNoData = YES;
                }else{
                    weakSelf.isNoData = NO;
                }
                weakSelf.zChain_reload_ui();
                
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
    }else{
        [ZCircleMineViewModel getEvaList:self.param completeBlock:^(BOOL isSuccess, ZCircleMinePersonNetModel *data) {
            weakSelf.loading = NO;
            if (isSuccess && data) {
                [weakSelf.evaList addObjectsFromArray:data.list];
                
                if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                    weakSelf.isNoData = YES;
                }else{
                    weakSelf.isNoData = NO;
                }
                weakSelf.zChain_reload_ui();
                
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
}

- (void)refreshAllData {
    self.loading = YES;
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.param setObject:@"10" forKey:@"page_size"];
    [self.param setObject:self.dynamic forKey:@"dynamic"];
}

- (void)enjoyDynamic{
    __weak typeof(self) weakSelf = self;
    if ([self.infoModel.enjoy_status intValue] > 0) {
        [ZCircleMineViewModel cancleEnjoyDynamic:@{@"dynamic":SafeStr(self.dynamic)} completeBlock:^(BOOL isSuccess, id data) {
            if (isSuccess) {
                weakSelf.infoModel.enjoy_status = @"0";
                NSInteger enjoyCount = [weakSelf.infoModel.enjoy intValue]-1;
                if (enjoyCount < 0) {
                    enjoyCount = 0;
                }
                weakSelf.infoModel.enjoy = [NSString stringWithFormat:@"%ld",(long)enjoyCount];
                [weakSelf refreshData];
            }else{
                [TLUIUtility showInfoHint:data];
            }
        }];
    }else{
        [ZCircleMineViewModel enjoyDynamic:@{@"dynamic":SafeStr(self.dynamic)} completeBlock:^(BOOL isSuccess, id data) {
            if (isSuccess) {
                weakSelf.infoModel.enjoy_status = @"1";
                weakSelf.infoModel.enjoy = [NSString stringWithFormat:@"%d",[weakSelf.infoModel.enjoy intValue]+1];
                if (self.isLike) {
                    [weakSelf refreshData];
                }
            }else{
                [TLUIUtility showInfoHint:data];
            }
        }];
    }
}

- (void)evaDynamic:(NSString *)text {
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel evaDynamic:@{@"dynamic":SafeStr(self.dynamic),@"content":SafeStr(text)} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            weakSelf.infoModel.comment_number = [NSString stringWithFormat:@"%d",[weakSelf.infoModel.comment_number intValue]+1];
            if (!weakSelf.isLike) {
                weakSelf.zChain_reload_Net();
            }
        }else{
            [TLUIUtility showInfoHint:data];
        }
    }];
}

- (void)delEvaDynamic:(ZCircleDynamicEvaModel *)model {
    [ZAlertView setAlertWithTitle:@"提示" subTitle:@"确定删除此评论？" leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
        if (index == 1) {
            __weak typeof(self) weakSelf = self;
            [ZCircleMineViewModel delEvaDynamic:@{@"dynamic":SafeStr(self.dynamic),@"id":SafeStr(model.eva_id)} completeBlock:^(BOOL isSuccess, id data) {
                if (isSuccess) {
                    [TLUIUtility showSuccessHint:data];
                    for (int i = 0; i < weakSelf.evaList.count; i++) {
                        ZCircleDynamicEvaModel *smodel = weakSelf.evaList[i];
                        if ([model.eva_id isEqualToString:smodel.eva_id]) {
                            [weakSelf.evaList removeObject:smodel];
                            break;
                        }
                    }
                    
                    weakSelf.infoModel.comment_number = [NSString stringWithFormat:@"%d",[weakSelf.infoModel.comment_number intValue]-1];
                    if ([weakSelf.infoModel.comment_number intValue] < 0) {
                        weakSelf.infoModel.comment_number = @"0";
                    }
                    if (!weakSelf.isLike) {
                        weakSelf.zChain_reload_Net();
                    }
                }else{
                    [TLUIUtility showInfoHint:data];
                }
            }];
        }
    }];
}

@end

#pragma mark - RouteHandler
@interface ZCircleDetailVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZCircleDetailVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_circle_detial;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZCircleDetailVC *dvc = [[ZCircleDetailVC alloc] init];
    if (request.prts) {
        dvc.dynamic = request.prts;
    }
    [topViewController.navigationController pushViewController:dvc animated:YES];
    if (completionHandler) {
        completionHandler(@"ZCircleDetailVC",nil);
    }
}
@end
