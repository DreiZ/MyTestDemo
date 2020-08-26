//
//  ZAnnotationClusterVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAnnotationClusterVC.h"

#import "ZCoordinateQuadTree.h"
#import "ZClusterAnnotation.h"

#import "ZClusterAnnotationView.h"
#import "ZClusterTableViewCell.h"
#import "ZCustomCalloutView.h"

#import "ZStudentMainModel.h"
#import "ZOriganizationModel.h"
#import <HWPanModal/HWPanModal.h>
#import "ZMapSchoolListVC.h"
#import "ZStudentMainViewModel.h"
#import "ZLocationManager.h"
#import "ZAlertView.h"

#define kCalloutViewMargin  -12
#define Button_Height       70.0

@interface ZAnnotationClusterVC ()

@property (nonatomic, strong) ZCoordinateQuadTree* coordinateQuadTree;
@property (nonatomic, strong) MAUserLocation *cureUserLocation;

@property (nonatomic, strong) ZCustomCalloutView *customCalloutView;
@property (nonatomic, strong) UIButton *navLeftBtn;
@property (nonatomic, strong) UIButton *checkSelfBtn;


@property (nonatomic, strong) NSMutableArray *selectedPoiArray;

@property (nonatomic, assign) BOOL shouldRegionChangeReCalculate;

@property (nonatomic, strong) AMapPOIKeywordsSearchRequest *currentRequest;
@property (nonatomic, strong) dispatch_queue_t queue;


@property (nonatomic, strong) NSArray *pois;

@property (nonatomic, strong) NSString *type;//10.7(市)  10.85(大区) 12.5(小区)  14.5(详细)
@property (nonatomic, strong) ZRegionNetModel *regionModel;
@property (nonatomic, assign) BOOL loadFromLocalHistory;
@end

@implementation ZAnnotationClusterVC

#pragma mark - update Annotation

/* 更新annotation. */
- (void)updateMapViewAnnotationsWithAnnotations:(NSArray *)annotations {
    /* 用户滑动时，保留仍然可用的标注，去除屏幕外标注，添加新增区域的标注 */
    NSMutableSet *before = [NSMutableSet setWithArray:self.mapView.annotations];
    [before removeObject:[self.mapView userLocation]];
    NSSet *after = [NSSet setWithArray:annotations];
    
    /* 保留仍然位于屏幕内的annotation. */
    NSMutableSet *toKeep = [NSMutableSet setWithSet:before];
    [toKeep intersectSet:after];
    
    /* 需要添加的annotation. */
    NSMutableSet *toAdd = [NSMutableSet setWithSet:after];
    [toAdd minusSet:toKeep];
    
    /* 删除位于屏幕外的annotation. */
    NSMutableSet *toRemove = [NSMutableSet setWithSet:before];
    [toRemove minusSet:after];
    
    /* 更新. */
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapView addAnnotations:[toAdd allObjects]];
        [self.mapView removeAnnotations:[toRemove allObjects]];
    });
}

- (void)addAnnotationsToMapView:(MAMapView *)mapView {
    @synchronized(self)
    {
        if (self.coordinateQuadTree.root == nil || !self.shouldRegionChangeReCalculate)
        {
            NSLog(@"tree is not ready.");
            return;
        }
        
        /* 根据当前zoomLevel和zoomScale 进行annotation聚合. */
        MAMapRect visibleRect = self.mapView.visibleMapRect;
//        double zoomScale = self.mapView.bounds.size.width / visibleRect.size.width;
//        double zoomLevel = self.mapView.zoomLevel;
//
        /* 也可根据zoomLevel计算指定屏幕距离(以50像素为例)对应的实际距离 进行annotation聚合. */
        /* 使用：NSArray *annotations = [weakSelf.coordinateQuadTree clusteredAnnotationsWithinMapRect:visibleRect withDistance:distance]; */
        //double distance = 50.f * [self.mapView metersPerPointForZoomLevel:self.mapView.zoomLevel];
        double distance = 50.f * [self.mapView metersPerPointForZoomLevel:self.mapView.zoomLevel];
        __weak typeof(self) weakSelf = self;
        dispatch_barrier_async(self.queue, ^{
//            NSArray *annotations = [weakSelf.coordinateQuadTree clusteredAnnotationsWithinMapRect:visibleRect withZoomScale:zoomScale andZoomLevel:zoomLevel];
            NSArray *annotations = [weakSelf.coordinateQuadTree clusteredAnnotationsWithinMapRect:visibleRect withDistance:distance];
            dispatch_async(dispatch_get_main_queue(), ^{
                /* 更新annotation. */
                [weakSelf updateMapViewAnnotationsWithAnnotations:annotations];
            });
        });
    }
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    _cureUserLocation = userLocation;
}

- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction {
    NSLog(@"mapView.zoomLevel      %f",mapView.zoomLevel);
    
//    type;//10.7(市)  12.0(大区) 13.0(小区)  14.5(详细)
    if (mapView.zoomLevel < 10.7) {
        if (![_type isEqualToString:@"0"]) {
            _type = @"0";
            [self updateAnnotations];
        }
    }else if (mapView.zoomLevel < 10.7) {
        if (![_type isEqualToString:@"1"]) {
            _type = @"1";
            [self updateAnnotations];
        }
    }else if (mapView.zoomLevel < 13.01) {
        if (![_type isEqualToString:@"2"]) {
            _type = @"2";
            [self updateAnnotations];
        }
    }else if (mapView.zoomLevel < 14.5) {
        if (![_type isEqualToString:@"3"]) {
            _type = @"3";
            [self updateAnnotations];
        }
    }else {
        if (![_type isEqualToString:@"4"]) {
            _type = @"4";
            [self updateAnnotations];
        }
    }
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    [self.selectedPoiArray removeAllObjects];
    [self.customCalloutView dismissCalloutView];
    self.customCalloutView.delegate = nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
//    NSLog(@"*************************");
//    if ([self.type isEqualToString:@"3"]) {
//        NSMutableArray *tempArr = @[].mutableCopy;
//        ZClusterAnnotation *annotation = (ZClusterAnnotation *)view.annotation;
//        for (AMapPOI *poi in annotation.pois)
//        {
//            [tempArr addObject:poi];
//        }
//        NSMutableArray *schoolList = @[].mutableCopy;
//        for (AMapAOI *poi in tempArr) {
////            for (ZStoresListModel *model in self.schoolListModel.list) {
////                if ([model.stores_id isEqualToString:poi.uid]) {
////                    [schoolList addObject:model];
////                }
////            }
//        }
//
//        ZMapSchoolListVC *mapvc = [[ZMapSchoolListVC alloc] init];
//        mapvc.dataSources = schoolList;
//        [self presentPanModal:mapvc completion:^{
//
//        }];
//    }else if([self.type isEqualToString:@"4"]){
//        NSMutableArray *tempArr = @[].mutableCopy;
//        ZClusterAnnotation *annotation = (ZClusterAnnotation *)view.annotation;
//        for (AMapPOI *poi in annotation.pois)
//        {
//            [tempArr addObject:poi];
//        }
//        NSMutableArray *schoolList = @[].mutableCopy;
//        for (AMapAOI *poi in tempArr) {
////            for (ZStoresListModel *model in self.schoolListModel.list) {
////                if ([model.stores_id isEqualToString:poi.uid]) {
////                    [schoolList addObject:model];
////                }
////            }
//        }
//
//        ZMapSchoolListVC *mapvc = [[ZMapSchoolListVC alloc] init];
//        mapvc.dataSources = schoolList;
//        [self presentPanModal:mapvc completion:^{
//
//        }];
////        ZClusterAnnotation *annotation = (ZClusterAnnotation *)view.annotation;
////        for (AMapPOI *poi in annotation.pois)
////        {
////            [self.selectedPoiArray addObject:poi];
////        }
////
////        [self.customCalloutView setPoiArray:self.selectedPoiArray];
////
////        self.customCalloutView.detailBlock = ^(AMapPOI *poi) {
////            routePushVC(ZRoute_main_organizationDetail, @{@"id":poi.shopID}, nil);
////        };
////
////        // 调整位置
////        self.customCalloutView.center = CGPointMake(CGRectGetMidX(view.bounds), -CGRectGetMidY(self.customCalloutView.bounds) - CGRectGetMidY(view.bounds) - kCalloutViewMargin);
////
////        [view addSubview:self.customCalloutView];
//    }
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self addAnnotationsToMapView:self.mapView];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    __weak typeof(self) weakSelf = self;
    
    if ([annotation isKindOfClass:[ZClusterAnnotation class]]) {
        /* dequeue重用annotationView. */
        static NSString *const AnnotatioViewReuseID = @"AnnotatioViewReuseID";
        
        ZClusterAnnotationView *annotationView = (ZClusterAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotatioViewReuseID];
        
        if (!annotationView){
            annotationView = [[ZClusterAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotatioViewReuseID];
        }
        
        /* 设置annotationView的属性. */
        annotationView.annotation = annotation;
//        annotationView.count = [(ZClusterAnnotation *)annotation count];
        ZClusterAnnotation *ttannotation = (ZClusterAnnotation *)annotation;
        if (ttannotation.pois && ttannotation.pois.count > 0) {
            AMapPOI *poi = ttannotation.pois[0];
            
            if ([poi.type isEqualToString:@"0"] || [poi.type isEqualToString:@"1"]){
                annotationView.data = @{@"type":_type, @"content":poi.name,@"count":[NSString stringWithFormat:@"%@",poi.address]};
            }else if([poi.type isEqualToString:@"2"]){
                annotationView.data = @{@"type":_type, @"content":poi.name,@"count":[NSString stringWithFormat:@"%@",poi.address]};
            }else{
                annotationView.data = @{@"type":_type, @"content":poi.name,@"count":[NSString stringWithFormat:@"%ld",(long)[(ZClusterAnnotation *)annotation count]]};
            }
            annotationView.annBlock = ^(id annotation) {
                if ([weakSelf.type isEqualToString:@"3"] || [weakSelf.type isEqualToString:@"4"]) {
                    ZClusterAnnotation *zannotation = (ZClusterAnnotation *)annotation;
                    if (zannotation.pois && zannotation.pois.count > 0) {
                        NSMutableArray *tArr = @[].mutableCopy;
                        for (int i = 0; i < zannotation.pois.count ; i++) {
                            AMapPOI *poi = zannotation.pois[i];
                            [tArr addObject:poi.uid];
                        }
                        
                        ZMapSchoolListVC *mapvc = [[ZMapSchoolListVC alloc] init];
                        [self presentPanModal:mapvc completion:^{
                            [self getSchoolData:tArr completeBlock:^(NSArray *data) {
                                mapvc.dataSources = data;
                            }];
                        }];
                    }
                }
            };
        }
        
        
        /* 不弹出原生annotation */
        annotationView.canShowCallout = NO;
        
        return annotationView;
    }
    
    return nil;
}

