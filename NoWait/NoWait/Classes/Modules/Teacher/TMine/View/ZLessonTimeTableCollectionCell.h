//
//  ZLessonTimeTableCollectionCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBaseCollectionViewCell.h"
#import "ZOriganizationModel.h"

@interface ZLessonTimeTableCollectionCell : ZBaseCollectionViewCell
@property (nonatomic,strong) void (^handleBlock)(ZOriganizationLessonListModel *);
@property (nonatomic,strong) ZOriganizationLessonListModel *model;
@end

