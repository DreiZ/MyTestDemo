//
//  ZAlertMoreView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZAlertMoreView : UIView
+ (void)setMoreAlertWithTitleArr:(NSArray *)titleArr handlerBlock:(void(^)(NSString *))handleBlock ;
@end


