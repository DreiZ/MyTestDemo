//
//  ZImagePickerManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZImagePickerManager.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZImageUploadOperation.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZLocationManager.h"
#import "TZAssetCell.h"
#import <MobileCoreServices/MobileCoreServices.h>

#import "AppDelegate+AppService.h"
#import "XYTakePhotoController.h"
#import "MWPhotoBrowser.h"

static ZImagePickerManager *sharedImagePickerManager;

@interface ZImagePickerManager ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MWPhotoBrowserDelegate>
{
//    __block NSMutableArray *_selectedPhotos;
//    __block NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
}
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedAssets;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, assign) BOOL showTakePhoto;  //允许拍照
@property (nonatomic, assign) BOOL showTakeVideo;  //允许拍视频
@property (nonatomic, assign) BOOL sortAscending;     //照片排列按修改时间升序
@property (nonatomic, assign) BOOL allowPickingVideo; //允许选择视频
@property (nonatomic, assign) BOOL allowPickingImage; // 允许选择图片
@property (nonatomic, assign) BOOL allowPickingGif;
@property (nonatomic, assign) BOOL allowPickingOriginalPhoto; //允许选择原图
@property (nonatomic, assign) BOOL allowCrop;
@property (nonatomic, assign) BOOL needCircleCrop;
@property (nonatomic, assign) BOOL allowPickingMuitlpleVideo;
@property (nonatomic, assign) BOOL showSelectedIndex;

@property (nonatomic, assign) BOOL showSheet; // 显示一个sheet,把拍照/拍视频按钮放在外面
@property (nonatomic, assign) NSInteger maxCount;  //照片最大可选张数，设置为1即为单选模式
@property (nonatomic, assign) NSInteger columnNumber;
@property (nonatomic, assign) CGSize cropRect;

/**
 * 需要展示的媒体的资源类型：如仅显示图片等，默认是 LLImageTypePhotoAndCamera
 */
@property (nonatomic,assign) ZImageType type;
@property (nonatomic,strong) ZSelectImageBackBlock imageBackBlock;
@property (nonatomic,strong) NSMutableArray *photos;

@end

@implementation ZImagePickerManager

+ (ZImagePickerManager *)sharedManager {
    @synchronized (self) {
        if (!sharedImagePickerManager) {
            sharedImagePickerManager = [[ZImagePickerManager alloc] init];
        }
    }
    return sharedImagePickerManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.viewController.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.viewController.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
 
    }
    return _imagePickerVc;
}

- (UIViewController *)viewController {
//    if (!_viewController) {
        _viewController = [[AppDelegate shareAppDelegate] getCurrentUIVC];
//    }
    return _viewController;
}


