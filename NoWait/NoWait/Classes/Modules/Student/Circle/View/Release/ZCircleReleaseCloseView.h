//
//  ZCircleReleaseCloseView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZCircleReleaseCloseView : UIView
@property (nonatomic,strong) void (^backBlock)(void);
@end

