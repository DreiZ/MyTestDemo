//
//  ZStudentClassFiltrateSectionView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHFilterMenuView.h"

@interface ZStudentClassFiltrateSectionView : UIView
@property (nonatomic,strong) void (^titleSelect)(NSInteger);
@property (nonatomic,strong) void (^dataBlock)(NSDictionary *);
@property (nonatomic,strong) ZHFilterMenuView *menuView;
@end

