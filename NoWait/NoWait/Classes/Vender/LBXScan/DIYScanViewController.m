//
//  DIYScanViewController.m
//  LBXScanDemo
//
//  Created by lbxia on 2017/6/5.
//  Copyright © 2017年 lbx. All rights reserved.
//

#import "DIYScanViewController.h"
#import <LBXScanViewStyle.h>
#import "ZAlertView.h"
#import "LBXPermission.h"
#import "Global.h"
#import "ZMineModel.h"
#import "ZOrganizationStudentJionInLessonVC.h"
#import "ZSignViewModel.h"

@interface DIYScanViewController ()
@property (nonatomic,strong) UIButton *fromPhotoBtn;
@property (nonatomic,strong) UIButton *btnFlash;
@property (nonatomic,strong) UIButton *btnPhoto;

@end

@implementation DIYScanViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.style = [self OnStyle];
    self.isOpenInterestRect = YES;
    self.libraryType = SLT_Native;
    self.scanCodeType = SCT_QRCode;
    self.cameraInvokeMsg = @"相机启动中";
    
    [self.navigationItem setTitle:@"扫码中"];
    
    [self.view addSubview:self.btnFlash];
    [self.btnFlash mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(-CGFloatIn750(100));
        make.top.equalTo(self.view.mas_centerY).offset(CGFloatIn750(0) + (KScreenWidth - 120)/2);
        make.width.mas_equalTo(CGFloatIn750(80));
        make.height.equalTo(self.btnFlash.mas_width).multipliedBy(174.0/130.0f);
    }];
    
    [self.view addSubview:self.btnPhoto];
    [self.btnPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(CGFloatIn750(100));
        make.top.equalTo(self.view.mas_centerY).offset(CGFloatIn750(0) + (KScreenWidth - 120)/2);
        make.width.mas_equalTo(CGFloatIn750(80));
        make.height.equalTo(self.btnFlash.mas_width).multipliedBy(174.0/130.0f);
    }];
}

- (void)viewDidLayoutSubviews {
    [self.view bringSubviewToFront:self.btnPhoto];
    [self.view bringSubviewToFront:self.btnFlash];
}

#pragma mark - lazyloading
- (LBXScanViewStyle*)OnStyle
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.isNeedShowRetangle = YES;
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    style.colorRetangleLine = [UIColor colorMain];
    style.colorAngle = [UIColor colorMain];
    
    //使用的支付宝里面网格图片
    UIImage *imgPartNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];
    style.animationImage = imgPartNet;
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];

    
    return style;
}

