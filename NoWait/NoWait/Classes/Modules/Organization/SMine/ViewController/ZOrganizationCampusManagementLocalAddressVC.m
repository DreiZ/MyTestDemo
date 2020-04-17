//
//  ZOrganizationCampusManagementLocalAddressVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCampusManagementLocalAddressVC.h"
#import "ZOrganizationAddressSearchTopView.h"
#import "ZAlertDataModel.h"
#import "ZOrganizationAddressLocationCell.h"
#import "ZOrganizationRadiusCell.h"
#import "ZOrganizationAddressSearchView.h"

#import "ZCellConfig.h"
#import "POIAnnotation.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>


@interface ZOrganizationCampusManagementLocalAddressVC ()<MAMapViewDelegate,AMapSearchDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) ZOrganizationAddressSearchTopView *topSearchView;
@property (nonatomic,strong) MAMapView *iMapView;
@property (nonatomic,strong) UIButton *checkSelfBtn;
@property (nonatomic,strong) AMapSearchAPI *search;
@property (nonatomic,strong) ZOrganizationAddressSearchView *searhView;

@property (nonatomic,strong) ZLocationModel *location;
@property (nonatomic,strong) MAUserLocation *cureUserLocation;
@property (nonatomic,assign) BOOL isLocation;
@end

@implementation ZOrganizationCampusManagementLocalAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    
    self.search.timeout = 30;
    [self searchPoiByCenterCoordinate];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
//
//    ZCellConfig *campusCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusCell className] title:@"school" showInfoMethod:nil heightOfCell:[ZOrganizationCampusCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
//    [self.cellConfigArr addObject:campusCellConfig];

    for (int i = 0; i < self.dataSources.count; i++) {
        POIAnnotation *annotation = self.dataSources[i];
        ZLocationModel *model = [[ZLocationModel alloc] init];
        model.coordinate = annotation.coordinate;
        model.distance = annotation.poi.distance;
        model.city = annotation.poi.citycode;
        model.province = annotation.poi.pcode;
        model.district = annotation.poi.adcode;
        model.businessArea = [NSString stringWithFormat:@"%@%@%@%@",annotation.poi.province,annotation.poi.city,annotation.poi.district,annotation.poi.address];
        model.name = annotation.poi.name;
        model.address = annotation.poi.name;
        if (i == 0) {
            _location = model;
        
        }
        
        ZCellConfig *campusCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAddressLocationCell className] title:@"location" showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationAddressLocationCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:campusCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"选择地址"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.topSearchView];
    [self.topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(100));
    }];
    
    [self.view addSubview:self.iMapView];
    [self.iMapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topSearchView.mas_bottom);
        make.height.mas_equalTo(CGFloatIn750(460));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.iMapView.mas_bottom).offset(-10);
    }];
    
    [self.view addSubview:self.searhView];
    [_searhView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.topSearchView.mas_bottom);
    }];
    self.searhView.hidden = YES;
    
//    [self.iMapView setZoomLevel:216.1 animated:YES];
    UIImage *lbsImage = [UIImage imageNamed:@"hng_im_lbs_ann"];
    UIImageView *lbsImageView = [[UIImageView alloc] initWithImage:lbsImage];
    lbsImageView.center  = CGPointMake(self.iMapView.center.x, self.iMapView.center.y-64-70);
    [self.iMapView addSubview:lbsImageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        lbsImageView.center  = CGPointMake(self.iMapView.center.x, self.iMapView.center.y-64);
    }];
}

#pragma mark lazy loading...
-(ZOrganizationAddressSearchTopView *)topSearchView {
    if (!_topSearchView) {
        __weak typeof(self) weakSelf = self;
        _topSearchView = [[ZOrganizationAddressSearchTopView alloc] init];
        _topSearchView.iTextField.delegate = self;
        _topSearchView.cancleBlock = ^{
            weakSelf.searhView.hidden = YES;
        };
        _topSearchView.textChangeBlock = ^(NSString * text) {
            [weakSelf searchPoiByKeyword:text];
        };
    }
    return _topSearchView;
}

