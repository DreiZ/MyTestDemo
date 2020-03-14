//
//  ZOrganizatioPhotosCollectionCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBaseUnitModel.h"


@interface ZOrganizatioPhotosCollectionCell : UICollectionViewCell
@property (nonatomic,strong) ZBaseUnitModel *model;
@property (nonatomic,strong) void (^delBlock)(void);
@end


