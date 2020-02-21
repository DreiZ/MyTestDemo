//
//  ZOrganizationTeacherSearchTopView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZOrganizationTeacherSearchTopView : UIView
@property (nonatomic,strong) UITextField *iTextField;
@property (nonatomic,strong) void (^cancleBlock)(void);

@end


