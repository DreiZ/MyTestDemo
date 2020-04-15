//
//  ZStudentOrganizationMapAddressVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationMapAddressVC.h"
#import "POIAnnotation.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "ZLocationManager.h"

@interface ZStudentOrganizationMapAddressVC ()<MAMapViewDelegate,AMapSearchDelegate>
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *seeBtn;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *distanceLabel;

@property (nonatomic,strong) MAMapView *iMapView;
@property (nonatomic,strong) UIButton *checkSelfBtn;

@property (nonatomic,strong) MAUserLocation *cureUserLocation;
@end

@implementation ZStudentOrganizationMapAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgation];
    [self setMainView];
}

- (void)setNavgation {
    [self.navigationItem setTitle:self.detailModel.name];
}

- (void)setMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.view addSubview:self.iMapView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.nameLabel];
    [self.bottomView addSubview:self.addressLabel];
    [self.bottomView addSubview:self.distanceLabel];
    [self.bottomView addSubview:self.seeBtn];
    
    [self.iMapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.bottomView.mas_top).offset(CGFloatIn750(32));
    }];
    
    CGSize tempSize = [SafeStr(self.detailModel.address) tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(60), CGFloatIn750(60))];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(CGFloatIn750(32));
        make.height.mas_equalTo(CGFloatIn750(316 + 32) + safeAreaBottom() + tempSize.height);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(40));
        make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(40));
        make.top.equalTo(self.bottomView.mas_top).offset(CGFloatIn750(40));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(40));
        make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(40));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(26));
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(40));
        make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(40));
        make.top.equalTo(self.addressLabel.mas_bottom).offset(CGFloatIn750(14));
    }];
    
    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(40));
        make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(40));
        make.top.equalTo(self.distanceLabel.mas_bottom).offset(CGFloatIn750(40));
        make.height.mas_equalTo(CGFloatIn750(68));
    }];
    
    [self setData];
}

- (void)setLocation {
    // 开启定位
    self.iMapView.showsUserLocation = YES;
    self.iMapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)setData {
    self.nameLabel.text = self.detailModel.name;
    self.addressLabel.text = self.detailModel.address;
    
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.detailModel.latitude doubleValue], [self.detailModel.longitude doubleValue]);
    [self.iMapView setCenterCoordinate:coordinate];
    MAPointAnnotation *pin1 = [[MAPointAnnotation alloc] init];
    pin1.coordinate =  coordinate;
    pin1.lockedScreenPoint = CGPointMake(SCREEN_WIDTH/2, CGFloatIn750(230));
    [_iMapView addAnnotation:pin1];
    
    
    CLLocationCoordinate2D loc1 = coordinate;
    CLLocationCoordinate2D loc2 = self.cureUserLocation.coordinate;
    
    MAMapPoint p1 = MAMapPointForCoordinate(loc1);
    MAMapPoint p2 = MAMapPointForCoordinate(loc2);
    
    CLLocationDistance distance =  MAMetersBetweenMapPoints(p1, p2);
    if (distance < 1000) {
        self.distanceLabel.text = [NSString stringWithFormat:@"距离您%.0fm",distance];
    }else{
        self.distanceLabel.text = [NSString stringWithFormat:@"距离您%.2fkm",distance/1000];
    }
    
}

#pragma mark - lazy loading
- (UIButton *)checkSelfBtn {
    if (!_checkSelfBtn) {
        __weak  typeof(self) weakSelf = self;
        UIImage *checkSelfImage = [UIImage imageNamed:@"hng_im_lbs_self"];
        _checkSelfBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, checkSelfImage.size.width, checkSelfImage.size.height)];
        [_checkSelfBtn setBackgroundImage:checkSelfImage forState:UIControlStateNormal];
        [_checkSelfBtn bk_whenTapped:^{
            [weakSelf.iMapView setCenterCoordinate:weakSelf.cureUserLocation.location.coordinate animated:YES];
        }];
    }
    return _checkSelfBtn;
}

- (MAMapView *)iMapView {
    if (!_iMapView) {
        _iMapView = [[MAMapView alloc] init];
        _iMapView.delegate = self;
        [_iMapView setCenterCoordinate:CLLocationCoordinate2DMake(39.992520, 116.336170)];
        
        _iMapView.showsUserLocation = YES;
        _iMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _iMapView.zoomLevel = 19;
        _iMapView.userTrackingMode = MAUserTrackingModeNone;
        [_iMapView addSubview:self.checkSelfBtn];
        [self.checkSelfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.iMapView.mas_right).offset(CGFloatIn750(-10));
            make.bottom.equalTo(self.iMapView.mas_bottom).offset(-CGFloatIn750(46));
        }];
    }
    return _iMapView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        ViewRadius(_bottomView, CGFloatIn750(32));
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _bottomView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _addressLabel.numberOfLines = 0;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [_addressLabel setFont:[UIFont fontSmall]];
    }
    return _addressLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _distanceLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _distanceLabel.numberOfLines = 1;
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        [_distanceLabel setFont:[UIFont fontSmall]];
    }
    return _distanceLabel;
}


