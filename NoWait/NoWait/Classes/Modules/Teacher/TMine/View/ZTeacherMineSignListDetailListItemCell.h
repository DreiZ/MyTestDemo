//
//  ZTeacherMineSignListDetailListItemCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZTeacherMineSignListDetailListItemCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) ZOriganizationSignListStudentModel *model;

@end

NS_ASSUME_NONNULL_END
