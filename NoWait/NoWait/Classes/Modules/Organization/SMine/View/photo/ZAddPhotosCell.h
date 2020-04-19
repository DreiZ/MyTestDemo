//
//  ZAddPhotosCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZBaseUnitModel.h"

@interface ZAddPhotosCell : ZBaseCell

@property (nonatomic,strong) void (^menuBlock)(NSInteger, BOOL);
@property (nonatomic,strong) void (^seeBlock)(NSInteger);
@property (nonatomic,strong) ZBaseMenuModel *model;
@end

