//
//  ZAdvertiserModel.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/12/18.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseNetworkBackModel.h"

@interface ZAdvertiserModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZBaseNetworkBannerModel *>*info;

@end

