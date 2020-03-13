//
//  ZOrganizationStudentTopFilterSeaarchView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZOrganizationStudentTopFilterSeaarchView : UIView
@property (nonatomic,assign) NSInteger openIndex;
@property (nonatomic,assign) BOOL isInside;
@property (nonatomic,strong) void (^filterBlock)(NSInteger,id);
@property (nonatomic,strong) NSString *schoolID;

- (void)setLeftName:(NSString *)left right:(NSString *)right;
@end

