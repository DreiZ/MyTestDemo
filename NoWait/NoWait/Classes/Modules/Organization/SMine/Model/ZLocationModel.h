//
//  ZLocationModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLocationModel : NSObject
@property (nonatomic, assign) BOOL isSelected;
///名称
@property (nonatomic, copy)   NSString     *name;
///省
@property (nonatomic, copy)   NSString     *province;
///城市名称
@property (nonatomic, copy)   NSString     *city;
///区域名称
@property (nonatomic, copy)   NSString     *district;
///地址
@property (nonatomic, copy)   NSString     *address;
///标志
@property (nonatomic, copy)   NSString     *businessArea;
///用户起点经过途经点再到终点的距离，单位是米
@property (nonatomic, assign) NSInteger     distance;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

NS_ASSUME_NONNULL_END
