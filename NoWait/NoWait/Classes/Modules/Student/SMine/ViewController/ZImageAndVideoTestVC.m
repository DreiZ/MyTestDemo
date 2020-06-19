//
//  ZImageAndVideoTestVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZImageAndVideoTestVC.h"
#import "ZVideoPlayerManager.h"
#import "ZMineStudentEvaListEvaImageCollectionCell.h"
#import "ZFileManager.h"

@interface ZImageAndVideoTestVC ()
@property (nonatomic,strong) NSMutableArray *photos;
@property (nonatomic,strong) NSMutableArray <ZImagePickerModel *>*videos;
@end

@implementation ZImageAndVideoTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSMutableArray <NSDictionary *>*fileArr = [ZFileManager readFileWithPath:[ZFileManager getDocumentDirectory] folder:@"compressVideoFolder"];
//    NSMutableArray <NSDictionary *>*fileArr = [ZFileManager readFileWithPath:[ZFileManager getTmpDirectory] folder:nil];
//    [fileArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj objectForKey:@"path"]) {
//            BOOL isRemove = [ZFileManager removeDocumentWithFilePath:obj[@"path"]];
//            if (isRemove) {
//                DLog(@"---删除成功");
//            }else{
//                DLog(@"---删除失败");
//            }
//        }
//    }];
    
    _photos = @[@"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gfwuzvkmgzj30u011iapq.jpg",@"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gfwui029i8j30u018yhdu.jpg"].mutableCopy;
    _videos = @[].mutableCopy;
    
    self.zChain_setNavTitle(@"视频&图片");
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(80))];
            
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"image")
            .zz_titleLeft(@"图片")
            .zz_lineHidden(NO)
            .zz_cellHeight(CGFloatIn750(70))
            .zz_fontLeft([UIFont boldFontContent]);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"video")
            .zz_titleLeft(@"视频")
            .zz_lineHidden(NO)
            .zz_cellHeight(CGFloatIn750(70))
            .zz_fontLeft([UIFont boldFontContent]);
            
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaListEvaImageCollectionCell className] title:@"imageList" showInfoMethod:@selector(setImages:) heightOfCell:[ZMineStudentEvaListEvaImageCollectionCell z_getCellHeight:self.photos] cellType:ZCellTypeClass dataModel:self.photos];
            [self.cellConfigArr addObject:menuCellConfig];
        }
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        {
            __block NSMutableArray *videos = @[].mutableCopy;
            [self.videos enumerateObjectsUsingBlock:^(ZImagePickerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [videos addObject:obj.image];
            }];
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaListEvaImageCollectionCell className] title:@"videoList" showInfoMethod:@selector(setImages:) heightOfCell:[ZMineStudentEvaListEvaImageCollectionCell z_getCellHeight:videos] cellType:ZCellTypeClass dataModel:videos];
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"imageList"]) {
            ZMineStudentEvaListEvaImageCollectionCell *lcell = (ZMineStudentEvaListEvaImageCollectionCell *)cell;
            lcell.selectBlock = ^(NSInteger index) {
                [[ZImagePickerManager sharedManager] showBrowser:self.photos withIndex:index];
            };
        }else if ([cellConfig.title isEqualToString:@"videoList"]) {
            ZMineStudentEvaListEvaImageCollectionCell *lcell = (ZMineStudentEvaListEvaImageCollectionCell *)cell;
            lcell.selectBlock = ^(NSInteger index) {
                ZImagePickerModel *model = self.videos[index];
//                [[ZImagePickerManager sharedManager] showPhotoBrowser:model.asset];
                [[ZImagePickerManager sharedManager] getVideoOutputPathWith:model.asset success:^(NSString *path) {
                    [[ZVideoHandleManager sharedInstance] videoCompressWithSourceVideoPathString:path CompressType:AVAssetExportPresetLowQuality CompressSuccessBlock:^(NSString *compressVideoPathString) {
                    } CompressFailedBlock:^{
                        
                    } CompressNotSupportBlock:^{
                        
                    }];
                } failure:^(NSString *errorMessage, NSError *error) {
                    
                }];
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"image"]) {
            [[ZImagePickerManager sharedManager] setImagesWithMaxCount:9 SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                [list enumerateObjectsUsingBlock:^(ZImagePickerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.photos addObject:obj.image];
                }];
                self.zChain_reload_ui();
            }];
        }else if([cellConfig.title isEqualToString:@"video"]){
            [[ZImagePickerManager sharedManager] setVideoWithMaxCount:2 SelectMenu:^(NSArray<ZImagePickerModel *> *list) {
                NSLog(@"--%@", list);
                [list enumerateObjectsUsingBlock:^(ZImagePickerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.videos addObject:obj];
                }];
                self.zChain_reload_ui();
            }];
        }
    });
    
    self.zChain_reload_ui();
}


@end