- (ZOrganizationAddressSearchView *)searhView {
    if (!_searhView) {
        __weak typeof(self) weakSelf = self;
        _searhView = [[ZOrganizationAddressSearchView alloc] init];
        _searhView.addressBlock = ^(ZLocationModel *model) {
            weakSelf.location = model;
            if (weakSelf.addressBlock) {
                weakSelf.addressBlock(weakSelf.location.province, weakSelf.location.city, weakSelf.location.district, weakSelf.location.businessArea, weakSelf.location.address,weakSelf.location.coordinate.latitude,weakSelf.location.coordinate.longitude);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _searhView;
}

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
        _iMapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, CGFloatIn750(100), KScreenWidth, CGFloatIn750(460))];
        _iMapView.delegate = self;
//        MAPointAnnotation *pin1 = [[MAPointAnnotation alloc] init];
//        pin1.coordinate =  CLLocationCoordinate2DMake(39.992520, 116.336170);
//        pin1.lockedScreenPoint = CGPointMake(SCREEN_WIDTH/2, CGFloatIn750(230));
//        [_iMapView setCenterCoordinate:CLLocationCoordinate2DMake(39.992520, 116.336170)];
//        [_iMapView addAnnotation:pin1];
        _iMapView.showsUserLocation = YES;
        _iMapView.zoomLevel = 15;
        _iMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        _iMapView.zoomLevel = 1;
        [_iMapView addSubview:self.checkSelfBtn];
        [self.checkSelfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.iMapView.mas_right).offset(CGFloatIn750(-10));
            make.bottom.equalTo(self.iMapView.mas_bottom).offset(-CGFloatIn750(10));
        }];
    }
    return _iMapView;
}

- (AMapSearchAPI *)search {
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
        
    }
    return _search;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"保存设置" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontTitle]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            if (weakSelf.addressBlock) {
                weakSelf.addressBlock(weakSelf.location.province, weakSelf.location.city, weakSelf.location.district, weakSelf.location.businessArea, weakSelf.location.address,weakSelf.location.coordinate.latitude,weakSelf.location.coordinate.longitude);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _bottomBtn;
}


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationRadiusCell"]){
        ZOrganizationRadiusCell *enteryCell = (ZOrganizationRadiusCell *)cell;
        enteryCell.leftMargin = CGFloatIn750(0);
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ( [cellConfig.title isEqualToString:@"ZOrganizationAddressLocationCell"] || [cellConfig.title isEqualToString:@"location"]){
        ZLocationModel *model = cellConfig.dataModel;
        self.location = model;
        if (self.addressBlock) {
            self.addressBlock(self.location.province, self.location.city, self.location.district, self.location.businessArea, self.location.address,self.location.coordinate.latitude,self.location.coordinate.longitude);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    _cureUserLocation = userLocation;
    if (!_isLocation) {
        _isLocation = YES;
        [_iMapView setCenterCoordinate:userLocation.location.coordinate animated:NO];
        [self searchPoiByCenterCoordinate];
    }
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

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    NSLog(@"0000");
    [self searchPoiByCenterCoordinate];
}


#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        
    }];
    
    /* 将结果以annotation的形式加载到地图上. */
//    [self.iMapView addAnnotations:poiAnnotations];
    [self.dataSources removeAllObjects];
    for (int i = 0; i < (poiAnnotations.count > 10 ? 10 : poiAnnotations.count); i++) {
        [self.dataSources addObject:poiAnnotations[i]];
    }
    /* 如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        [self.iMapView setCenterCoordinate:[poiAnnotations[0] coordinate]];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
//        [self.iMapView showAnnotations:poiAnnotations animated:NO];
    }
    self.searhView.iPOIAnnotations = poiAnnotations;
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


/* 根据中心点坐标来搜周边的POI. */
- (void)searchPoiByCenterCoordinate
{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:self.iMapView.centerCoordinate.latitude longitude:self.iMapView.centerCoordinate.longitude];
//    request.keywords            = @"电影院";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    
    [self.search AMapPOIAroundSearch:request];
}

/* 根据关键字来搜索POI. */
- (void)searchPoiByKeyword:(NSString *)keyword
{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = keyword;
//    request.keywords            = @"北京大学";
//    request.city                = @"北京";
//    request.types               = @"高等院校";
//    request.requireExtension    = YES;
//
//    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
//    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    
    [self.search AMapPOIKeywordsSearch:request];
}

#pragma mark - -textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    NSLog(@"donggggs-----");
    [self searchPoiByKeyword:textField.text];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.searhView.hidden = NO;
}

@end
