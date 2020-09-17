//
//  ZCircleReleaseVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseVC.h"
#import "ZCircleReleaseCloseView.h"
#import "ZCircleReleaseTextFieldCell.h"
#import "ZCircleReleaseAddPhotoCell.h"
#import "ZCircleReleaseDetailTextViewCell.h"

#import "ZAlertView.h"
#import "ZBaseUnitModel.h"
#import "ZCircleReleaseViewModel.h"
#import "ZCircleUploadModel.h"

#import "ZOrganizationCampusManagementLocalAddressVC.h"

@interface ZCircleReleaseVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIView *agreementBottomView;
@property (nonatomic,strong) YYLabel *protocolLabel;
@property (nonatomic,strong) UIImageView *agreementView;

@property (nonatomic,strong) ZCircleReleaseCloseView *closeView;
@property (nonatomic,strong) ZCircleReleaseViewModel *releaseViewModel;

@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,assign) BOOL isVideo;
@property (nonatomic,assign) BOOL isUpdate;
@property (nonatomic,assign) BOOL isAgree;
@end

@implementation ZCircleReleaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_updateDataSource(^{
        self.releaseViewModel = [[ZCircleReleaseViewModel alloc] init];
        if (self.selectImageArr) {
            [self.releaseViewModel.model.imageArr addObjectsFromArray:self.selectImageArr];
        }
        self.params = @{}.mutableCopy;
        self.imageArr = @[].mutableCopy;
    }).zChain_resetMainView(^{
        [self.view addSubview:self.closeView];
        [self.closeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(safeAreaTop());
            make.height.mas_equalTo(CGFloatIn750(80));
        }];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFloatIn750(180))];
        bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        [self.view addSubview:bottomView];
        [self.view addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(60));
            make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(-60));
            make.height.mas_equalTo(CGFloatIn750(80));
            make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(10));
        }];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            if (safeAreaBottom() < 20) {
                make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(30));
            }else{
                make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
            }
            
            make.height.mas_equalTo(CGFloatIn750(100));
        }];
        
        self.iTableView.tableFooterView = self.agreementBottomView;
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(bottomView.mas_top);
            make.top.equalTo(self.closeView.mas_bottom);
        }];
        
        NSString *hadLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"hadReleaseCircle"];
       if (hadLogin) {
           self.isAgree = YES;
       }else{
           self.isAgree = NO;
       }
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.cellHeight = CGFloatIn750(80);
        cellModel.max = 90;
        cellModel.formatterType = ZFormatterTypeAnyByte;
        cellModel.textAlignment = NSTextAlignmentLeft;
        cellModel.placeholder = @"与众不同的标题会有更多喜欢哦~";
        cellModel.content = weakSelf.releaseViewModel.model.title;
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseTextFieldCell className] title:@"title" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleReleaseTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [weakSelf.cellConfigArr addObject:textCellConfig];
        
        {
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseAddPhotoCell className] title:@"ZCircleReleaseAddPhotoCell" showInfoMethod:@selector(setImageList:) heightOfCell:[ZCircleReleaseAddPhotoCell z_getCellHeight:weakSelf.releaseViewModel.model.imageArr] cellType:ZCellTypeClass dataModel:weakSelf.releaseViewModel.model.imageArr];
            [weakSelf.cellConfigArr addObject:textCellConfig];
        }
        
        {
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseDetailTextViewCell className] title:@"ZCircleReleaseDetailTextViewCell" showInfoMethod:nil heightOfCell:[ZCircleReleaseDetailTextViewCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [weakSelf.cellConfigArr addObject:textCellConfig];
        }
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"line")
            .zz_lineHidden(NO)
            .zz_cellHeight(CGFloatIn750(4));
            
             ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

             [weakSelf.cellConfigArr  addObject:menuCellConfig];
        }
        {
            NSString *label = @"添加标签";
            NSString *labelHad = @"0";
            if (ValidArray(weakSelf.releaseViewModel.model.tags)) {
                for (int i = 0; i < weakSelf.releaseViewModel.model.tags.count; i++) {
                    ZCircleReleaseTagModel *model = weakSelf.releaseViewModel.model.tags[i];
                    if (i == 0) {
                        label = [NSString stringWithFormat:@"%@",model.tag_name];
                    }else {
                        label = [NSString stringWithFormat:@"%@，%@",label,model.tag_name];
                    }
                }
                labelHad = @"1";
            }
            
            NSString *address = @"所在位置";
            NSString *addressHad = @"0";
            if (ValidStr(weakSelf.releaseViewModel.model.address)) {
                address = weakSelf.releaseViewModel.model.address;
                addressHad = @"1";
            }
            
            NSString *store_name = @"校区打卡";
            NSString *store_nameHad = @"0";
            if (ValidStr(weakSelf.releaseViewModel.model.store_name)) {
                store_name = weakSelf.releaseViewModel.model.store_name;
                store_nameHad = @"1";
            }
            
            NSArray *tempArr = @[@[@"finderLabelNo",label,@"rightBlackArrowN",labelHad,@"finderLabel"],
            @[@"finderLocationNo",address,@"rightBlackArrowN",addressHad,@"finderLocationGreen"],
            @[@"finderSchoolNo",store_name,@"rightBlackArrowN",store_nameHad,@"finderSchool"]];
            
            [tempArr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(obj[0])
                .zz_titleLeft(obj[1])
                .zz_imageLeft(obj[0])
                .zz_lineHidden(NO)
                .zz_cellHeight(CGFloatIn750(84))
                .zz_imageRight(obj[2])
                .zz_leftMultiLine(YES)
                .zz_imageRightHeight(CGFloatIn750(14))
                .zz_imageLeftHeight(CGFloatIn750(28))
                .zz_spaceLine(CGFloatIn750(8))
                .zz_imageLeftWidth(CGFloatIn750(28));
                if ([obj[3] intValue] == 1) {
                    model.zz_colorLeft([UIColor colorMain])
                    .zz_colorDarkLeft([UIColor colorMain])
                    .zz_imageLeft(obj[4]);
                }else {
                    model.zz_colorLeft([UIColor colorTextBlack])
                    .zz_colorDarkLeft([UIColor colorTextBlackDark])
                    .zz_imageLeft(obj[0]);
                }
                
                 ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

                 [weakSelf.cellConfigArr  addObject:menuCellConfig];
            }];
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZCircleReleaseAddPhotoCell"]) {
            ZCircleReleaseAddPhotoCell *lcell = (ZCircleReleaseAddPhotoCell *)cell;
            lcell.addBlock = ^{
                [[ZImagePickerManager sharedManager] setPhotoWithMaxCount:9 - weakSelf.releaseViewModel.model.imageArr.count SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                    [weakSelf pickList:list];
                }];
                return;
                if (!ValidArray(weakSelf.releaseViewModel.model.imageArr)) {
                    [[ZImagePickerManager sharedManager] setPhotoWithMaxCount:9 - weakSelf.releaseViewModel.model.imageArr.count SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                        [weakSelf pickList:list];
                    }];
                }else{
                    ZFileUploadDataModel *dataModel = weakSelf.releaseViewModel.model.imageArr[0];
                    if (dataModel.taskType == ZUploadTypeVideo) {
                        [TLUIUtility showInfoHint:@"最多上传一个视频"];
                        return;
                    }else{
                        [[ZImagePickerManager sharedManager] setImagesWithMaxCount:9 - weakSelf.releaseViewModel.model.imageArr.count SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                            [weakSelf pickList:list];
                        }];
                    }
                }
            };
            lcell.menuBlock = ^(NSInteger index, BOOL handle) {
                if (!handle) {
                    [weakSelf.releaseViewModel.model.imageArr removeObjectAtIndex:index];
                    if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
                }
            };
            lcell.seeBlock = ^(NSInteger index) {
                if (index < weakSelf.releaseViewModel.model.imageArr.count) {
                    ZFileUploadDataModel *dataModel = weakSelf.releaseViewModel.model.imageArr[index];
                    if (dataModel.taskType == ZUploadTypeVideo) {
                        [[ZImagePickerManager sharedManager] showVideoBrowser:dataModel.asset];
                    }else{
                        NSMutableArray *tempImageArr = @[].mutableCopy;
                        for (int i = 0; i < weakSelf.releaseViewModel.model.imageArr.count; i++) {
                            ZFileUploadDataModel *dataModel = weakSelf.releaseViewModel.model.imageArr[i];
                            ZImagePickerModel *pmodel = [[ZImagePickerModel alloc] init];
                            if (dataModel.taskType == ZUploadTypeVideo) {
                                pmodel.isVideo = YES;
                                pmodel.asset = dataModel.asset;
                            }else{
                                pmodel.image = dataModel.image;
                            }
                            [tempImageArr addObject:pmodel];
                        }
                        [[ZImagePickerManager sharedManager] showPhotoBrowser:tempImageArr withIndex:index];
                    }
                }
            };
        }else if([cellConfig.title isEqualToString:@"ZCircleReleaseDetailTextViewCell"]){
            ZCircleReleaseDetailTextViewCell *lcell = (ZCircleReleaseDetailTextViewCell *)cell;
            lcell.max = 1500;
            lcell.content = weakSelf.releaseViewModel.model.content;
            lcell.textChangeBlock = ^(NSString *text) {
                DLog(@"text change %@",text);
                weakSelf.releaseViewModel.model.content = text;
            };
        }else if([cellConfig.title isEqualToString:@"title"]){
            ZCircleReleaseTextFieldCell *lcell = (ZCircleReleaseTextFieldCell *)cell;
            lcell.valueChangeBlock = ^(NSString * text) {
                weakSelf.releaseViewModel.model.title = text;
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"finderLabelNo"]) {
            routePushVC(ZRoute_circle_addLabel, weakSelf.releaseViewModel.model.tags, ^(NSArray *lableArr, NSError * _Nullable error) {
                [weakSelf.releaseViewModel.model.tags removeAllObjects];
                [weakSelf.releaseViewModel.model.tags addObjectsFromArray:lableArr];
                if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
            });
        }else if ([cellConfig.title isEqualToString:@"finderLocationNo"]) {
            ZOrganizationCampusManagementLocalAddressVC *avc = [[ZOrganizationCampusManagementLocalAddressVC alloc] init];
            avc.addressBlock = ^(NSString *province, NSString *city, NSString *county, NSString *brief_address, NSString *address,double latitude, double longitude) {
                weakSelf.releaseViewModel.model.province = province;
                weakSelf.releaseViewModel.model.city = city;
                weakSelf.releaseViewModel.model.county = county;
                weakSelf.releaseViewModel.model.brief_address = brief_address;
                weakSelf.releaseViewModel.model.address = address;
                weakSelf.releaseViewModel.model.latitude = latitude;
                weakSelf.releaseViewModel.model.longitude = longitude;
                if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
            };
            [weakSelf.navigationController pushViewController:avc animated:YES];
        }else if ([cellConfig.title isEqualToString:@"finderSchoolNo"]) {
            routePushVC(ZRoute_circle_choseSchool, nil, ^(ZCircleReleaseSchoolModel* school, NSError * _Nullable error) {
                weakSelf.releaseViewModel.model.store_id = school.store_id;
                weakSelf.releaseViewModel.model.store_name = school.name;
                if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
            });
        }
    });
    
    self.zChain_reload_ui();
}