#pragma mark - TZImagePickerController
- (void)pushTZImagePickerController {
    if (self.maxCount <= 0) {
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount columnNumber:self.columnNumber delegate:self pushPhotoPickerVc:YES];
     imagePickerVc.barItemTextColor = [UIColor colorBlackBGDark];
     [imagePickerVc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorBlackBGDark]}];
     imagePickerVc.navigationBar.tintColor = [UIColor colorBlackBGDark];
     imagePickerVc.naviBgColor = [UIColor whiteColor];
     imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    if (self.maxCount > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = self.showTakePhoto; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = self.showTakeVideo;   // 在内部显示拍视频按
    imagePickerVc.videoMaximumDuration = 15; // 视频最大拍摄时间
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    // imagePickerVc.photoWidth = 1600;
    // imagePickerVc.photoPreviewMaxWidth = 1600;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
    }];
    /*
    [imagePickerVc setAssetCellDidSetModelBlock:^(TZAssetCell *cell, UIImageView *imageView, UIImageView *selectImageView, UILabel *indexLabel, UIView *bottomView, UILabel *timeLength, UIImageView *videoImgView) {
        cell.contentView.clipsToBounds = YES;
        cell.contentView.layer.cornerRadius = cell.contentView.tz_width * 0.5;
    }];
     */
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = self.allowPickingVideo;
    imagePickerVc.allowPickingImage = self.allowPickingImage;
    imagePickerVc.allowPickingOriginalPhoto = self.allowPickingOriginalPhoto;
    imagePickerVc.allowPickingGif = self.allowPickingGif;
    imagePickerVc.allowPickingMultipleVideo = self.allowPickingMuitlpleVideo; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = self.sortAscending;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = self.allowCrop;
    imagePickerVc.needCircleCrop = self.needCircleCrop;
    // 设置竖屏下的裁剪尺寸
    if (self.cropRect.height > 0.01 && self.cropRect.width > 0.01) {
        
        imagePickerVc.cropRect = CGRectMake((KScreenWidth - self.cropRect.width)/2.0, (KScreenHeight - self.cropRect.height)/2.0, self.cropRect.width, self.cropRect.height);
    }else{
        NSInteger left = 30;
        NSInteger widthHeight = KScreenWidth - 2 * left;
        NSInteger top = (KScreenHeight - widthHeight) / 2;
        imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    }
    imagePickerVc.scaleAspectFillCrop = YES;
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
        [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
    }];
    imagePickerVc.delegate = self;
    */
    
    // Deprecated, Use statusBarStyle
    // imagePickerVc.isStatusBarDefault = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = self.showSelectedIndex;
    
    // 设置拍照时是否需要定位，仅对选择器内部拍照有效，外部拍照的，请拷贝demo时手动把pushImagePickerController里定位方法的调用删掉
    // imagePickerVc.allowCameraLocation = NO;
    
    // 自定义gif播放方案
    [[TZImagePickerConfig sharedInstance] setGifImagePlayBlock:^(TZPhotoPreviewView *view, UIImageView *imageView, NSData *gifData, NSDictionary *info) {
        
    }];
    
    // 设置首选语言 / Set preferred language
    // imagePickerVc.preferredLanguage = @"zh-Hans";
    
    // 设置languageBundle以使用其它语言 / Set languageBundle to use other language
    // imagePickerVc.languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"tz-ru" ofType:@"lproj"]];
#pragma mark - 到这里为止
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {

    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.viewController.navigationController presentViewController:imagePickerVc animated:YES completion:nil];
}

/*
// 设置了navLeftBarButtonSettingBlock后，需打开这个方法，让系统的侧滑返回生效
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
 
    navigationController.interactivePopGestureRecognizer.enabled = YES;
    if (viewController != navigationController.viewControllers[0]) {
        navigationController.interactivePopGestureRecognizer.delegate = nil; // 支持侧滑
    }
}
*/

#pragma mark - UIImagePickerController
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self.viewController.navigationController presentViewController:alertController animated:YES completion:nil];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self.viewController.navigationController presentViewController:alertController animated:YES completion:nil];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (self.showTakeVideo) {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
        }
        if (self.showTakePhoto) {
            [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self.viewController.navigationController presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        DLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate = self.sortAscending;
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSDictionary *meta = [info objectForKey:UIImagePickerControllerMediaMetadata];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image meta:meta location:nil completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                DLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                if (self.allowCrop) { // 允许裁剪,去裁剪
                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                        [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
                    }];
                    imagePicker.allowPickingImage = YES;
                    imagePicker.needCircleCrop = self.needCircleCrop;
                    imagePicker.circleCropRadius = 100;
                    [self.viewController.navigationController presentViewController:imagePicker animated:YES completion:nil];
                } else {
                    [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                }
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:nil completion:^(PHAsset *asset, NSError *error) {
                [tzImagePickerVc hideProgressHUD];
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:photo];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        DLog(@"location:%@",phAsset.location);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - TZImagePickerControllerDelegate
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // DLog(@"cancel");
}

// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 你也可以设置autoDismiss属性为NO，选择器就不会自己dismis了
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        DLog(@"location:%@",phAsset.location);
    }
    
    // 3. 获取原图的示例，用队列限制最大并发为1，避免内存暴增
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 1;
    
    NSMutableArray *photoArr = @[].mutableCopy;
    
    if (photos.count == assets.count) {
        for (NSInteger i = 0; i < assets.count; i++) {
            PHAsset *asset = assets[i];
//            // 图片上传operation，上传代码请写到operation内的start方法里，内有注释
//            TZImageUploadOperation *operation = [[TZImageUploadOperation alloc] initWithAsset:asset completion:^(UIImage * photo, NSDictionary *info, BOOL isDegraded) {
//                if (isDegraded) return;
//                DLog(@"图片获取&上传完成");
//            } progressHandler:^(double progress, NSError * _Nonnull error, BOOL * _Nonnull stop, NSDictionary * _Nonnull info) {
//                DLog(@"获取原图进度 %f", progress);
//            }];
//            [self.operationQueue addOperation:operation];
            
            ZImagePickerModel *model = [[ZImagePickerModel alloc] init];
            model.image = photos[i];
            model.asset = asset;
            [photoArr addObject:model];
        }
        if (self.imageBackBlock) {
            self.imageBackBlock(photoArr);
        }
    }
}

