//
//  ZStudentStarListCollectionViewCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentDetailModel.h"

@interface ZStudentStarListCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *skillLabel;

@property (nonatomic,strong) ZStudentDetailLessonOrderCoachModel *model;

@property (nonatomic,strong) void (^detailBlock)(UIImageView *);

+(CGSize)zz_getCollectionCellSize;
@end

