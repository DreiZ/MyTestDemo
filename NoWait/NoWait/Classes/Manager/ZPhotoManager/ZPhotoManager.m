//
//  ZPhotoManager.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/11/12.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZPhotoManager.h"
#import "TZImagePickerController.h"
#import "MWPhotoBrowser.h"
#import "LLActionSheetView.h"
#import "AppDelegate+AppService.h"
#import "LLImagePickerManager.h"
#import "NSString+LLExtension.h"
#import "UIImage+LLGif.h"
#import "AppDelegate+AppService.h"
#import "XYTakePhotoController.h"

@interface ZPhotoManager ()<TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MWPhotoBrowserDelegate>


@property (nonatomic, copy) LLSelecttImageBackBlock backBlock;

/** 总的媒体数组 */
@property (nonatomic, strong) NSMutableArray *mediaArray;

/** 记录从相册中已选的Image Asset */
@property (nonatomic, strong) NSMutableArray *selectedImageAssets;

/** 记录从相册中已选的Image model */
@property (nonatomic, strong) NSMutableArray *selectedImageModels;

/** 记录从相册中已选的Video model*/
@property (nonatomic, strong) NSMutableArray *selectedVideoModels;

/** MWPhoto对象数组 */
@property (nonatomic, strong) NSMutableArray *photos;


@end

static ZPhotoManager *sharedPhotoManager;

@implementation ZPhotoManager

+ (ZPhotoManager *)sharedManager {
    @synchronized (self) {
        if (!sharedPhotoManager) {
            sharedPhotoManager = [[ZPhotoManager alloc] init];
        }
    }
    return sharedPhotoManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    _mediaArray = [NSMutableArray array];
    _preShowMedias = [NSMutableArray array];
    _selectedImageAssets = [NSMutableArray array];
    _selectedVideoModels = [NSMutableArray array];
    _selectedImageModels = [NSMutableArray array];
    _type = LLImageTypePhotoAndCamera;
    _showDelete = YES;
    _showAddButton = YES;
    _allowMultipleSelection = YES;
    _maxImageSelected = 9;
    _allowCrop = NO;
}


- (UIViewController *)viewController {
    _viewController = [[AppDelegate shareAppDelegate] getCurrentUIVC];
    return _viewController;
}

#pragma mark 选择照片
//单次选择照片
- (void)showOriginalSelectMenuWithType:(LLImageType)type complete:(LLSelecttImageBackBlock)complete{
    _type = type;
    _maxImageSelected = 1;
    [_mediaArray removeAllObjects];
    [_selectedImageAssets removeAllObjects];
    [_selectedVideoModels removeAllObjects];
    [_selectedImageModels removeAllObjects];
    
    [self setSelectMenu:complete];
}

//选择照片
- (void)showOriginalSelectMenu:(LLSelecttImageBackBlock)complete
{
    _maxImageSelected = 1;
    [_mediaArray removeAllObjects];
    [_selectedImageAssets removeAllObjects];
    [_selectedVideoModels removeAllObjects];
    [_selectedImageModels removeAllObjects];
    
    [self setSelectMenu:complete];
}


- (void)showOriginalSelectMenu:(LLSelecttImageBackBlock)complete navgation:(UIViewController *)viewController {
    [_mediaArray removeAllObjects];
    [_selectedImageAssets removeAllObjects];
    [_selectedVideoModels removeAllObjects];
    [_selectedImageModels removeAllObjects];
    
    [self showSelectMenu:complete navgation:viewController];
}

//单次选择剪切照片
- (void)showCropOriginalSelectMenu:(LLSelecttImageBackBlock)complete{
    _type = LLImageTypePhotoAndCamera;
    _allowCrop = YES;
    _showSelectBtn = NO;
    _cropRect = CGRectMake(0, KScreenHeight - (2.0/3.0)*KScreenWidth, KScreenWidth, (2.0/3.0)*KScreenWidth);
   
    [self showOriginalSelectMenu:complete];
}