// 如果用户选择了一个视频且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    
    if (_selectedAssets && _selectedPhotos) {
        [_selectedPhotos enumerateObjectsUsingBlock:^(UIImage *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZImagePickerModel *model = [[ZImagePickerModel alloc] init];
            model.asset = _selectedAssets[idx];
            model.image = obj;
            model.isVideo = YES;
            if (asset.duration > 600) {
                [TLUIUtility showAlertWithTitle:@"视频不得大于600秒"];
                if (self.imageBackBlock) {
                    self.imageBackBlock(@[]);
                }
                return;
            }
            if (self.imageBackBlock) {
                self.imageBackBlock(@[model]);
            }
        }];
    }
//
//    // 打开这段代码发送视频
//    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetHighestQuality success:^(NSString *outputPath) {
//        // NSData *data = [NSData dataWithContentsOfFile:outputPath];
//        DLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
//        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
//
//        if (self.selectedAssets && self.selectedPhotos) {
//            [self.selectedPhotos enumerateObjectsUsingBlock:^(UIImage *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                ZImagePickerModel *model = [[ZImagePickerModel alloc] init];
//                model.asset = self.selectedAssets[idx];
//                model.image = obj;
//                model.mediaURL = [NSURL fileURLWithPath:outputPath];
//                model.isVideo = YES;
//                if (self.imageBackBlock) {
//                    self.imageBackBlock(@[model]);
//                }
//            }];
//        }
//    } failure:^(NSString *errorMessage, NSError *error) {
//        DLog(@"视频导出失败:%@,error:%@",errorMessage, error);
//        if (self.imageBackBlock) {
//            self.imageBackBlock(@[]);
//        }
//    }];
}

// 如果用户选择了一个gif图片且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
}


/** 身份证相册 */
- (void)openIDCardCamera:(NSInteger)type {
//    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        __weak typeof(self) weakSelf = self;
        [XYTakePhotoController presentFromVC:self.viewController.navigationController mode:type resultHandler:^(NSArray<UIImage *> * _Nonnull images, NSString * _Nonnull errorMsg) {
            NSMutableArray *mediaArray = @[].mutableCopy;
            
            if (images.count == 1) {
                ZImagePickerModel *model = [[ZImagePickerModel alloc] init];
                model.image = images.firstObject;
                model.isVideo = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [mediaArray addObject:model];
                    if (weakSelf.imageBackBlock) {
                        weakSelf.imageBackBlock(mediaArray);
                    }
                });
            }else if(images.count > 1) {
                ZImagePickerModel *model = [[ZImagePickerModel alloc] init];
                model.image = images.firstObject;
                model.isVideo = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [mediaArray addObject:model];
                    if (weakSelf.imageBackBlock) {
                        weakSelf.imageBackBlock(mediaArray);
                    }
                });
            }
        }];
    }else{
        [TLUIUtility showAlertWithTitle:@"该设备不支持拍照" message:nil cancelButtonTitle:@"确定"];
    }
}

// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    /*
    if ([albumName isEqualToString:@"个人收藏"]) {
        return NO;
    }
    if ([albumName isEqualToString:@"视频"]) {
        return NO;
    }*/
    return YES;
}

// 决定asset显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset {
    /*
    switch (asset.mediaType) {
        case PHAssetMediaTypeVideo: {
            // 视频时长
            // NSTimeInterval duration = phAsset.duration;
            return NO;
        } break;
        case PHAssetMediaTypeImage: {
            // 图片尺寸
            if (phAsset.pixelWidth > 3000 || phAsset.pixelHeight > 3000) {
                // return NO;
            }
            return YES;
        } break;
        case PHAssetMediaTypeAudio:
            return NO;
            break;
        case PHAssetMediaTypeUnknown:
            return NO;
            break;
        default: break;
    }
     */
    return YES;
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