- (void)pickList:(NSArray<ZImagePickerModel *> *)list {
    if (list && list.count > 0){
        for (ZImagePickerModel *model in list) {
            ZFileUploadDataModel *dataModel = [[ZFileUploadDataModel alloc] init];
            if (model.isVideo) {
                dataModel.image = model.image;
                dataModel.taskType = ZUploadTypeVideo;
                dataModel.asset = model.asset;
                dataModel.taskState = ZUploadStateWaiting;
//                            dataModel.filePath = [model.mediaURL absoluteString];
            }else{
                dataModel.image = model.image;
                dataModel.asset = model.asset;
                dataModel.taskType = ZUploadTypeImage;
                dataModel.taskState = ZUploadStateWaiting;
            }
            dataModel.type = @"10";
            [self.releaseViewModel.model.imageArr addObject:dataModel];
        }
        self.zChain_reload_ui();
    }
}

#pragma mark - lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            if (!ValidStr(weakSelf.releaseViewModel.model.title)) {
                [TLUIUtility showInfoHint:@"请输入标题"];
                return;
            }
            if (!ValidArray(weakSelf.releaseViewModel.model.imageArr)) {
                [TLUIUtility showInfoHint:@"请添加图片或视频"];
                return;
            }
            if (!self.isAgree) {
                [TLUIUtility showInfoHint:@"请阅读并发布动态协议"];
                return;
            }
