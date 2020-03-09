//
//  ZStudentStarNewListCollectionViewCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZStudentStarNewListCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *skillLabel;

@property (nonatomic,strong) ZStudentDetailLessonOrderCoachModel *model;

@property (nonatomic,strong) void (^detailBlock)(UIImageView *);


+(CGSize)zz_getCollectionCellSize;
@end

NS_ASSUME_NONNULL_END
