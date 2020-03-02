//
//  ZOrganizationLessonAddPhotosItemCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBaseUnitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationLessonAddPhotosItemCell : UICollectionViewCell
@property (nonatomic,strong) ZBaseUnitModel *model;
@property (nonatomic,strong) void (^delBlock)(void);
@end

NS_ASSUME_NONNULL_END
