//
//  ZMenuItemCell.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMenuItem.h"
#import <TLTabBarController/TLBadge.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMenuItemCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

/// 左侧icon
@property (nonatomic, strong) UIImageView *iconView;
/// 左侧标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 红点
@property (nonatomic, strong) TLBadge *badgeView;

/// 右侧副标题
@property (nonatomic, strong) UILabel *detailLabel;
/// 右侧广告图
@property (nonatomic, strong) UIImageView *rightImageView;
/// 右侧广告图红点
@property (nonatomic, strong) TLBadge *rightBadgeView;
/// 右箭头
@property (nonatomic, strong) UIImageView *arrowView;


@property (nonatomic, strong) ZMenuItem *menuItem;

@end

NS_ASSUME_NONNULL_END
