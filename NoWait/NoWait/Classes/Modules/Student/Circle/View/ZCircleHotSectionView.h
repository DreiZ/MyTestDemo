//
//  ZCircleHotSectionView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCircleMineModel.h"

@interface ZCircleHotSectionView : UICollectionReusableView
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) void (^moreBlock)(void);
@property (nonatomic,strong) void (^menuBlock)(ZCircleDynamicLessonModel *model);
- (void)setTip:(NSString *)tip;

+(CGSize)z_getCellSize:(id)sender;
@end

