//
//  ZAdvertiserModel.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/12/18.
//  Copyright © 2018 承希-开发. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseNetworkBackModel.h"

@interface ZAdvertiserModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZBaseNetworkBannerModel *>*info;

@end

