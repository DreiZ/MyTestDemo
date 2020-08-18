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


#import "ZOriganizationModel.h"
#import <HWPanModal/HWPanModal.h>
#import "ZMapSchoolListVC.h"

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
@property (nonatomic, strong) ZStoresListNetModel *schoolListModel;

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
        double zoomScale = self.mapView.bounds.size.width / visibleRect.size.width;
        double zoomLevel = self.mapView.zoomLevel;
        
        /* 也可根据zoomLevel计算指定屏幕距离(以50像素为例)对应的实际距离 进行annotation聚合. */
        /* 使用：NSArray *annotations = [weakSelf.coordinateQuadTree clusteredAnnotationsWithinMapRect:visibleRect withDistance:distance]; */
        //double distance = 50.f * [self.mapView metersPerPointForZoomLevel:self.mapView.zoomLevel];
        
        __weak typeof(self) weakSelf = self;
        dispatch_barrier_async(self.queue, ^{
            NSArray *annotations = [weakSelf.coordinateQuadTree clusteredAnnotationsWithinMapRect:visibleRect withZoomScale:zoomScale andZoomLevel:zoomLevel];
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
            [self updateAnnotations:self.pois];
            _type = @"0";
        }
    }else if (mapView.zoomLevel < 12.0) {
        if (![_type isEqualToString:@"1"]) {
            _type = @"1";
            [self updateAnnotations:self.pois];
        }
    }else if (mapView.zoomLevel < 13.01) {
        if (![_type isEqualToString:@"2"]) {
            _type = @"2";
            [self updateAnnotations:self.pois];
        }
    }else if (mapView.zoomLevel < 14.5) {
        if (![_type isEqualToString:@"3"]) {
            _type = @"3";
            [self updateAnnotations:self.pois];
        }
    }else {
        if (![_type isEqualToString:@"4"]) {
            _type = @"4";
            [self updateAnnotations:self.pois];
        }
    }
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    [self.selectedPoiArray removeAllObjects];
    [self.customCalloutView dismissCalloutView];
    self.customCalloutView.delegate = nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    if ([self.type isEqualToString:@"3"]) {
        NSMutableArray *tempArr = @[].mutableCopy;
        ZClusterAnnotation *annotation = (ZClusterAnnotation *)view.annotation;
        for (AMapPOI *poi in annotation.pois)
        {
            [tempArr addObject:poi];
        }
        NSMutableArray *schoolList = @[].mutableCopy;
        for (AMapAOI *poi in tempArr) {
            for (ZStoresListModel *model in self.schoolListModel.list) {
                if ([model.stores_id isEqualToString:poi.uid]) {
                    [schoolList addObject:model];
                }
            }
        }
        
        ZMapSchoolListVC *mapvc = [[ZMapSchoolListVC alloc] init];
        mapvc.dataSources = schoolList;
        [self presentPanModal:mapvc completion:^{
    
        }];
    }else if([self.type isEqualToString:@"4"]){
        ZClusterAnnotation *annotation = (ZClusterAnnotation *)view.annotation;
        for (AMapPOI *poi in annotation.pois)
        {
            [self.selectedPoiArray addObject:poi];
        }
        
        [self.customCalloutView setPoiArray:self.selectedPoiArray];
        
        self.customCalloutView.detailBlock = ^(AMapPOI *poi) {
            ZStoresListModel *lmodel = [[ZStoresListModel alloc] init];
            lmodel.stores_id = poi.shopID;
            
            routePushVC(ZRoute_main_organizationDetail, lmodel, nil);
        };
        
        // 调整位置
        self.customCalloutView.center = CGPointMake(CGRectGetMidX(view.bounds), -CGRectGetMidY(self.customCalloutView.bounds) - CGRectGetMidY(view.bounds) - kCalloutViewMargin);
        
        [view addSubview:self.customCalloutView];
    }
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self addAnnotationsToMapView:self.mapView];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
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
            annotationView.data = @{@"type":_type, @"content":poi.name,@"count":[NSString stringWithFormat:@"%ld",(long)[(ZClusterAnnotation *)annotation count]]};
        }
        
        
        /* 不弹出原生annotation */
        annotationView.canShowCallout = NO;
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - SearchPOI
/* 搜索POI. */
- (void)searchPoiWithKeyword:(NSString *)keyword {
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = keyword;
    request.city                = @"0516";
    request.requireExtension    = YES;
    
    self.currentRequest = request;
    [self.search AMapPOIKeywordsSearch:request];
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    if (response.pois.count == 0) {
        return;
    }
    
    // 只处理最新的请求
    if (request != self.currentRequest) {
        return;
    }
    
    @synchronized(self){
        self.pois = response.pois;
        [self updateAnnotations:response.pois];
    }

}