#pragma mark - MWPhotoBrowserDelegate
//- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
//    return _photos.count;
//}
//
//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
//    if (index < _photos.count)
//        return [_photos objectAtIndex:index];
//    return nil;
//}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_photos objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_photos replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [[self viewController] dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Click Event
- (void)setShowTakePhoto:(BOOL)showTakePhoto {
    _showTakePhoto = showTakePhoto;
    if (_showTakePhoto) {
        self.allowPickingImage = YES;
    }
}

- (void)setShowTakeVideo:(BOOL)showTakeVideo {
    _showTakeVideo = showTakeVideo;
    if (_showTakeVideo) {
        self.allowPickingVideo = YES;
    }
}

- (void)setShowSheet:(BOOL)showSheet {
    _showSheet = showSheet;
    if (_showSheet) {
        _allowPickingImage = YES;
    }
}

- (void)setAllowPickingOriginalPhoto:(BOOL)allowPickingOriginalPhoto {
    _allowPickingOriginalPhoto = allowPickingOriginalPhoto;
    if (_allowPickingOriginalPhoto) {
        self.allowPickingImage = YES;
        self.needCircleCrop = NO;
        self.allowCrop = NO;
    }
}

- (void)setAllowPickingImage:(BOOL)allowPickingImage {
    _allowPickingImage = allowPickingImage;
    if (!_allowPickingImage) {
        self.allowPickingOriginalPhoto = NO;
        self.allowPickingVideo = YES;
        self.allowPickingGif = NO;
    }
}

- (void)setAllowPickingGif:(BOOL)allowPickingGif {
    _allowPickingGif = allowPickingGif;
    if (allowPickingGif) {
        self.allowPickingImage = YES;
    }else if(!self.allowPickingVideo) {
        self.allowPickingMuitlpleVideo = NO;
    }
}

- (void)setAllowPickingVideo:(BOOL)allowPickingVideo {
    _allowPickingVideo = allowPickingVideo;
    if (!_allowPickingVideo) {
        self.allowPickingImage = YES;
        
        if (!self.allowPickingGif) {
            self.allowPickingMuitlpleVideo = NO;
        }
    }
}

- (void)setAllowCrop:(BOOL)allowCrop {
    _allowCrop = allowCrop;
    if (allowCrop) {
        self.maxCount = 1;
        self.allowPickingOriginalPhoto = NO;
    } else {
        if (self.maxCount == 1) {
            self.maxCount = 9;
        }
        self.needCircleCrop = NO;
    }
}

- (void)setNeedCircleCrop:(BOOL)needCircleCrop {
    _needCircleCrop = needCircleCrop;
    if (_needCircleCrop) {
        self.allowCrop = YES;
        self.maxCount = 1;
        self.allowPickingOriginalPhoto = NO;
    }
}

#pragma mark - Private
/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (PHAsset *asset in assets) {
        fileName = [asset valueForKey:@"filename"];
         DLog(@"图片名字:%@",fileName);
    }
}

#pragma mark - 浏览图片
- (void)showBrowser:(NSArray*)mediaArray withIndex:(NSInteger)index {
    NSMutableArray *tempArr = @[].mutableCopy;
    
    for (id image in mediaArray) {
        ZImagePickerModel *model = [[ZImagePickerModel alloc] init];
        if ([image isKindOfClass:[UIImage class]]) {
            model.image = image;
        }else{
            if (isVideo(image)) {
                model.isVideo = YES;
                model.mediaURL = [NSURL URLWithString:image];
                model.image = [[ZVideoPlayerManager sharedInstance] thumbnailImageForVideo:[NSURL URLWithString:image] atTime:0];
            }else{
                model.imageUrlString = image;
            }
        }
        [tempArr addObject:model];
    }
    
    [self showPhotoBrowser:tempArr withIndex:index];
}

