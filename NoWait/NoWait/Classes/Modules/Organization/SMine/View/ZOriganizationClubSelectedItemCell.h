//
//  ZOriganizationClubSelectedItemCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBaseUnitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationClubSelectedItemCell : UICollectionViewCell
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong) ZBaseUnitModel *model;

@end

NS_ASSUME_NONNULL_END
