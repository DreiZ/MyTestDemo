//
//  ZAddPhotosItemCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBaseUnitModel.h"

@interface ZAddPhotosItemCell : UICollectionViewCell
@property (nonatomic,strong) ZBaseMenuModel *model;
@property (nonatomic,strong) void (^handelBlock)(NSInteger);
@end