- (void)updateAnnotations:(NSArray *)pois {
    self.shouldRegionChangeReCalculate = NO;
    
    // 清理
    [self.selectedPoiArray removeAllObjects];
    [self.customCalloutView dismissCalloutView];
    
    NSMutableArray *annosToRemove = [NSMutableArray arrayWithArray:self.mapView.annotations];
    [annosToRemove removeObject:self.mapView.userLocation];
    [self.mapView removeAnnotations:annosToRemove];
    
    NSMutableArray *tpois = @[].mutableCopy;
    NSInteger count = self.schoolListModel.list.count;
    if ([_type isEqualToString:@"0"] || [_type isEqualToString:@"1"]) {
        count = 1;
    }else if( [_type isEqualToString:@"2"]) {
        count = 4;
    }else{
        count = self.schoolListModel.list.count;
    }
    for (int i = 0; i < count; i++) {
        ZStoresListModel *model = self.schoolListModel.list[i];
        AMapPOI *poi = [[AMapPOI alloc] init];
        poi.uid = model.stores_id;
        poi.shopID = model.stores_id;
        poi.name = model.name;
        poi.address = @"安徽覅色服务和覅哦啊合规啊";
//        latitude = "34.260789";
//        longitude = "117.18637";
        if (count == 1) {
            poi.location = [AMapGeoPoint locationWithLatitude:(34.27338936) longitude:(117.18292236)];
            poi.name = @"徐州市";
            poi.address = @"安徽覅色服务和覅哦啊合规啊";
        }else if(count == 4){
            if (i == 0) {
                poi.location = [AMapGeoPoint locationWithLatitude:(34.27963071) longitude:(117.19219208)];
                poi.name = @"鼓楼区";
                poi.address = @"安徽覅色服务和覅哦啊合规啊";
            }else if(i == 1){
                poi.location = [AMapGeoPoint locationWithLatitude:(34.26005402) longitude:(117.17227936)];
                poi.name = @"泉山区";
                poi.address = @"安徽覅色服务和覅哦啊合规啊";
            }else if(i == 2){
                poi.location = [AMapGeoPoint locationWithLatitude:(34.26317525) longitude:(117.20043182)];
                poi.name = @"云龙区";
                poi.address = @"安徽覅色服务和覅哦啊合规啊";
            }else{
                poi.location = [AMapGeoPoint locationWithLatitude:(34.23593155) longitude:(117.18978882)];
                poi.name = @"铜山区";
                poi.address = @"安徽覅色服务和覅哦啊合规啊";
            }
        }else{
            poi.location = [AMapGeoPoint locationWithLatitude:(34.15272698 + arc4random() %( 100 - 1) * 1.0f / 1000) longitude:(117.15751648 + arc4random() %( 100 - 1) * 1.0f / 800)];
        }
        
        [tpois addObject:poi];
    }
    
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.queue, ^{
        /* 建立四叉树. */
        [weakSelf.coordinateQuadTree buildTreeWithPOIs:tpois];
        weakSelf.shouldRegionChangeReCalculate = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf addAnnotationsToMapView:weakSelf.mapView];
        });
    });
}

#pragma mark - Refresh Button Action
- (void)refreshAction:(UIButton *)button {
    [self searchPoiWithKeyword:@"小吃"];
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
    
    [self searchPoiWithKeyword:@"超市"];
    
    [self.view addSubview:self.navLeftBtn];
    [self.navLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(0) + safeAreaTop());
        make.width.height.mas_equalTo(CGFloatIn750(70));
    }];
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
        [_navLeftBtn setBackgroundColor:HexAColor(0x000000, 0.7) forState:UIControlStateNormal];
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
    self.schoolListModel = (ZStoresListNetModel *)[ZDefaultCache() objectForKey:[ZStoresListNetModel className]];
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
    ZAnnotationClusterVC *routevc = [[ZAnnotationClusterVC alloc] init];
    routevc.city = request.prts;
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