- (void)showCropOriginalSelectMenuWithCropSize:(CGSize)cropSize complete:(LLSelecttImageBackBlock)complete {
    _type = LLImageTypeAll;
    _allowCrop = YES;
    _showSelectBtn = NO;
    _cropRect = CGRectMake((KScreenWidth - cropSize.width)/2.0, (KScreenHeight - cropSize.height)/2.0, cropSize.width, cropSize.height);
   
    [self showOriginalSelectMenu:complete];
}

- (void)showIDCropOriginalSelectMenuWithCropSize:(CGSize)cropSize complete:(LLSelecttImageBackBlock)complete {
    _type = LLImageTypeCardIDFontPhotoAndCamera;
     _allowCrop = YES;
     _showSelectBtn = NO;
     _cropRect = CGRectMake((KScreenWidth - cropSize.width)/2.0, (KScreenHeight - cropSize.height)/2.0, cropSize.width, cropSize.height);
    
     [self showOriginalSelectMenu:complete];
}

- (void)showCropOriginalSelectMenu:(LLSelecttImageBackBlock)complete navgation:(UIViewController *)viewController  {
    _type = LLImageTypePhotoAndCamera;
    _allowCrop = YES;
    _showSelectBtn = NO;
    [_mediaArray removeAllObjects];
    [_selectedImageAssets removeAllObjects];
    [_selectedVideoModels removeAllObjects];
    [_selectedImageModels removeAllObjects];
    
    [self setSelectMenu:complete];
}

- (void)showSelectMenu:(LLSelecttImageBackBlock)complete navgation:(UIViewController *)viewController {
////    self.viewController = viewController;
//    _allowCrop = NO;
//    _showSelectBtn = YES;
    _type = LLImageTypePhotoAndCamera;
    [self showSelectMenu:complete];
}

- (void)showSelectMenu:(LLSelecttImageBackBlock)complete {
    _allowCrop = NO;
    _showSelectBtn = YES;
    [_mediaArray removeAllObjects];
    [_selectedImageAssets removeAllObjects];
    [_selectedVideoModels removeAllObjects];
    [_selectedImageModels removeAllObjects];
    [self setSelectMenu:complete];
}

