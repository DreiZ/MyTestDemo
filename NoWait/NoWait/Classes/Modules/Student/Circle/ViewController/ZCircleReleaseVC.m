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

#import "ZCircleReleaseSelectSchoolVC.h"
#import "ZCircleReleaseAddLabelVC.h"
#import "ZOrganizationCampusManagementLocalAddressVC.h"
#import "ZCircleReleaseVideoUploadVC.h"
#import "ZCircleReleaseUploadVC.h"

@interface ZCircleReleaseVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) ZCircleReleaseCloseView *closeView;
@property (nonatomic,strong) ZCircleReleaseViewModel *releaseViewModel;

@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,assign) BOOL isVideo;
@property (nonatomic,assign) BOOL isUpdate;
@end

@implementation ZCircleReleaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [[ZFileUploadManager sharedInstance] getAccessKey:^(BOOL isSuccess) {
        
    }];
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
            make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(20));
        }];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
            make.height.mas_equalTo(CGFloatIn750(80));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(bottomView.mas_top);
            make.top.equalTo(self.closeView.mas_bottom);
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        
        ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.cellHeight = CGFloatIn750(80);
        cellModel.max = 90;
        cellModel.formatterType = ZFormatterTypeAnyByte;
        cellModel.textAlignment = NSTextAlignmentLeft;
        cellModel.placeholder = @"与众不同的标题会有更多喜欢哦~";
        cellModel.content = self.releaseViewModel.model.title;
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseTextFieldCell className] title:@"title" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleReleaseTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
        
        {
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseAddPhotoCell className] title:@"ZCircleReleaseAddPhotoCell" showInfoMethod:@selector(setImageList:) heightOfCell:[ZCircleReleaseAddPhotoCell z_getCellHeight:self.releaseViewModel.model.imageArr] cellType:ZCellTypeClass dataModel:self.releaseViewModel.model.imageArr];
            [self.cellConfigArr addObject:textCellConfig];
        }
        
        {
            ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleReleaseDetailTextViewCell className] title:@"ZCircleReleaseDetailTextViewCell" showInfoMethod:nil heightOfCell:[ZCircleReleaseDetailTextViewCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
            [self.cellConfigArr addObject:textCellConfig];
        }
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"line")
            .zz_lineHidden(NO)
            .zz_cellHeight(CGFloatIn750(4));
            
             ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

             [self.cellConfigArr  addObject:menuCellConfig];
        }
        {
            NSString *label = @"添加标签";
            NSString *labelHad = @"0";
            if (ValidArray(self.releaseViewModel.model.tags)) {
                for (int i = 0; i < self.releaseViewModel.model.tags.count; i++) {
                    ZCircleReleaseTagModel *model = self.releaseViewModel.model.tags[i];
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
            if (ValidStr(self.releaseViewModel.model.address)) {
                address = self.releaseViewModel.model.address;
                addressHad = @"1";
            }
            
            NSString *store_name = @"校区打卡";
            NSString *store_nameHad = @"0";
            if (ValidStr(self.releaseViewModel.model.store_name)) {
                store_name = self.releaseViewModel.model.store_name;
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
                    .zz_colorDarkBack([UIColor colorMain])
                    .zz_imageLeft(obj[4]);
                }else {
                    model.zz_colorLeft([UIColor colorTextBlack])
                    .zz_colorDarkBack([UIColor colorTextBlackDark])
                    .zz_imageLeft(obj[0]);
                }
                
                 ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

                 [self.cellConfigArr  addObject:menuCellConfig];
            }];
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZCircleReleaseAddPhotoCell"]) {
            ZCircleReleaseAddPhotoCell *lcell = (ZCircleReleaseAddPhotoCell *)cell;
            lcell.addBlock = ^{
                if (!ValidArray(weakSelf.releaseViewModel.model.imageArr)) {
                    [[ZImagePickerManager sharedManager] setPhotoWithMaxCount:9 - self.releaseViewModel.model.imageArr.count SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                        [weakSelf pickList:list];
                    }];
                }else{
                    ZFileUploadDataModel *dataModel = self.releaseViewModel.model.imageArr[0];
                    if (dataModel.taskType == ZUploadTypeVideo) {
                        [TLUIUtility showInfoHint:@"最多上传一个视频"];
                        return;
                    }else{
                        [[ZImagePickerManager sharedManager] setImagesWithMaxCount:9 - self.releaseViewModel.model.imageArr.count SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                            [weakSelf pickList:list];
                        }];
                    }
                }
            };
            lcell.menuBlock = ^(NSInteger index, BOOL handle) {
                if (!handle) {
                    [self.releaseViewModel.model.imageArr removeObjectAtIndex:index];
                    self.zChain_reload_ui();
                }
            };
            lcell.seeBlock = ^(NSInteger index) {
                if (index < self.releaseViewModel.model.imageArr.count) {
                    ZFileUploadDataModel *dataModel = self.releaseViewModel.model.imageArr[index];
                    if (dataModel.taskType == ZUploadTypeVideo) {
                        [[ZImagePickerManager sharedManager] showVideoBrowser:dataModel.asset];
                    }else{
                        NSMutableArray *tempImageArr = @[].mutableCopy;
                        for (int i = 0; i < self.releaseViewModel.model.imageArr.count; i++) {
                            ZFileUploadDataModel *dataModel = self.releaseViewModel.model.imageArr[i];
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
            lcell.content = self.releaseViewModel.model.content;
            lcell.textChangeBlock = ^(NSString *text) {
                DLog(@"text change %@",text);
                self.releaseViewModel.model.content = text;
            };
        }else if([cellConfig.title isEqualToString:@"title"]){
            ZCircleReleaseTextFieldCell *lcell = (ZCircleReleaseTextFieldCell *)cell;
            lcell.valueChangeBlock = ^(NSString * text) {
                self.releaseViewModel.model.title = text;
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"finderLabelNo"]) {
            ZCircleReleaseAddLabelVC *lvc = [[ZCircleReleaseAddLabelVC alloc] init];
            lvc.list = self.releaseViewModel.model.tags;
            lvc.handleBlock = ^(NSArray *lableArr) {
                [self.releaseViewModel.model.tags removeAllObjects];
                [self.releaseViewModel.model.tags addObjectsFromArray:lableArr];
                self.zChain_reload_ui();
            };
            [self.navigationController pushViewController:lvc animated:YES];
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
                weakSelf.zChain_reload_ui();
            };
            [self.navigationController pushViewController:avc animated:YES];
        }else if ([cellConfig.title isEqualToString:@"finderSchoolNo"]) {
            ZCircleReleaseSelectSchoolVC *svc = [[ZCircleReleaseSelectSchoolVC alloc] init];
            svc.handleBlock = ^(ZCircleReleaseSchoolModel * school) {
                weakSelf.releaseViewModel.model.store_id = school.store_id;
                weakSelf.releaseViewModel.model.store_name = school.name;
                self.zChain_reload_ui();
            };
            [self.navigationController pushViewController:svc animated:YES];
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
            if (!ValidStr(weakSelf.releaseViewModel.model.content)) {
                [TLUIUtility showInfoHint:@"请添加正文"];
                return;
            }
            NSMutableDictionary *params = @{}.mutableCopy;
            [params setObject:weakSelf.releaseViewModel.model.title forKey:@"title"];
            [params setObject:weakSelf.releaseViewModel.model.content forKey:@"content"];
            
            if (ValidStr(weakSelf.releaseViewModel.model.province) && ValidStr(weakSelf.releaseViewModel.model.city) &&
                ValidStr(weakSelf.releaseViewModel.model.county) &&
                ValidStr(weakSelf.releaseViewModel.model.address) &&
                ValidStr(weakSelf.releaseViewModel.model.province) &&
                weakSelf.releaseViewModel.model.latitude > 0.0001 &&
                weakSelf.releaseViewModel.model.longitude > 0.0001) {
                [params setObject:weakSelf.releaseViewModel.model.province forKey:@"province"];
                [params setObject:weakSelf.releaseViewModel.model.city forKey:@"city"];
                [params setObject:weakSelf.releaseViewModel.model.county forKey:@"region"];
                [params setObject:[NSString stringWithFormat:@"%f",weakSelf.releaseViewModel.model.longitude] forKey:@"longitude"];
                [params setObject:[NSString stringWithFormat:@"%f",weakSelf.releaseViewModel.model.latitude] forKey:@"latitude"];
                [params setObject:weakSelf.releaseViewModel.model.address forKey:@"address"];
            }
            
            if (!ValidStr(weakSelf.releaseViewModel.model.store_id)) {
                [params setObject:weakSelf.releaseViewModel.model.store_id forKey:@"store_id"];
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
            }
            ZCircleUploadModel *umodel = [[ZCircleUploadModel alloc] init];
            umodel.uploadStatus = ZCircleUploadStatusWatting;
            umodel.uploadList = uploadArr;
            umodel.otherParams = params;
            umodel.title = self.releaseViewModel.model.title;
            
            [[ZFileUploadManager sharedInstance].uploadCircleArr insertObject:umodel atIndex:0];
            
            ZCircleReleaseUploadVC *uvc = [[ZCircleReleaseUploadVC alloc] init];
            [self.navigationController pushViewController:uvc animated:YES];
            return;
            
            self.isVideo = isVideo;
            self.params = params;
            self.imageArr = uploadArr;
//            [self updateReleaseData];
            ZCircleReleaseVideoUploadVC *mvc = [[ZCircleReleaseVideoUploadVC alloc] init];
            mvc.params = params;
            mvc.imageArr = uploadArr;
            mvc.isVideo = isVideo;
            mvc.uploadCompleteBlock = ^{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            };
            [weakSelf.navigationController pushViewController:mvc animated:YES];
            
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
                [tempDict setObject:[NSString stringWithFormat:@"%ld",(long)model.asset.duration] forKey:@"duration"];
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
                    [cover setObject:[NSString stringWithFormat:@"%ld",(long)model.asset.duration] forKey:@"duration"];
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