- (void)updateAnnotations {
    self.shouldRegionChangeReCalculate = NO;
    
    // 清理
    [self.selectedPoiArray removeAllObjects];
    [self.customCalloutView dismissCalloutView];
    
    NSMutableArray *annosToRemove = [NSMutableArray arrayWithArray:self.mapView.annotations];
    [annosToRemove removeObject:self.mapView.userLocation];
    [self.mapView removeAnnotations:annosToRemove];
    
    NSMutableArray *tpois = @[].mutableCopy;
    if ([_type isEqualToString:@"0"] || [_type isEqualToString:@"1"]) {
        AMapPOI *poi = [[AMapPOI alloc] init];
        poi.uid = self.regionModel.city.re_id;
        poi.shopID = self.regionModel.city.re_id;
        poi.name = self.regionModel.city.title;
        poi.type = self.regionModel.city.type;
        poi.address = [NSString stringWithFormat:@"%@个校区",self.regionModel.city.num];
        poi.location = [AMapGeoPoint locationWithLatitude:[self.regionModel.city.latLng.latitude doubleValue] longitude:[self.regionModel.city.latLng.longitude doubleValue]];
        [tpois addObject:poi];
    }else if( [_type isEqualToString:@"2"]) {
        for (ZRegionDataModel *model in self.regionModel.region) {
            AMapPOI *poi = [[AMapPOI alloc] init];
            poi.uid = model.re_id;
            poi.shopID = model.re_id;
            poi.name = model.title;
            poi.type = model.type;
            poi.address = [NSString stringWithFormat:@"%@个校区",model.num];
            poi.location = [AMapGeoPoint locationWithLatitude:[model.latLng.latitude doubleValue] longitude:[model.latLng.longitude doubleValue]];
            [tpois addObject:poi];
        }
    }else{
        for (ZRegionDataModel *model in self.regionModel.schools) {
            AMapPOI *poi = [[AMapPOI alloc] init];
            poi.uid = model.re_id;
            poi.shopID = model.re_id;
            poi.name = model.name;
            poi.address = model.name;
            poi.type = model.type;
            poi.location = [AMapGeoPoint locationWithLatitude:[model.latLng.latitude doubleValue] longitude:[model.latLng.longitude doubleValue]];
            [tpois addObject:poi];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.queue, ^{
        if (ValidArray(tpois)) {
            /* 建立四叉树. */
            [weakSelf.coordinateQuadTree buildTreeWithPOIs:tpois];
            weakSelf.shouldRegionChangeReCalculate = YES;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf addAnnotationsToMapView:weakSelf.mapView];
            });
        }
        
    });
}

