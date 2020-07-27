//
//  ZOrganizationTextLabelListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationTextLabelListCell : ZBaseCell
@property (nonatomic,strong) ZBaseTextFieldCellModel *model;
@property (nonatomic,strong) UIImageView *arrowImageView;

@end

NS_ASSUME_NONNULL_END
