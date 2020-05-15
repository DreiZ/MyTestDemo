//
//  ZOrganizationMineHeaderView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationMineHeaderView : UIView
@property (nonatomic,strong) NSString *userType;

@property (nonatomic,strong) void (^topHandleBlock)(NSInteger);
- (void)updateSubViewFrame;
- (void)updateData;
+ (CGFloat)getNameOffset;
@end

NS_ASSUME_NONNULL_END
