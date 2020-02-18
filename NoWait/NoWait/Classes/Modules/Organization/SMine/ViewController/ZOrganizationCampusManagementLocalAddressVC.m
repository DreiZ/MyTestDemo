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

#import "ZCellConfig.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>


@interface ZOrganizationCampusManagementLocalAddressVC ()<UITableViewDelegate, UITableViewDataSource,MAMapViewDelegate>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) ZOrganizationAddressSearchTopView *topSearchView;
@property (nonatomic,strong) MAMapView *iMapView;
@property (nonatomic,strong) UIButton *checkSelfBtn;

@property (nonatomic,strong) MAUserLocation *cureUserLocation;
@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZOrganizationCampusManagementLocalAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self initCellConfigArr];
    [self setupMainView];
}

- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
    
//
//    ZCellConfig *campusCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationCampusCell className] title:@"school" showInfoMethod:nil heightOfCell:[ZOrganizationCampusCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
//    [self.cellConfigArr addObject:campusCellConfig];

    ZCellConfig *campusCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAddressLocationCell className] title:@"school" showInfoMethod:nil heightOfCell:[ZOrganizationAddressLocationCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:campusCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"选择地址"];
}

- (void)setupMainView {
    
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
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.iMapView.mas_bottom).offset(-10);
    }];
    
    
//    [self.iMapView setZoomLevel:216.1 animated:YES];
    
    
}

#pragma mark lazy loading...
-(ZOrganizationAddressSearchTopView *)topSearchView {
    if (!_topSearchView) {
        _topSearchView = [[ZOrganizationAddressSearchTopView alloc] init];
    }
    return _topSearchView;
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
            make.bottom.equalTo(self.iMapView.mas_bottom).offset(-CGFloatIn750(10));
        }];
    }
    return _iMapView;
}

-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = [UIColor clearColor];
    }
    return _iTableView;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
//        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"保存设置" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontTitle]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{

        }];
    }
    return _bottomBtn;
}


#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZOrganizationRadiusCell"]){
        ZOrganizationRadiusCell *enteryCell = (ZOrganizationRadiusCell *)cell;
        enteryCell.leftMargin = CGFloatIn750(0);
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"address"]) {
        
    }else if ([cellConfig.title isEqualToString:@"type"]) {
        
    }
    
    
}

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
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