//            if (!ValidStr(weakSelf.releaseViewModel.model.content)) {
//                [TLUIUtility showInfoHint:@"请添加正文"];
//                return;
//            }
            NSMutableDictionary *params = @{}.mutableCopy;
            [params setObject:weakSelf.releaseViewModel.model.title forKey:@"title"];
            
            if (ValidStr(weakSelf.releaseViewModel.model.content)) {
                [params setObject:weakSelf.releaseViewModel.model.content forKey:@"content"];
            }
            
            if (ValidStr(weakSelf.releaseViewModel.model.address) &&
                weakSelf.releaseViewModel.model.latitude > 0.0001 &&
                weakSelf.releaseViewModel.model.longitude > 0.0001) {
                [params setObject:SafeStr(weakSelf.releaseViewModel.model.province) forKey:@"province"];
                [params setObject:SafeStr(weakSelf.releaseViewModel.model.city) forKey:@"city"];
                [params setObject:SafeStr(weakSelf.releaseViewModel.model.county) forKey:@"region"];
                [params setObject:[NSString stringWithFormat:@"%f",weakSelf.releaseViewModel.model.longitude] forKey:@"longitude"];
                [params setObject:[NSString stringWithFormat:@"%f",weakSelf.releaseViewModel.model.latitude] forKey:@"latitude"];
                [params setObject:weakSelf.releaseViewModel.model.address forKey:@"address"];
            }
            
            NSMutableArray *tags = @[].mutableCopy;
            if (ValidArray(self.releaseViewModel.model.tags)) {
                for (int i = 0; i < self.releaseViewModel.model.tags.count; i++) {
                    ZCircleReleaseTagModel *model = self.releaseViewModel.model.tags[i];
                    [tags addObject:model.tag_name];
                }
            }
            [params setObject:tags forKey:@"tags"];
            if (ValidStr(self.releaseViewModel.model.store_id)) {
                [params setObject:self.releaseViewModel.model.store_id forKey:@"store_id"];
            }
            
            
            NSMutableArray *uploadArr = @[].mutableCopy;
            [uploadArr addObjectsFromArray:self.releaseViewModel.model.imageArr];
            BOOL isVideo = NO;
            for (ZFileUploadDataModel *model in self.releaseViewModel.model.imageArr) {
                if (model.taskType == ZUploadTypeVideo) {
                    isVideo = YES;
                }
                model.type = @"10";
//                [model getFilePath:^(NSString *ll) {
//
//                }];
            }
            ZCircleUploadModel *umodel = [[ZCircleUploadModel alloc] init];
            umodel.uploadStatus = ZCircleUploadStatusWatting;
            umodel.uploadList = uploadArr;
            umodel.otherParams = params;
            umodel.title = self.releaseViewModel.model.title;
    
            [[NSUserDefaults standardUserDefaults] setObject:@"hadReleaseCircle" forKey:@"hadReleaseCircle"];

            [[ZFileUploadManager sharedInstance].uploadCircleArr insertObject:umodel atIndex:0];
            
            routePushVC(ZRoute_circle_releaseUpload, nil, nil);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (ZCircleReleaseCloseView *)closeView {
    if (!_closeView) {
        __weak typeof(self) weakSelf = self;
        _closeView = [[ZCircleReleaseCloseView alloc] init];
        [_closeView setTitle:@"发布动态"];
        
        _closeView.backBlock = ^{
            if (ValidStr(self.releaseViewModel.model.content)) {
                [ZAlertView setAlertWithTitle:@"提示" subTitle:@"退出后编辑文字图片将不保存" leftBtnTitle:@"取消" rightBtnTitle:@"退出" handlerBlock:^(NSInteger index) {
                    if (index == 1) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                }];
            }else{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        };
    }
    
    return _closeView;
}


- (UIView *)agreementBottomView {
    if (!_agreementBottomView) {
        __weak typeof(self) weakSelf = self;
        _agreementBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(120))];
        _agreementView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _protocolLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
        _protocolLabel.layer.masksToBounds = YES;
        _protocolLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _protocolLabel.numberOfLines = 0;
        _protocolLabel.textAlignment = NSTextAlignmentCenter;
        [_protocolLabel setFont:[UIFont fontContent]];
        [_agreementBottomView addSubview:_protocolLabel];
        [_protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.agreementBottomView.mas_centerX);
            make.top.bottom.equalTo(self.agreementBottomView);
        }];
        NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"已阅读并同意遵守《似锦网络社区自律公约》"];
        text.lineSpacing = 0;
        text.font = [UIFont fontSmall];
        text.color = [UIColor colorTextGray];
        //    __weak typeof(self) weakself = self;
        
        [text setTextHighlightRange:NSMakeRange(8, 12) color:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            ZAgreementModel *avc = [[ZAgreementModel alloc] init];
            avc.navTitle = @"似锦网络社区自律公约";
            avc.type = @"find_agreement";
            avc.url = @"http://www.xiangcenter.com/User/findconvention.html";
            routePushVC(ZRoute_mine_agreement, avc, nil);
        }];
        
        _protocolLabel.preferredMaxLayoutWidth = kScreenWidth - CGFloatIn750(60);
        _protocolLabel.attributedText = text;  //设置富文本
        [_agreementBottomView addSubview:self.agreementView];
        [self.agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.protocolLabel.mas_centerY).offset(-CGFloatIn750(0));
            make.right.equalTo(self.protocolLabel.mas_left).offset(-5);
            make.width.height.mas_equalTo(CGFloatIn750(32));
        }];
        
        UIButton *agreementBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [agreementBtn bk_addEventHandler:^(id sender) {
            weakSelf.isAgree = !weakSelf.isAgree;
        } forControlEvents:UIControlEventTouchUpInside];
        
        [_agreementBottomView addSubview:agreementBtn];
        [agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.agreementBottomView);
            make.width.mas_equalTo(CGFloatIn750(100));
            make.centerX.equalTo(self.agreementView.mas_centerX);
        }];
    }
    return _agreementBottomView;
}


