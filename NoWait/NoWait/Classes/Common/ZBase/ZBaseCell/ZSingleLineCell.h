//
//  ZSingleLineCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZSingleLineCell : ZBaseCell
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIImageView *leftImageView;

@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;

@property (nonatomic,strong) UIView *bottomLineView;



@property (nonatomic,strong) ZBaseSingleCellModel *model;

- (void)initMainView;
@end

NS_ASSUME_NONNULL_END