- (void)setSelectMenu:(LLSelecttImageBackBlock)complete{
    _backBlock = complete;
    if (_mediaArray.count >= _maxImageSelected) {
        [TLUIUtility showAlertWithTitle:[NSString stringWithFormat:@"最多只能选择%ld张",(long)_maxImageSelected] message:nil cancelButtonTitle:@"确定"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    switch (_type) {
        case LLImageTypePhoto:
            [self openAlbum];
            break;
        case LLImageTypeCamera:
            [self openCamera];
            break;
        case LLImageTypeCardIDFontPhotoAndCamera:
        {
            LLActionSheetView *alert = [[LLActionSheetView alloc]initWithTitleArray:@[@"相册",@"相机"] andShowCancel: YES];
            alert.ClickIndex = ^(NSInteger index) {
                if (index == 1){
                    [weakSelf openAlbum];
                }else if (index == 2){
                    [weakSelf openIDCardCamera:0];
                }
            };
            [alert show];
        }
            break;
        case LLImageTypeCardIDBackPhotoAndCamera:
        {
            LLActionSheetView *alert = [[LLActionSheetView alloc]initWithTitleArray:@[@"相册",@"相机"] andShowCancel: YES];
            alert.ClickIndex = ^(NSInteger index) {
                if (index == 1){
                    [weakSelf openAlbum];
                }else if (index == 2){
                    [weakSelf openIDCardCamera:1];
                }
            };
            [alert show];\
        }
                break;
        case LLImageTypePhotoAndCamera:
        {
            LLActionSheetView *alert = [[LLActionSheetView alloc]initWithTitleArray:@[@"相册",@"相机"] andShowCancel: YES];
            alert.ClickIndex = ^(NSInteger index) {
                if (index == 1){
                    [weakSelf openAlbum];
                }else if (index == 2){
                    [weakSelf openCamera];
                }
            };
            [alert show];
            break;
        }
        case LLImageTypeVideoTape:
            [self openVideotape];
            break;
        case LLImageTypeVideo:
            [self openVideo];
            break;
        default:
        {
            LLActionSheetView *alert = [[LLActionSheetView alloc]initWithTitleArray:@[@"相册", @"相机", @"录像", @"视频"] andShowCancel: YES];
            alert.ClickIndex = ^(NSInteger index) {
                DLog(@"%zd",index);
                if (index == 4) {
                    [weakSelf openVideo];
                }else if (index == 3){
                    [weakSelf openVideotape];
                }else if (index == 2){
                    [weakSelf openCamera];
                }else if (index == 1){
                    [weakSelf openAlbum];
                }
            };
            [alert show];
        }
            break;
    }
}

#pragma mark - actions
/** 相机 */
- (void)openCameraWithComplete:(LLSelecttImageBackBlock)complete {
    [self.mediaArray removeAllObjects];
    self.backBlock = complete;
    [self openCamera];
}

/** 相册 */
- (void)openAlbumWithComplete:(LLSelecttImageBackBlock)complete {
    [self.mediaArray removeAllObjects];
    self.backBlock = complete;
    [self openAlbum];
}

/** 相册 */
- (void)openAlbum {
    NSInteger count = 0;
    if (!_allowMultipleSelection) {
        count = _maxImageSelected - (_mediaArray.count - _selectedImageModels.count);
    }else {
        count = _maxImageSelected - _mediaArray.count;
    }
    TZImagePickerController *imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:self];
    imagePickController.navigationBar.barStyle = UIBarStyleBlack;
    imagePickController.navigationBar.barTintColor = [UIColor blackColor];
    imagePickController.navigationBar.tintColor = [UIColor blackColor];
    imagePickController.naviTitleColor = [UIColor blackColor];
    imagePickController.barItemTextColor = [UIColor blackColor];
    imagePickController.statusBarStyle = UIStatusBarStyleDefault;
    imagePickController.oKButtonTitleColorNormal = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    imagePickController.oKButtonTitleColorDisabled = [UIColor  colorMainSub];
    imagePickController.allowCrop = _allowCrop;
    imagePickController.cropRect =_cropRect;
    imagePickController.showSelectBtn = _showSelectBtn;
    
    //是否 在相册中显示拍照按钮
    imagePickController.allowTakePicture = YES;
    //是否可以选择显示原图
    imagePickController.allowPickingOriginalPhoto = NO;
    imagePickController.showSelectBtn = _showSelectBtn;
    //是否 在相册中可以选择视频
    imagePickController.allowPickingVideo = _allowPickingVideo;
    if (!_allowMultipleSelection) {
        imagePickController.selectedAssets = _selectedImageAssets;
    }
    imagePickController.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickController.edgesForExtendedLayout = YES;
    [[self viewController] presentViewController:imagePickController animated:YES completion:nil];
}

/** 相机 */
- (void)openCamera {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
        [picker setBk_didFinishPickingMediaBlock:^(UIImagePickerController *pickers, NSDictionary *tmep) {
            [self imagePickerController:pickers didFinishPickingMediaWithInfo:tmep];
        }];
        
        [picker setBk_didCancelBlock:^(UIImagePickerController *tempPicker) {
            [tempPicker dismissViewControllerAnimated:YES completion:nil];
        }];
        //设置拍照后的图片可被编辑
        picker.allowsEditing = _allowCrop;
        picker.sourceType = sourceType;

        [[self viewController] presentViewController:picker animated:YES completion:nil];
        
    }else{
        [TLUIUtility showAlertWithTitle:@"该设备不支持拍照" message:nil cancelButtonTitle:@"确定"];
    }
}




