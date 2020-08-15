//
//  ZClusterTableViewCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/8/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZClusterTableViewCell : ZBaseCell
@property (nonatomic,strong) void (^handleBlock)(void);
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@end

NS_ASSUME_NONNULL_END