- (UIButton *)seeBtn {
    if (!_seeBtn) {
        _seeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _seeBtn.layer.masksToBounds = YES;
        _seeBtn.layer.cornerRadius = CGFloatIn750(34);
        _seeBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_seeBtn setTitle:@"查看路线" forState:UIControlStateNormal];
        [_seeBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_seeBtn.titleLabel setFont:[UIFont fontContent]];
        
        __weak typeof(self) weakSelf = self;
        [_seeBtn bk_whenTapped:^{
            [weakSelf gotoMap];
        }];
    }
    return _seeBtn;
}


#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    _cureUserLocation = userLocation;
    
    [_iMapView setCenterCoordinate:userLocation.location.coordinate animated:NO];
    UIImage *lbsImage = [UIImage imageNamed:@"hng_im_lbs_ann"];
    UIImageView *lbsImageView = [[UIImageView alloc] initWithImage:lbsImage];
    lbsImageView.center  = CGPointMake(self.iMapView.center.x, self.iMapView.center.y-64-70);
    [self.iMapView addSubview:lbsImageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        lbsImageView.center  = CGPointMake(self.iMapView.center.x, self.iMapView.center.y-64);
    }];
}
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
//        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
//        }
//
//        annotationView.canShowCallout               = YES;
//        annotationView.animatesDrop                 = YES;
//        annotationView.draggable                    = YES;
//        annotationView.rightCalloutAccessoryView    = nil;
//        annotationView.pinColor                     = MAPinAnnotationColorRed;
//
//        return annotationView;
//    }
//
    return nil;
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState {
    if(newState == MAAnnotationViewDragStateEnding) {
//        CLLocationCoordinate2D loc1 = self.pin1.coordinate;
//        CLLocationCoordinate2D loc2 = self.pin2.coordinate;
//
//        MAMapPoint p1 = MAMapPointForCoordinate(loc1);
//        MAMapPoint p2 = MAMapPointForCoordinate(loc2);
//
//        CLLocationDistance distance =  MAMetersBetweenMapPoints(p1, p2);
//
//        [self.view makeToast:[NSString stringWithFormat:@"distance between two pins = %.2f", distance] duration:1.0];
    }
}



#pragma mark - 去地图展示路线
/** 去地图展示路线 */
- (void)gotoMap{
    // 后台返回的目的地坐标是百度地图的
    // 百度地图与高德地图、苹果地图采用的坐标系不一样，故高德和苹果只能用地名不能用后台返回的坐标
    CGFloat latitude  = self.cureUserLocation.location.coordinate.latitude;  // 纬度
    CGFloat longitude = self.cureUserLocation.location.coordinate.longitude; // 经度
    NSString *address = self.detailModel.name; // 送达地址
    
    // 打开地图的优先级顺序：高德地图-->百度地图->苹果地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
           // 高德地图
           // 起点为“我的位置”，终点为后台返回的address
        NSString *urlString = @"";
        if (self.cureUserLocation) {
            urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&did=&dlat=%@&dlon=%@&dname=%@&dev=0&t=0",self.detailModel.latitude,self.detailModel.longitude,self.detailModel.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else{
            urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=&slat=%f&slon=%f&sname=%@&did=&dlat=%@&dlon=%@&dname=%@&dev=0&t=0",latitude,longitude,@"我的位置",self.detailModel.latitude,self.detailModel.longitude,self.detailModel.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        // 百度地图
        // 起点为“我的位置”，终点为后台返回的坐标
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=%f,%f&mode=riding&src=%@", latitude, longitude,address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com"]]){
        // 苹果地图
        // 起点为“我的位置”，终点为后台返回的address
        NSString *urlString = [[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%@",address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }else{
        // 快递员没有安装上面三种地图APP，弹窗提示安装地图APP
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请安装地图APP" message:@"建议安装高德地图APP" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:NO completion:nil];
    }
}

-(CLLocationCoordinate2D)gcj02_To_Bd09:(CLLocationCoordinate2D)coordinate {
    double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    double x = coordinate.longitude, y = coordinate.latitude;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    double tempLon = z * cos(theta) + 0.0065;
    double tempLat = z * sin(theta) + 0.006;
    CLLocationCoordinate2D gps = CLLocationCoordinate2DMake(tempLat, tempLon);
    return gps;
}
@end