#pragma mark - Life Cycle
- (id)init {
    if (self = [super init]) {
        self.coordinateQuadTree = [[ZCoordinateQuadTree alloc] init];
        
        self.selectedPoiArray = [[NSMutableArray alloc] init];
        
        self.customCalloutView = [[ZCustomCalloutView alloc] init];
        
        self.queue = dispatch_queue_create("quadQueue", DISPATCH_QUEUE_SERIAL);
        
        self.isHidenNaviBar = YES;
    }
    
    return self;
}

#pragma mark - view delegate
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _type = @"0";
    
    [self readCacheData];
    
    [self initMapView];
    
    [self initSearch];
    
    _shouldRegionChangeReCalculate = NO;
    
    [self.view addSubview:self.navLeftBtn];
    [self.navLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(0) + safeAreaTop());
        make.width.height.mas_equalTo(CGFloatIn750(70));
    }];
    
    [self getRegionData];
}

- (void)dealloc {
    [self.coordinateQuadTree clean];
}

- (void)initMapView {
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        self.mapView.allowsAnnotationViewSorting = NO;
        self.mapView.delegate = self;
    }
    
    self.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - Button_Height);
    
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
    self.mapView.zoomLevel = 15.0f;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    [_mapView addSubview:self.checkSelfBtn];
    
    [self.checkSelfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mapView.mas_right).offset(CGFloatIn750(-20));
        make.bottom.equalTo(self.mapView.mas_bottom).offset(-CGFloatIn750(10)-safeAreaBottom());
    }];
}

- (void)initSearch {
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}


- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(70), CGFloatIn750(70))];
        [_navLeftBtn setBackgroundColor:HexAColor(0xffffff, 0.7) forState:UIControlStateNormal];
        [_navLeftBtn setImage:[UIImage imageNamed:@"navleftBack"] forState:UIControlStateNormal];
        ViewRadius(_navLeftBtn, CGFloatIn750(35));
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}


