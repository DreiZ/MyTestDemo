//
//  ZOrganizationTopFilterView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZOrganizationTopFilterView : UIView
@property (nonatomic,strong) void (^completeBlock)(NSInteger,id);
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) BOOL isShow;
@property (nonatomic,strong) NSString *schoolID;


+ (ZOrganizationTopFilterView *)sharedManager;
- (void)showFilterWithIndex:(NSInteger)index;
- (void)setLeftName:(NSString *)left right:(NSString *)right;
@end

