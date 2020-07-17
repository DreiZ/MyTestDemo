//
//  ZCircleReleaseUploadVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseUploadVC.h"
#import "ZCircleUploadCell.h"
#import "ZCircleReleaseViewModel.h"
#import "ZCircleReleaseCloseView.h"

@interface ZCircleReleaseUploadVC ()
@property (nonatomic,strong) ZCircleReleaseCloseView *closeView;
@end

@implementation ZCircleReleaseUploadVC

- (void)viewWillAppear:(BOOL)animated {
    self.isHidenNaviBar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loading = NO;
    self.zChain_setNavTitle(@"动态上传列表")
    .zChain_addEmptyDataDelegate()
    .zChain_setTableViewGary()
    .zChain_resetMainView(^{
        [self.view addSubview:self.closeView];
        [self.closeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(safeAreaTop());
            make.height.mas_equalTo(CGFloatIn750(80));
        }];
        
        self.closeView.title = @"动态上传列表";
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.closeView.mas_bottom);
        }];
    }).zChain_updateDataSource(^{
        NSArray <ZCircleUploadModel*>*circleUploadArr = [ZFileUploadManager sharedInstance].uploadCircleArr;
        [circleUploadArr enumerateObjectsUsingBlock:^(ZCircleUploadModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *tasklist = @[].mutableCopy;
            NSInteger count = 0;
            for (int i = 0; i < obj.uploadList.count; i++) {
                ZFileUploadDataModel *dataModel = obj.uploadList[i];
                if (dataModel.taskState == ZUploadStateWaiting) {
                    count++;
                }
                [tasklist addObject:obj.uploadList[i]];
            }
            
            if (count == obj.uploadList.count) {
                obj.progress = 0;
                obj.uploadStatus = ZCircleUploadStatusWatting;
            }else{
                obj.progress = 0 + (obj.uploadList.count-count)*1.0f/obj.uploadList.count;
            }
            
            if (count > 0) {
                obj.uploadStatus = ZCircleUploadStatusUploading;
                [[ZFileUploadManager sharedInstance] asyncSerialUpload:tasklist progress:^(CGFloat p, NSInteger index) {
                    obj.progress = (obj.uploadList.count-count + index)*1.0f/obj.uploadList.count + p/(tasklist.count) ;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (obj.progressBlock) {
                            obj.progressBlock(p);
                        }
                    });
                } completion:^(id backObj) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (obj.completeBlock) {
                            obj.completeBlock(backObj);
                        }
                    });
                    if (backObj && [backObj isKindOfClass:[NSArray class]]) {
                        NSArray *arr = backObj;
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
                        [self updateData:obj imageUrlArr:images];
                    }
                }];
            }
        }];
        self.loading = NO;
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];

        NSArray <ZCircleUploadModel*>*circleUploadArr = [ZFileUploadManager sharedInstance].uploadCircleArr;
        [circleUploadArr enumerateObjectsUsingBlock:^(ZCircleUploadModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleUploadCell className] title:@"ZCircleUploadCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleUploadCell z_getCellHeight:obj] cellType:ZCellTypeClass dataModel:obj];

            [self.cellConfigArr  addObject:menuCellConfig];
        }];
    });
    
    self.zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZCircleUploadCell"]) {
            ZCircleUploadCell *lcell = (ZCircleUploadCell *)cell;
            lcell.reUploadBlock = ^(ZCircleUploadModel *model) {
                [self UploadWith:model];
            };
        }
    });
    
    self.zChain_reload_ui();
}


- (ZCircleReleaseCloseView *)closeView {
    if (!_closeView) {
        __weak typeof(self) weakSelf = self;
        _closeView = [[ZCircleReleaseCloseView alloc] init];
        _closeView.backBlock = ^{
            NSArray *viewControllers = weakSelf.navigationController.viewControllers;
            NSArray *reversedArray = [[viewControllers reverseObjectEnumerator] allObjects];
            
            ZViewController *target;
            for (ZViewController *controller in reversedArray) {
                if ([controller isKindOfClass:[NSClassFromString(@"ZCircleViewController") class]]) {
                    target = controller;
                    break;
                }else if ([controller isKindOfClass:[NSClassFromString(@"ZStudentOrganizationDetailDesVC") class]]){
                    target = controller;
                }
            }
            
            if (target) {
                [weakSelf.navigationController popToViewController:target animated:YES];
                return;
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    
    return _closeView;
}

#pragma mark - 上传图片url
- (void)updateData:(ZCircleUploadModel *)obj imageUrlArr:(NSArray *)imageUrlArr{
    obj.uploadStatus = ZCircleUploadStatusUploadOtherData;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:obj.otherParams];
    
    if (obj.uploadList) {
        NSMutableArray *imageUploadArr = @[].mutableCopy;
        for (int i = 0; i < obj.uploadList.count; i++) {
            NSMutableDictionary *tempDict = @{}.mutableCopy;
            ZFileUploadDataModel *model = obj.uploadList[i];
            
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
    
//    __weak typeof(self) weakSelf = self;
    [ZCircleReleaseViewModel releaseDynamics:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            obj.uploadStatus = ZCircleUploadStatusComplete;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (obj.completeBlock) {
                    obj.completeBlock(obj);
                }
            });
//            [weakSelf configProgress:1];
//            [weakSelf showSuccessAnimation];
//            if (weakSelf.uploadCompleteBlock) {
//                weakSelf.uploadCompleteBlock();
//            }
//            [TLUIUtility showSuccessHint:message];
            return ;
        }else {
            obj.uploadStatus = ZCircleUploadStatusError;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (obj.errorBlock) {
                    obj.errorBlock(nil);
                }
            });
//            [weakSelf showErrorAnimation];
            [TLUIUtility showErrorHint:message];
        }
    }];
}

- (void)UploadWith:(ZCircleUploadModel *)obj{
    NSMutableArray *tasklist = @[].mutableCopy;
    NSInteger count = 0;
    for (int i = 0; i < obj.uploadList.count; i++) {
        ZFileUploadDataModel *dataModel = obj.uploadList[i];
        if (dataModel.taskState == ZUploadStateError) {
            dataModel.taskState = ZUploadStateWaiting;
        }
        if (dataModel.taskState == ZUploadStateWaiting) {
            count++;
        }
        [tasklist addObject:obj.uploadList[i]];
//        [ZFileUploadManager addTaskDataToUploadWith:obj.uploadList[i]];
    }
    
    if (count == obj.uploadList.count) {
        obj.progress = 0;
        obj.uploadStatus = ZCircleUploadStatusWatting;
    }else{
        obj.progress = 0 + (obj.uploadList.count-count)*1.0f/obj.uploadList.count;
    }
    
    if (count > 0) {
        obj.uploadStatus = ZCircleUploadStatusUploading;
        [[ZFileUploadManager sharedInstance] asyncSerialUpload:tasklist progress:^(CGFloat p, NSInteger index) {
            obj.progress = (obj.uploadList.count-count + index)*1.0f/obj.uploadList.count + p/(tasklist.count) ;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (obj.progressBlock) {
                    obj.progressBlock(p);
                }
            });
        } completion:^(id backObj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (obj.completeBlock) {
                    obj.completeBlock(backObj);
                }
            });
            if (backObj && [backObj isKindOfClass:[NSArray class]]) {
                NSArray *arr = backObj;
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
                [self updateData:obj imageUrlArr:images];
            }
        }];
    }
}
@end
