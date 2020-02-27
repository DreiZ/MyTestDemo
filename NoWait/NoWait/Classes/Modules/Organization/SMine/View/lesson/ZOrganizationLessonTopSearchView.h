//
//  ZOrganizationLessonTopSearchView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationLessonTopSearchView : UIView
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) void (^handleBlock)(void);
@end

NS_ASSUME_NONNULL_END
