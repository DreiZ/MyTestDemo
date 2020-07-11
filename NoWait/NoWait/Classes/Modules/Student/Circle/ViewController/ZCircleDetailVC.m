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

#import "ZCircleMineCollectionVC.h"
#import "ZStudentOrganizationDetailDesVC.h"

@interface ZCircleDetailVC ()<XHInputViewDelagete>
@property (nonatomic,strong) ZCircleDetailHeaderView *headerView;
@property (nonatomic,strong) ZCircleDetailBottomView *bottomView;

@property (nonatomic,strong) ZCircleDynamicInfo *infoModel;

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
    self.zChain_resetMainView(^{
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
        [self getDetailInfo];
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
            ZOrderEvaListModel *model = [[ZOrderEvaListModel alloc] init];
            model.des = @"读书卡还的上gas电话格拉苏蒂很给力喀什东路kg阿萨德感受到了开发";
            model.student_image = @"https://wx2.sinaimg.cn/mw690/7868cc4cgy1gfyvqm9agkj21sc1sc1l1.jpg";
            model.nick_name = @"都发了哈萨克动感";
            model.update_at = @"123213212";
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleDetailEvaListCell className] title:@"evaList" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleDetailEvaListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [section2Arr addObject:menuCellConfig];
            [section2Arr addObject:menuCellConfig];
            [section2Arr addObject:menuCellConfig];
            [self.cellConfigArr addObject:section2Arr];
            
            ZCellConfig *noEvaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"nodata" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:@"没有更多内容了~"];
            [section2Arr addObject:noEvaCellConfig];
        }
    }).zChain_block_setViewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
        if (section == 1) {
            ZCircleDetailEvaSectionView *sectionView = [[ZCircleDetailEvaSectionView alloc] init];
            
            return sectionView;
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
}

- (ZCircleDetailHeaderView *)headerView {
    if (!_headerView) {
        __weak typeof(self) weakSelf = self;
        _headerView = [[ZCircleDetailHeaderView alloc] init];
        _headerView.handleBlock = ^(NSInteger index) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
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
                
            }else{
                
            }
        };
    }
    return _bottomView;
}


-(void)showXHInputViewWithStyle:(InputViewStyle)style{
    [XHInputView showWithStyle:style configurationBlock:^(XHInputView *inputView) {
        /** 请在此block中设置inputView属性 */
        
        /** 代理 */
        inputView.delegate = self;
        inputView.font = [UIFont fontContent];
        inputView.placeholderColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        inputView.sendButtonBackgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        inputView.sendButtonFont = [UIFont fontTitle];
        inputView.sendButtonTitle = @"发布";
        
        /** 占位符文字 */
        inputView.placeholder = @"评论：嘴巴嘟嘟的舞蹈学校";
        /** 设置最大输入字数 */
        inputView.maxCount = 1200;
        /** 输入框颜色 */
        inputView.textViewBackgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        /** 更多属性设置,详见XHInputView.h文件 */
        
    } sendBlock:^BOOL(NSString *text) {
        if(text.length){
            NSLog(@"输入的信息为:%@",text);
//            _textLab.text = text;
            return YES;//return YES,收起键盘
        }else{
            NSLog(@"显示提示框-请输入要评论的的内容");
            return NO;//return NO,不收键盘
        }
    }];
    
}

#pragma mark - XHInputViewDelagete
/** XHInputView 将要显示 */
-(void)xhInputViewWillShow:(XHInputView *)inputView{
    
     /** 如果你工程中有配置IQKeyboardManager,并对XHInputView造成影响,请在XHInputView将要显示时将其关闭 */
    
     [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
     [IQKeyboardManager sharedManager].enable = NO;

}

/** XHInputView 将要影藏 */
-(void)xhInputViewWillHide:(XHInputView *)inputView{
    
     /** 如果你工程中有配置IQKeyboardManager,并对XHInputView造成影响,请在XHInputView将要影藏时将其打开 */
    
     [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
     [IQKeyboardManager sharedManager].enable = YES;
}

- (void)getDetailInfo {
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel getCircleDynamicInfo:@{@"dynamic":self.dynamic} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && [data isKindOfClass:[ZCircleDynamicInfo class]]) {
            weakSelf.infoModel = data;
            weakSelf.zChain_reload_ui();
            weakSelf.headerView.title = weakSelf.infoModel.title;
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
@end
