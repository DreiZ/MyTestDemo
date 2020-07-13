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

#import "ZOriganizationReportVC.h"
#import "ZCircleMineCollectionVC.h"
#import "ZStudentOrganizationDetailDesVC.h"

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
@end

@implementation ZCircleDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    self.zChain_updateDataSource(^{
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
        [self refreshData];
    }).zChain_block_setRefreshMoreNet(^{
        [self refreshMoreData];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        NSMutableArray *section1Arr = @[].mutableCopy;
        {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailUserCell className] title:@"ZCircleDetailUserCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleDetailUserCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.infoModel];
            [section1Arr addObject:menuCellConfig];
        }
        
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
            .zz_cellHeight(CGFloatIn750(40))
            .zz_lineHidden(YES)
            .zz_titleLeft(SafeStr(self.infoModel.title))
            .zz_leftMultiLine(YES)
            .zz_fontLeft([UIFont boldFontTitle])
            .zz_spaceLine(CGFloatIn750(8))
            .zz_cellWidth(KScreenWidth - CGFloatIn750(60));
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [section1Arr addObject:menuCellConfig];
        }
        {
            NSMutableArray *photos = @[].mutableCopy;
            for (int i = 0; i < self.infoModel.video.count; i++) {
                ZFileUploadDataModel *dataModel = [[ZFileUploadDataModel alloc] init];
                dataModel.taskType = ZUploadTypeVideo;
                dataModel.image_url = self.infoModel.cover.url;
                dataModel.taskState = ZUploadStateWaiting;
                [photos addObject:dataModel];
            }
            for (int i = 0; i < self.infoModel.image.count; i++) {
                ZFileUploadDataModel *dataModel = [[ZFileUploadDataModel alloc] init];
                dataModel.taskType = ZUploadTypeImage;
                dataModel.image_url = self.infoModel.image[i];
                dataModel.taskState = ZUploadStateWaiting;
                [photos addObject:dataModel];
            }
            
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailPhotoListCell className] title:@"ZCircleDetailPhotoListCell" showInfoMethod:@selector(setImageList:) heightOfCell:[ZCircleDetailPhotoListCell z_getCellHeight:photos] cellType:ZCellTypeClass dataModel:photos];
            [section1Arr addObject:menuCellConfig];
            
            if (ValidStr(self.infoModel.address)) {
                ZCellConfig *addressCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailAddressCell className] title:@"ZCircleDetailAddressCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleDetailAddressCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.infoModel];
                [section1Arr addObject:addressCellConfig];
            }
        }
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"info")
            .zz_cellHeight(CGFloatIn750(42))
            .zz_lineHidden(YES)
            .zz_titleLeft(self.infoModel.content)
            .zz_leftMultiLine(YES)
            .zz_fontLeft([UIFont fontContent])
            .zz_spaceLine(CGFloatIn750(16))
            .zz_cellWidth(KScreenWidth - CGFloatIn750(60));
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [section1Arr addObject:menuCellConfig];
        }
        if (ValidArray(self.infoModel.tags)) {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailLabelCell className] title:@"label" showInfoMethod:@selector(setList:) heightOfCell:[ZCircleDetailLabelCell z_getCellHeight:self.infoModel.tags] cellType:ZCellTypeClass dataModel:self.infoModel.tags];
            [section1Arr addObject:menuCellConfig];
        }
        {
            if (ValidStr(self.infoModel.store_id) && ValidStr(self.infoModel.store_name)) {
                [section1Arr addObject:getEmptyCellWithHeight(CGFloatIn750(30))];
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailSchoolCell className] title:@"school" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleDetailSchoolCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.infoModel];
                [section1Arr addObject:menuCellConfig];
            }
        }
        [section1Arr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
        [self.cellConfigArr addObject:section1Arr];
        {
            NSMutableArray *section2Arr = @[].mutableCopy;
            if (self.isLike) {
                if (ValidArray(self.likeList)) {
                    for (int i = 0; i < self.likeList.count; i++) {
                        ZCircleMinePersonModel *smodel = self.likeList[i];
                        
                        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"user").zz_titleLeft(smodel.nick_name)
                        .zz_imageLeft(smodel.image)
                        .zz_cellHeight(CGFloatIn750(90))
                        .zz_imageLeftRadius(YES)
                        .zz_imageLeftHeight(CGFloatIn750(54))
                        .zz_marginLineLeft(CGFloatIn750(74))
                        .zz_marginLineRight(CGFloatIn750(20))
                        .zz_cellWidth(KScreenWidth - CGFloatIn750(60));
                        
                        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                        [section2Arr addObject:menuCellConfig];
                    }
                    if (self.isNoData) {
                        ZCellConfig *noEvaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"nodata" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:@"没有更多内容了~"];
                        [section2Arr addObject:noEvaCellConfig];
                    }
                }else{
                    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZNoDataCell className] title:@"noLike" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(460) cellType:ZCellTypeClass dataModel:@"暂无喜欢"];
                    [section2Arr addObject:menuCellConfig];
                }
            }else{
                if (ValidArray(self.evaList)) {
                    for (int i = 0; i < self.evaList.count; i++) {
                        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailEvaListCell className] title:@"evaList" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleDetailEvaListCell z_getCellHeight:self.evaList[i]] cellType:ZCellTypeClass dataModel:self.evaList[i]];
                       [section2Arr addObject:menuCellConfig];
                    }
                    if (self.isNoData) {
                        ZCellConfig *noEvaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"nodata" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:@"没有更多内容了~"];
                        [section2Arr addObject:noEvaCellConfig];
                    }
                }else{
                    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZNoDataCell className] title:@"noLike" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(460) cellType:ZCellTypeClass dataModel:@"暂无评价"];
                    [section2Arr addObject:menuCellConfig];
                }
            }
            [self.cellConfigArr addObject:section2Arr];
        }
    }).zChain_block_setViewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
        if (section == 1) {
            self.sectionView.isLike = self.isLike;
            [self.sectionView setLikeNum:self.infoModel.enjoy evaNum:self.infoModel.comment_number];
            return self.sectionView;
        }else {
            return nil;
        }
    }).zChain_block_setHeightForHeaderInSection(^CGFloat(UITableView *tableView, NSInteger section) {
        if (section == 1) {
            return CGFloatIn750(80);
        }
        return 0;
    }).zChain_block_setNumberOfSectionsInTableView(^NSInteger(UITableView *tableView) {
        return self.cellConfigArr.count;
    }).zChain_block_setNumberOfRowsInSection(^NSInteger(UITableView *tableView, NSInteger section) {
        NSArray *sectionArr = self.cellConfigArr[section];
        return sectionArr.count;
    }).zChain_block_setCellForRowAtIndexPath(^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        NSArray *sectionArr = self.cellConfigArr[indexPath.section];
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
                    ZCircleMineCollectionVC *cvc = [[ZCircleMineCollectionVC alloc] init];
                    cvc.account = weakSelf.infoModel.account;
                    [weakSelf.navigationController pushViewController:cvc animated:YES];
                }
            };
        }else if([cellConfig.title isEqualToString:@"ZCircleDetailPhotoListCell"]){
            ZCircleDetailPhotoListCell *lcell = (ZCircleDetailPhotoListCell *)cell;
            lcell.seeBlock = ^(NSInteger index) {
                NSMutableArray *photos = @[].mutableCopy;
                for (int i = 0; i < self.infoModel.video.count; i++) {
                    [photos addObject:self.infoModel.video[i]];
                }
                for (int i = 0; i < self.infoModel.image.count; i++) {
                    [photos addObject:self.infoModel.image[i]];
                }
                if (index < photos.count) {
                    [[ZImagePickerManager sharedManager] showBrowser:photos withIndex:index];
                }
            };
        }else if([cellConfig.title isEqualToString:@"school"]){
            ZCircleDetailSchoolCell *lcell = (ZCircleDetailSchoolCell *)cell;
            lcell.handleBlock = ^(NSInteger index) {
                if (index == 0) {
                    ZStudentOrganizationDetailDesVC *dvc = [[ZStudentOrganizationDetailDesVC alloc] init];
                    ZStoresListModel *lmodel = [[ZStoresListModel alloc] init];
                    lmodel.stores_id = weakSelf.infoModel.store_id;
                    lmodel.name = weakSelf.infoModel.store_name;
                    dvc.listModel = lmodel;
                    [weakSelf.navigationController pushViewController:dvc animated:YES];
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
        }
        return cell;
    }).zChain_block_setHeightForRowAtIndexPath(^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        NSArray *sectionArr = self.cellConfigArr[indexPath.section];
        ZCellConfig *cellConfig = sectionArr[indexPath.row];
        CGFloat cellHeight =  cellConfig.heightOfCell;
        return cellHeight;
    });
    
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
                    ZOriganizationReportVC *rvc = [[ZOriganizationReportVC alloc] init];
    //                rvc.sTitle = self.detailModel.name;
    //                rvc.stores_id = self.detailModel.schoolID;
                    [weakSelf.navigationController pushViewController:rvc animated:rvc];
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
                [weakSelf showXHInputViewWithStyle:InputViewStyleLarge];
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
            weakSelf.infoModel = data;
            weakSelf.zChain_reload_ui();
            weakSelf.headerView.title = weakSelf.infoModel.title;
            weakSelf.bottomView.model = weakSelf.infoModel;
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
                weakSelf.bottomView.model = weakSelf.infoModel;
                
                [weakSelf.sectionView setLikeNum:weakSelf.infoModel.enjoy evaNum:weakSelf.infoModel.comment_number];
                [weakSelf refreshData];
            }else{
                weakSelf.bottomView.model = weakSelf.infoModel;
                [TLUIUtility showInfoHint:data];
            }
        }];
    }else{
        [ZCircleMineViewModel enjoyDynamic:@{@"dynamic":SafeStr(self.dynamic)} completeBlock:^(BOOL isSuccess, id data) {
            if (isSuccess) {
                weakSelf.infoModel.enjoy_status = @"1";
                weakSelf.infoModel.enjoy = [NSString stringWithFormat:@"%d",[weakSelf.infoModel.enjoy intValue]+1];
                weakSelf.bottomView.model = weakSelf.infoModel;
                [weakSelf.sectionView setLikeNum:weakSelf.infoModel.enjoy evaNum:weakSelf.infoModel.comment_number];
            }else{
                weakSelf.bottomView.model = weakSelf.infoModel;
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
            weakSelf.bottomView.model = weakSelf.infoModel;
            
            [weakSelf.sectionView setLikeNum:weakSelf.infoModel.enjoy evaNum:weakSelf.infoModel.comment_number];
            if (!weakSelf.isLike) {
                weakSelf.zChain_reload_Net();
            }
        }else{
            [TLUIUtility showInfoHint:data];
        }
    }];
}
@end