- (UIImageView *)agreementView {
    if (!_agreementView) {
        _agreementView = [[UIImageView alloc] init];
        _agreementView.layer.masksToBounds = YES;
        _agreementView.image = [UIImage imageNamed:@"unSelectedCycle"];
    }
    return _agreementView;
}

- (void)setIsAgree:(BOOL)isAgree {
    _isAgree = isAgree;
    
    if (isAgree) {
        self.agreementView.image = [UIImage imageNamed:@"selectedCycle"];
    }else{
        self.agreementView.image = [UIImage imageNamed:@"unSelectedCycle"];
    }
}

- (void)updateReleaseData {
    NSMutableArray *tasklist = @[].mutableCopy;
    NSInteger count = 0;
    for (int i = 0; i < self.imageArr.count; i++) {
        ZFileUploadDataModel *dataModel = self.imageArr[i];
        if (dataModel.taskState == ZUploadStateWaiting) {
            count++;
        }
        [tasklist addObject:self.imageArr[i]];
        [ZFileUploadManager addTaskDataToUploadWith:self.imageArr[i]];
    }
    if (count > 0) {
        if (self.isVideo) {
            [TLUIUtility showLoading:[NSString stringWithFormat:@"压缩视频中"]];
        }else{
            [TLUIUtility showLoading:@"上传数据中..."];
        }
        
    //    //异步串行
        [[ZFileUploadManager sharedInstance] asyncSerialUpload:tasklist progress:^(CGFloat p, NSInteger index) {
            DLog(@"---------------%ld", index+1);
            if (self.isVideo) {
                [TLUIUtility showLoading:[NSString stringWithFormat:@"上传视频数据中%.0f%@",p/(tasklist.count+0.3)*100,@"%"]];
            }else{
                [TLUIUtility showLoading:[NSString stringWithFormat:@"上传图片第%ld张",(long)index+1]];
            }
        } completion:^(id obj) {
            if (obj && [obj isKindOfClass:[NSArray class]]) {
                NSArray *arr = obj;
                NSMutableArray *images = @[].mutableCopy;
                for (int i = 0; i < arr.count; i++) {
                    if ([arr[i] isKindOfClass:[ZBaseNetworkBackModel class]]) {
                        ZBaseNetworkBackModel *dataModel = arr[i];
                        if (ValidDict(dataModel.data)) {
                            ZBaseNetworkImageBackModel *imageModel = [ZBaseNetworkImageBackModel mj_objectWithKeyValues:dataModel.data];
                            if ([dataModel.code integerValue] == 0 ) {
                                [images addObject:SafeStr(imageModel.url)];
                            }
                        }
                    }else if([arr[i] isKindOfClass:[NSString class]]){
                        [images addObject:SafeStr(arr[i])];
                    }
                }
                [self updateData:images];
            }else{
                [TLUIUtility hiddenLoading];
            }
        }];
    }else{
        [self updateData:@[]];
    }
}


