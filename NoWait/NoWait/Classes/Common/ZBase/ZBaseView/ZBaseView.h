//
//  ZBaseView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/8/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBaseView : UIView
@property (nonatomic,strong) id (^eventAction)(id, id);
@end

NS_ASSUME_NONNULL_END