- (UIButton *)checkSelfBtn {
    if (!_checkSelfBtn) {
        __weak  typeof(self) weakSelf = self;
        UIImage *checkSelfImage = [UIImage imageNamed:@"hng_im_lbs_self"];
        _checkSelfBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, checkSelfImage.size.width, checkSelfImage.size.height)];
        [_checkSelfBtn setBackgroundImage:checkSelfImage forState:UIControlStateNormal];
        [_checkSelfBtn bk_addEventHandler:^(id sender) {
            [weakSelf.mapView setCenterCoordinate:weakSelf.cureUserLocation.location.coordinate animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkSelfBtn;
}

#pragma mark - Cache
- (void)readCacheData {
    _loadFromLocalHistory = YES;
    
    self.regionModel = (ZRegionNetModel *)[ZDefaultCache() objectForKey:[ZRegionNetModel className]];
    [self updateAnnotations];
}

- (void)writeDataToCache {
    [ZDefaultCache() setObject:self.regionModel forKey:[ZRegionNetModel className]];
}


- (void)getRegionData {
    __weak typeof(self) weakSelf = self;
    
    NSString *isFirst = [[NSUserDefaults standardUserDefaults] objectForKey:kMapUpdateInApp];
    if (isFirst) {
        NSInteger nowTime = [[NSDate new] timeIntervalSince1970];
        if (nowTime - [isFirst intValue] <= 60*60 && self.regionModel && self.regionModel.region && self.regionModel.region.count > 0) {//60*60*3
            return;
        }
    }
    
    [ZStudentMainViewModel getRegionList:@{@"city":SafeStr([ZLocationManager shareManager].citycode)} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && data) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)[[NSDate new] timeIntervalSince1970]] forKey:kMapUpdateInApp];
            
            weakSelf.loadFromLocalHistory = NO;
            weakSelf.regionModel = data;
            weakSelf.regionModel.city.type = @"0";
            for (ZRegionDataModel *model in weakSelf.regionModel.region) {
                model.type = @"1";
            }
            for (ZRegionDataModel *model in weakSelf.regionModel.schools) {
                model.type = @"4";
            }
            [weakSelf writeDataToCache];
            [weakSelf updateAnnotations];
        }
    }];
}

- (void)getSchoolData:(NSArray *)store completeBlock:(void(^)(NSArray *))complete{
    NSMutableDictionary *params = @{@"store":store}.mutableCopy;
    [self setLocationParams:params];
    [ZStudentMainViewModel getRegionStoreList:params completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && data) {
            ZStoresListNetModel *model = data;
            complete(model.list);
        }else{
            complete(@[]);
        }
    }];
}


- (void)setLocationParams:(NSMutableDictionary *)params {
    if ([ZLocationManager shareManager].location) {
        [params setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].location.coordinate.longitude] forKey:@"longitude"];
        [params setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].location.coordinate.latitude] forKey:@"latitude"];
    }
}

@end


#pragma mark - RouteHandler
@interface ZAnnotationClusterVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZAnnotationClusterVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_annotationCluster;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {

    if (!ValidStr([ZLocationManager shareManager].citycode)) {
        [ZAlertView setAlertWithTitle:@"没有获取到城市编号，已默认获取上海数据" btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
            [ZLocationManager shareManager].citycode = @"021";
            ZAnnotationClusterVC *routevc = [[ZAnnotationClusterVC alloc] init];
            routevc.city = request.prts;
            [topViewController.navigationController pushViewController:routevc animated:YES];
        }];
    }else{
        ZAnnotationClusterVC *routevc = [[ZAnnotationClusterVC alloc] init];
        routevc.city = request.prts;
        [topViewController.navigationController pushViewController:routevc animated:YES];
    }
}
@end