/** 身份证相册 */
- (void)openIDCardCamera:(NSInteger)type {
//    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        __weak typeof(self) weakSelf = self;
        [XYTakePhotoController presentFromVC:[self viewController] mode:type resultHandler:^(NSArray<UIImage *> * _Nonnull images, NSString * _Nonnull errorMsg) {
            
            if (images.count == 1) {
                LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
                model.image = images.firstObject;
                model.isVideo = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.mediaArray addObject:model];
                    if (weakSelf.backBlock) {
                        weakSelf.backBlock(weakSelf.mediaArray);
                    }
                });
            }else if(images.count > 1)
            {
                LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
                model.image = images.firstObject;
                model.isVideo = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.mediaArray addObject:model];
                    if (weakSelf.backBlock) {
                        weakSelf.backBlock(weakSelf.mediaArray);
                    }
                });
            }
        }];
        
    }else{
        [TLUIUtility showAlertWithTitle:@"该设备不支持拍照" message:nil cancelButtonTitle:@"确定"];
    }
}

/** 录像 */
- (void)openVideotape {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSArray * mediaTypes =[UIImagePickerController  availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = mediaTypes;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        picker.videoQuality = UIImagePickerControllerQualityTypeMedium; //录像质量
        picker.videoMaximumDuration = 600.0f; //录像最长时间
    } else {
        [TLUIUtility showAlertWithTitle:@"当前设备不支持录像" message:nil cancelButtonTitle:@"确定"];
    }
    
    [[self viewController] presentViewController:picker animated:YES completion:nil];
    
}

/** 视频 */
- (void)openVideo {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    picker.allowsEditing = YES;
    
    [[self viewController] presentViewController:picker animated:YES completion:nil];
}


- (void)showBrowser:(NSArray*)mediaArray withIndex:(NSInteger)index {
    NSMutableArray *tempArr = @[].mutableCopy;
    
    for (id image in mediaArray) {
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
        if ([image isKindOfClass:[UIImage class]]) {
            model.image = image;
        }else{
            model.imageUrlString = image;
        }
        
        [tempArr addObject:model];
    }
    
    [self showPhotoBrowser:tempArr withIndex:index];
}

- (void)showPhotoBrowser:(NSArray *)mediaArray withIndex:(NSInteger)index {
    // 展示媒体
    _photos = [NSMutableArray array];
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser setDisplayNavArrows:YES];
    browser.displayActionButton = NO;
    
    for (LLImagePickerModel *model in mediaArray) {
        MWPhoto *photo = [MWPhoto photoWithImage:model.image];
        photo.caption = model.name;
        if (model.isVideo) {
            if (model.mediaURL) {
                photo.videoURL = model.mediaURL;
            }else {
                photo = [photo initWithAsset:model.asset targetSize:CGSizeZero];
            }
        }else if (model.imageUrlString) {
            photo = [MWPhoto photoWithURL:[NSURL URLWithString:model.imageUrlString]];
        }
        [_photos addObject:photo];
    }
    [browser setCurrentPhotoIndex:index];
    [[self viewController].navigationController pushViewController:browser animated:YES];
}


