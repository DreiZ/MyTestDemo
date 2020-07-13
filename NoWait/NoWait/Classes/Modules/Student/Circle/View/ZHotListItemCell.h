//
//  ZHotListItemCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHotListItemCell : ZBaseCollectionViewCell
@property (nonatomic,strong) UILabel *hotLabel;
@property (nonatomic,strong) UIImageView *hotImageView;
@end

NS_ASSUME_NONNULL_END