- (void)showPhotoBrowser:(NSArray *)mediaArray withIndex:(NSInteger)index {
    // 展示媒体
    _photos = [NSMutableArray array];
    
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    
    for (ZImagePickerModel *model in mediaArray) {
        if (model.isVideo) {
            if (model.mediaURL) {
                MWPhoto *photo = [[MWPhoto alloc] initWithImage:[[ZVideoPlayerManager sharedInstance] thumbnailImageForVideo:model.mediaURL atTime:0]];
                photo.caption = model.name;
                photo.videoURL = model.mediaURL;
                photo.isVideo = YES;
                [_photos addObject:photo];
            }else {
                MWPhoto *photo = [[MWPhoto alloc] init];
                photo.caption = model.name;
                photo = [photo initWithAsset:model.asset targetSize:CGSizeZero];
                photo.isVideo = YES;
                [_photos addObject:photo];
            }
            
        }else if (model.imageUrlString) {
            MWPhoto *photo = [[MWPhoto alloc] init];
            photo.caption = model.name;
            photo = [MWPhoto photoWithURL:[NSURL URLWithString:model.imageUrlString]];
            [_photos addObject:photo];
        }
    }
    [browser setCurrentPhotoIndex:index];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
           nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[self viewController] presentViewController:nc animated:YES completion:nil];
//    [[self viewController].navigationController pushViewController:browser animated:YES];
}

