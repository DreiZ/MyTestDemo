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
    
    
    [self setMainView];
}

- (void)setNavgation {
    [self.navigationItem setTitle:@"才玩俱乐部"];
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
    
    
    CGSize tempSize = [@"放声大哭高呢让那个人那个人那个蓝色让你哈里森哈里森然后嘞对方两个女生读后感" tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(60), CGFloatIn750(60))];
    
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
        MAPointAnnotation *pin1 = [[MAPointAnnotation alloc] init];
        pin1.coordinate =  CLLocationCoordinate2DMake(39.992520, 116.336170);
        pin1.lockedScreenPoint = CGPointMake(SCREEN_WIDTH/2, CGFloatIn750(230));
        [_iMapView setCenterCoordinate:CLLocationCoordinate2DMake(39.992520, 116.336170)];
        [_iMapView addAnnotation:pin1];
        _iMapView.showsUserLocation = YES;
        _iMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _iMapView.zoomLevel = 19;
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
        _nameLabel.text = @"大师傅俱乐部";
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
        _addressLabel.text = @"放声大哭高呢让那个人那个人那个蓝色让你哈里森哈里森然后嘞对方两个女生读后感";
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
        _distanceLabel.text = @"距离234开始噶按个";
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
        _seeBtn.backgroundColor = [UIColor colorMain];
        [_seeBtn setTitle:@"查看路线" forState:UIControlStateNormal];
        [_seeBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_seeBtn.titleLabel setFont:[UIFont fontContent]];
        
//        __weak typeof(self) weakSelf = self;
        [_seeBtn bk_whenTapped:^{
            
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


@end
