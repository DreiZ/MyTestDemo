//
//  ZStudentClassFiltrateSectionView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZStudentClassFiltrateSectionView : UIView
@property (nonatomic,strong) void (^titleSelect)(NSInteger);
@property (nonatomic,strong) void (^dataBlock)(NSDictionary *);
@end

NS_ASSUME_NONNULL_END
