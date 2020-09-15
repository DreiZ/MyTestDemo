//
//  ZTeacherClassFormFilterView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/9/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOriganizationClassViewModel.h"


@interface ZTeacherClassFormFilterView : UIView
@property (nonatomic,strong) ZOriganizationClassListModel *model;
@property (nonatomic,strong) void (^handleBlock)(ZOriganizationClassListModel *);
@property (nonatomic,strong) NSMutableArray *dataSources;
@end

