//
//  ZOrganizationLessonTextViewVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationLessonTextViewVC : ZViewController
@property (nonatomic,strong) NSString *navTitle;
@property (nonatomic,strong) NSString *hintStr;
@property (nonatomic,strong) NSString *content;


@property (nonatomic,assign) NSInteger max;
@property (nonatomic,strong) void (^handleBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
