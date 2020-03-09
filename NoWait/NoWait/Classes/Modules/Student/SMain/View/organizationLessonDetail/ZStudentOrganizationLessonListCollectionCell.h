//
//  ZStudentOrganizationLessonListCollectionCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentMainModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZStudentOrganizationLessonListCollectionCell : UICollectionViewCell
@property (nonatomic,strong) ZStudentLessonListModel *model;

+(CGSize)zz_getCollectionCellSize;
@end

NS_ASSUME_NONNULL_END