#pragma mark - 上传图片url
- (void)updateData:(NSArray *)imageUrlArr {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:self.params];
    if (self.imageArr.count > 0) {
        NSMutableArray *imageUploadArr = @[].mutableCopy;
        for (int i = 0; i < self.imageArr.count; i++) {
            NSMutableDictionary *tempDict = @{}.mutableCopy;
            ZFileUploadDataModel *model = self.imageArr[i];
            
            if (model.taskType == ZUploadTypeVideo) {
                [tempDict setObject:model.video_url forKey:@"url"];
                [tempDict setObject:[NSString stringWithFormat:@"%ld",(long)(model.asset.duration *1000)] forKey:@"duration"];
            }else{
                [tempDict setObject:model.image_url forKey:@"url"];
                [tempDict setObject:@"0" forKey:@"duration"];
            }
            
            CGFloat fixelW = CGImageGetWidth(model.image.CGImage);
            CGFloat fixelH = CGImageGetHeight(model.image.CGImage);
            [tempDict setObject:[NSString stringWithFormat:@"%.0f",fixelW] forKey:@"width"];
            [tempDict setObject:[NSString stringWithFormat:@"%.0f",fixelH] forKey:@"height"];
            [imageUploadArr addObject:tempDict];
            
            if (i == 0) {
                NSMutableDictionary *cover = @{}.mutableCopy;

                CGFloat fixelW = CGImageGetWidth(model.image.CGImage);
                CGFloat fixelH = CGImageGetHeight(model.image.CGImage);
                
                [cover setObject:[NSString stringWithFormat:@"%.0f",fixelW] forKey:@"width"];
                [cover setObject:[NSString stringWithFormat:@"%.0f",fixelH] forKey:@"height"];
                
                if (model.taskType == ZUploadTypeVideo) {
                    [cover setObject:model.video_url forKey:@"url"];
                    [cover setObject:[NSString stringWithFormat:@"%ld",(long)(model.asset.duration *1000)] forKey:@"duration"];
                }else{
                    
                    [cover setObject:@"0" forKey:@"duration"];
                    [cover setObject:model.image_url forKey:@"url"];
                }
                
                [params setObject:cover forKey:@"cover"];
            }
        }

        [params setObject:imageUploadArr forKey:@"url"];
    }
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@"上传其它数据中..."];
    [ZCircleReleaseViewModel releaseDynamics:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [TLUIUtility showSuccessHint:message];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}
@end

#pragma mark - RouteHandler
@interface ZCircleReleaseVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZCircleReleaseVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_circle_release;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZCircleReleaseVC *routevc = [[ZCircleReleaseVC alloc] init];
    if (request.prts) {
        routevc.selectImageArr = request.prts;
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
