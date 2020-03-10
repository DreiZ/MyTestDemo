//
//  ZOrganizationAddressSearchView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POIAnnotation.h"
#import "ZLocationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationAddressSearchView : UIView
@property (nonatomic,strong) NSMutableArray *iPOIAnnotations;
@property (nonatomic,strong) void (^addressBlock)(ZLocationModel *);
@end

NS_ASSUME_NONNULL_END
