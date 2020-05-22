//
//  ZStudentMainFiltrateSectionView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZDropDownMenu.h"

@interface ZStudentMainFiltrateSectionView : WMZDropDownMenu
@property (nonatomic,strong) void (^titleSelect)(NSInteger,void (^)(void));
@property (nonatomic,strong) void (^dataBlock)(NSDictionary *);
@end


