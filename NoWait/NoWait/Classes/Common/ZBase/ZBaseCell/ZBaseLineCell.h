//
//  ZBaseLineCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/30.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZCellModel.h"

@interface ZBaseLineCell : ZBaseCell
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIImageView *leftImageView;

@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;

@property (nonatomic,strong) UILabel *leftSubTitleLabel;
@property (nonatomic,strong) UILabel *rightSubTitleLabel;

@property (nonatomic,strong) UIView *bottomLineView;


@property (nonatomic,strong) ZLineCellModel *model;

@end