- (void)showVideoBrowser:(PHAsset *)asset {
    // 预览视频
    TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
    TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
    vc.model = model;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.viewController presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 选择图片
- (void)setVideoWithMaxCount:(NSInteger)maxCount  SelectMenu:(ZSelectImageBackBlock)complete{
    self.maxCount = maxCount;
    self.allowPickingImage = NO;
    self.allowPickingVideo = YES;
    _type = ZImageTypeVideo;
    
    self.showTakePhoto = NO;
    self.showTakeVideo = YES;
    
    [_selectedAssets removeAllObjects];
    [_selectedPhotos removeAllObjects];
    
    [self setSelectMenu:complete];
}

- (void)setPhotoWithMaxCount:(NSInteger)maxCount  SelectMenu:(ZSelectImageBackBlock)complete {
    self.maxCount = maxCount;
    self.allowPickingImage = YES;
    self.allowPickingVideo = YES;
    _type = ZImageTypeVideo;
    
    self.showTakePhoto = YES;
    self.showTakeVideo = YES;
    
    [_selectedAssets removeAllObjects];
    [_selectedPhotos removeAllObjects];
    
    [self setSelectMenu:complete];
}

#pragma clang diagnostic pop
- (void)setCropRect:(CGSize)cropRect SelectMenu:(ZSelectImageBackBlock)complete {
    self.maxCount = 1;
    _type = ZImageTypeCardIDFontPhotoAndCamera;
    self.allowPickingImage = YES;
    self.allowPickingVideo = NO;
    
    self.allowPickingOriginalPhoto = NO;
    self.showTakePhoto = YES;
    self.showTakeVideo = NO;
    self.allowCrop = YES;
    self.cropRect = cropRect;
    self.allowPickingOriginalPhoto = NO;
    
    [_selectedAssets removeAllObjects];
    [_selectedPhotos removeAllObjects];
    
    [self setSelectMenu:complete];
}

- (void)setCardIDSelectMenu:(ZSelectImageBackBlock)complete {
    self.maxCount = 1;
    _type = ZImageTypeCardIDFontPhotoAndCamera;
    self.allowPickingImage = YES;
    self.allowPickingVideo = NO;
    
    self.allowPickingOriginalPhoto = NO;
    self.showTakePhoto = YES;
    self.showTakeVideo = NO;
    self.allowCrop = YES;
    self.cropRect = CGSizeMake(CGFloatIn750(720), CGFloatIn750(452));
    self.allowPickingOriginalPhoto = NO;
    
    [_selectedAssets removeAllObjects];
    [_selectedPhotos removeAllObjects];
    
    [self setSelectMenu:complete];
}

- (void)setAvatarSelectMenu:(ZSelectImageBackBlock)complete{
    self.maxCount = 1;
    self.allowPickingImage = YES;
    self.allowPickingVideo = NO;
    _type = ZImageTypePhotoAndCamera;
    
    self.allowPickingOriginalPhoto = NO;
    self.showTakePhoto = YES;
    self.showTakeVideo = NO;
    self.allowCrop = YES;
    self.cropRect = CGSizeMake(KScreenWidth - 60, KScreenWidth - 60);
    self.allowPickingOriginalPhoto = NO;
    
    [_selectedAssets removeAllObjects];
    [_selectedPhotos removeAllObjects];
    
    [self setSelectMenu:complete];
}

- (void)setImagesWithMaxCount:(NSInteger)maxCount  SelectMenu:(ZSelectImageBackBlock)complete{
    self.maxCount = maxCount;
    self.allowPickingImage = YES;
    self.allowPickingVideo = NO;
    _type = ZImageTypePhotoAndCamera;
    
    self.allowPickingOriginalPhoto = YES;
    self.showTakePhoto = YES;
    self.showTakeVideo = NO;
    self.allowCrop = NO;
    self.allowPickingOriginalPhoto = NO;
    
    [_selectedAssets removeAllObjects];
    [_selectedPhotos removeAllObjects];
    
    [self setSelectMenu:complete];
}

- (void)setSelectMenu:(ZSelectImageBackBlock)complete{

    self.columnNumber = 4;
    _imageBackBlock  = complete;
    
    if (_maxCount == 0) {
        [TLUIUtility showAlertWithTitle:[NSString stringWithFormat:@"已超过最大可选择数量"] message:nil cancelButtonTitle:@"确定"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    switch (_type) {
        case ZImageTypePhoto:
            [self pushTZImagePickerController];
            break;
        case ZImageTypeCamera:
            [self takePhoto];
            break;
        case ZImageTypeCardIDFontPhotoAndCamera:
        {
            [self showAlert:@[@"相册",@"相机"] selectBlock:^(NSInteger index) {
                if (index == 0){
                    [self pushTZImagePickerController];
                }else if (index == 1){
                    [weakSelf openIDCardCamera:0];
                }
            }];
        }
            break;
        case ZImageTypeCardIDBackPhotoAndCamera:
        {
            [self showAlert:@[@"相册",@"相机"] selectBlock:^(NSInteger index) {
                if (index == 0){
                    [self pushTZImagePickerController];
                }else if (index == 1){
                    [weakSelf openIDCardCamera:1];
                }
            }];
        }
                break;
        case ZImageTypePhotoAndCamera:
        {
            [self showAlert:@[@"相册",@"相机"] selectBlock:^(NSInteger index) {
                if (index == 0){
                    [weakSelf pushTZImagePickerController];
                }else if (index == 1){
                    [weakSelf takePhoto];
                }
            }];
            break;
        }
        case ZImageTypeVideoTape:
            [self takePhoto];
            break;
        case ZImageTypeVideo:
            [self pushTZImagePickerController];
            break;
        default:
        {
            [self showAlert:@[@"相册", @"相机", @"录像", @"视频"] selectBlock:^(NSInteger index) {
                if (index == 3) {
                    [weakSelf pushTZImagePickerController];
                }else if (index == 2){
                    [weakSelf takePhoto];
                }else if (index == 1){
                    [weakSelf takePhoto];
                }else if (index == 0){
                    [weakSelf pushTZImagePickerController];
                }
            }];
        }
            break;
    }
}

- (void)showAlert:(NSArray *)titleArr selectBlock:(void (^)(NSInteger))selectBlock{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    [titleArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            selectBlock(idx);
        }];
        [alertController addAction:action];
    }];
    
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
     [alertController addAction:cancelAction];
     [[self viewController] presentViewController:alertController animated:YES completion:nil];
}

- (void)getVideoOutputPathWith:(PHAsset *)asset success:(void (^)(NSString *))success failure:(void (^)(NSString *, NSError*))failure {
    // 打开这段代码发送视频
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetLowQuality success:^(NSString *outputPath) {
        // NSData *data = [NSData dataWithContentsOfFile:outputPath];
        DLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
        success(outputPath);
    } failure:^(NSString *errorMessage, NSError *error) {
        DLog(@"视频导出失败:%@,error:%@",errorMessage, error);
        failure(errorMessage, error);
    }];
}
@end