#pragma mark - TZImagePickerController Delegate
//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    if ([_selectedImageAssets isEqualToArray: assets]) {
        return;
    }
    //每次回传的都是所有的asset 所以要初始化赋值
    if (!_allowMultipleSelection) {
        _selectedImageAssets = [NSMutableArray arrayWithArray:assets];
    }
    __weak typeof(self) weakSelf = self;
    NSMutableArray *models = [NSMutableArray array];
    //2次选取照片公共存在的图片
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableArray *temp2 = [NSMutableArray array];
    for (NSInteger index = 0; index < assets.count; index++) {
        PHAsset *asset = assets[index];
        [[LLImagePickerManager manager] getMediaInfoFromAsset:asset completion:^(NSString *name, id pathData) {
            
            LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
            model.name = name;
            model.uploadType = pathData;
            model.image = photos[index];
            //区分gif
            if ([NSString isGifWithImageData:pathData]) {
                model.image = [UIImage ll_setGifWithData:pathData];
            }
            
            if (!weakSelf.allowMultipleSelection) {
                //用数组是否包含来判断是不成功的。。。
                for (LLImagePickerModel *md in weakSelf.selectedImageModels) {
                    // 新方法
                    if ([md isEqual:model] ) {
                        [temp addObject:md];
                        [temp2 addObject:model];
                        break;
                    }
                }
            }
            
            [models addObject:model];
            
            if (index == assets.count - 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!weakSelf.allowMultipleSelection) {
                        //删除公共存在的，剩下的就是已经不存在的
                        [weakSelf.selectedImageModels removeObjectsInArray:temp];
                        //总媒体数组删先除掉不存在，这样不会影响排列的先后顺序
                        [weakSelf.mediaArray removeObjectsInArray:weakSelf.selectedImageModels];
                        //将这次选择的进行赋值，深复制
                        weakSelf.selectedImageModels = [models mutableCopy];
                        //这次选择的删除公共存在的，剩下的就是新添加的
                        [models removeObjectsInArray:temp2];
                        //总媒体数组中在后面添加新数据
                        [weakSelf.mediaArray addObjectsFromArray:models];
                    }else {
                        [weakSelf.selectedImageModels addObjectsFromArray:models];
                        [weakSelf.mediaArray addObjectsFromArray:models];
                    }
                    
                    if (weakSelf.backBlock) {
                        weakSelf.backBlock(weakSelf.mediaArray);
                    }
                    
                });
            }
        }];
    }
}
///选取视频后的回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    [[LLImagePickerManager manager] getMediaInfoFromAsset:asset completion:^(NSString *name, id pathData) {
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
        model.name = name;
        model.uploadType = pathData;
        model.image = coverImage;
        model.isVideo = YES;
        model.asset = asset;
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!weakSelf.allowMultipleSelection) {
                //用数组是否包含来判断是不成功的。。。
                for (LLImagePickerModel *tmp in weakSelf.selectedVideoModels) {
                    if ([tmp isEqual:model]) {
                        return ;
                    }
                }
            }
            [weakSelf.selectedVideoModels addObject:model];
            [weakSelf.mediaArray addObject:model];
            
            if (weakSelf.backBlock) {
                weakSelf.backBlock(weakSelf.mediaArray);
            }
        });
    }];
}

#pragma mark - UIImagePickerController Delegate
///拍照、选视频图片、录像 后的回调（这种方式选择视频时，会自动压缩，但是很耗时间）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //是否是push
    if (picker.presentingViewController) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [picker.navigationController popViewControllerAnimated:YES];
    }

    __weak typeof(self) weakSelf = self;
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSURL *imageAssetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    ///视频 和 录像
    if ([mediaType isEqualToString:@"public.movie"]) {
        
        NSURL *videoAssetURL = [info objectForKey:UIImagePickerControllerMediaURL];
        PHAsset *asset;
        //录像没有原图 所以 imageAssetURL 为nil
        if (imageAssetURL) {
            PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[imageAssetURL] options:nil];
            asset = [result firstObject];
        }
        [[LLImagePickerManager manager] getVideoPathFromURL:videoAssetURL PHAsset:asset enableSave:NO completion:^(NSString *name, UIImage *screenshot, id pathData) {
            LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
            model.image = screenshot;
            model.name = name;
            model.uploadType = pathData;
            model.isVideo = YES;
            model.mediaURL = videoAssetURL;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.mediaArray addObject:model];
                if (weakSelf.backBlock) {
                    weakSelf.backBlock(weakSelf.mediaArray);
                }
            });
        }];
    }
    
    else if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        //如果 picker 没有设置可编辑，那么image 为 nil
        if (image == nil) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        PHAsset *asset;
        //拍照没有原图 所以 imageAssetURL 为nil
        if (imageAssetURL) {
            PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[imageAssetURL] options:nil];
            asset = [result firstObject];
        }
        [[LLImagePickerManager manager] getImageInfoFromImage:image PHAsset:asset completion:^(NSString *name, NSData *data) {
            LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
            model.image = image;
            model.name = name;
            model.uploadType = data;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.mediaArray addObject:model];
                if (weakSelf.backBlock) {
                    weakSelf.backBlock(weakSelf.mediaArray);
                }
            });
        }];
    }
}


#pragma mark - <MWPhotoBrowserDelegate>
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}


@end