-(UIButton *)btnFlash {
    if (!_btnFlash) {
        _btnFlash = [[UIButton alloc]init];
         [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
        [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];

    }
    return _btnFlash;
}

- (UIButton *)btnPhoto {
    if (!_btnPhoto) {
        _btnPhoto = [[UIButton alloc]init];
        _btnPhoto.bounds = _btnFlash.bounds;
        [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
        [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
        [_btnPhoto addTarget:self action:@selector(openLocalPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];

    }
    return _btnPhoto;;
}


#pragma mark -实现类继承该方法，作出对应处理
//开关闪光灯
- (void)openOrCloseFlash
{
    [super openOrCloseFlash];
   
    if (self.isOpenFlash)
    {
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    }
    else
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
}


- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (!array ||  array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以ZXing同时识别2个二维码，不能同时识别二维码和条形码
    //    for (LBXScanResult *result in array) {
    //
    //        DLog(@"scanResult:%@",result.strScanned);
    //    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //TODO: 这里可以根据需要自行添加震动或播放声音提示相关代码
    //...
    
    [self showNextVCWithScanResult:scanResult];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    
    __weak __typeof(self) weakSelf = self;
    [ZAlertView setAlertWithTitle:@"扫码内容" btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
        [weakSelf reStartDevice];
    }];
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    if (strResult && strResult.strScanned) {
        NSString *temp = strResult.strScanned;
        NSDictionary *dict = [temp zz_JSONValue];
        if (ValidDict(dict)) {
            if ([dict objectForKey:@"source_type"] && [dict[@"source_type"] isEqualToString:@"xiangcenter.com"]) {
                ZQRCodeMode *mainModel = [ZQRCodeMode mj_objectWithKeyValues:dict];
                NSInteger now = [[NSDate new] timeIntervalSince1970];
                NSLog(@"Date--%@",mainModel.timestamp);
                if (now - [mainModel.timestamp intValue] > 3600*24*7) {
                    [ZAlertView setAlertWithTitle:@"二维码已过期" btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
                        
                    }];
                    return;
                }
                if ([mainModel.qrcode_type intValue] == 2) {
                    if ([[ZUserHelper sharedHelper].user.type intValue] == 1) {
                        ZQRCodeAddStudentMode *model = [ZQRCodeAddStudentMode mj_objectWithKeyValues:dict];
                        ZOrganizationStudentJionInLessonVC *lvc = [[ZOrganizationStudentJionInLessonVC alloc] init];
                        lvc.viewModel.addModel.stores_courses_class_id = model.course_id;
                        lvc.viewModel.addModel.teacher_id = model.teacher_id;
                        lvc.viewModel.addModel.stores_id = model.stores_id;
                        lvc.viewModel.addModel.total_progress = model.course_number;
                        lvc.viewModel.addModel.code_id = [ZUserHelper sharedHelper].user.userCodeID;
                        

                        lvc.viewModel.addModel.courses_image = model.course_image;
                        lvc.viewModel.addModel.courses_name = model.course_name;
                        lvc.viewModel.addModel.stores_name = model.stores_name;
                        lvc.viewModel.addModel.coach_img = model.teacher_image;
                        lvc.viewModel.addModel.teacher_name = model.teacher_name;
                        lvc.viewModel.addModel.teacher_name = model.teacher_nick_name;
                        [self.navigationController pushViewController:lvc animated:YES];
                    }else{
                        [TLUIUtility showErrorHint:@"非学员端不可加入课程"];
                    }
                }else if([mainModel.qrcode_type intValue] == 3){
                    if ([[ZUserHelper sharedHelper].user.type intValue] == 1) {
                        ZQRCodeAddStudentMode *model = [ZQRCodeAddStudentMode mj_objectWithKeyValues:dict];
                        ZOrganizationStudentJionInLessonVC *lvc = [[ZOrganizationStudentJionInLessonVC alloc] init];
                        lvc.viewModel.addModel.courses_class_id = model.courses_class_id;
                        lvc.viewModel.addModel.stores_id = model.stores_id;
                        lvc.viewModel.addModel.phone = [ZUserHelper sharedHelper].user.phone;
                        
                        [self.navigationController pushViewController:lvc animated:YES];
                    }else{
                        [TLUIUtility showErrorHint:@"非学员端不可加入课程"];
                    }
                }else if ([mainModel.qrcode_type intValue] == 1){
                    if ([[ZUserHelper sharedHelper].user.type intValue] == 2) {
                        ZQRCodeStudentSignMode *model = [ZQRCodeStudentSignMode mj_objectWithKeyValues:dict];
                        
                        NSMutableDictionary *param = @{}.mutableCopy;
                        [param setObject:model.courses_class_id forKey:@"courses_class_id"];
                        [param setObject:@"1" forKey:@"type"];
                        
                        
                        NSMutableArray *ids = @[].mutableCopy;
                        [ids addObject:@{@"student_id":model.student_id,@"nums":SafeStr(model.nums)}];
                        
                        [param setObject:ids forKey:@"students"];
                        [ZSignViewModel teacherSign:param completeBlock:^(BOOL isSuccess, id data) {
                            if (isSuccess) {
                                [ZAlertView setAlertWithTitle:data btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
                                    
                                }];
                            }else{
                                [TLUIUtility showErrorHint:data];
                            }
                        }];
                    }else{
                        [TLUIUtility showErrorHint:@"非教师端不可加入课程"];
                    }
                }
            }
        }else{
            [ZAlertView setAlertWithTitle:@"二维码不是本应用二维码" btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
                
            }];
        }
    }
    
}

- (UIButton *)fromPhotoBtn {
    if (!_fromPhotoBtn) {
        _fromPhotoBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_fromPhotoBtn setTitle:@"从相册识别" forState:UIControlStateNormal];
        [_fromPhotoBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_fromPhotoBtn.titleLabel setFont:[UIFont boldFontTitle]];
        [_fromPhotoBtn addTarget:self action:@selector(openLocalPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fromPhotoBtn;
}

- (void)openLocalPhotoAlbum
{
    __weak __typeof(self) weakSelf = self;
    [LBXPermission authorizeWithType:LBXPermissionType_Photos completion:^(BOOL granted, BOOL firstTime) {
        if (granted) {
            [weakSelf openLocalPhoto];
        }
        else if (!firstTime )
        {
            [LBXPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相册权限，是否前往设置" cancel:@"取消" setting:@"设置"];
        }
    }];
}

/*!
 *  打开本地照片，选择图片识别
 */
- (void)openLocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    //部分机型可能导致崩溃
    picker.allowsEditing = YES;
    
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    switch ([Global sharedManager].libraryType) {
        case SLT_Native:
        {
            if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
            {
                //ios8.0之后支持
                __weak __typeof(self) weakSelf = self;
                [LBXScanNative recognizeImage:image success:^(NSArray<LBXScanResult *> *array) {
                    [weakSelf scanResultWithArray:array];
                }];
            }
            else
            {
                [TLUIUtility showErrorHint:@"native低于ios8.0不支持识别图片"];
            }
        }
            break;
        
        default:
            break;
    }
}

@end


#pragma mark - RouteHandler
@interface DIYScanViewController (RouteHandler)<SJRouteHandler>

@end

@implementation DIYScanViewController (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_diyScan;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    DIYScanViewController *routevc = [[DIYScanViewController alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
