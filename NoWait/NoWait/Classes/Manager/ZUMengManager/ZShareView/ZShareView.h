//
//  ZShareView.h
//  ZBigHealth
//
//  Created by zzz on 2018/12/3.
//  Copyright © 2018 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZShareView : UIView

+ (void)shareWithtitle:(NSString *)title  handlerBlock:(void(^)(NSInteger))handleBlock;

+ (void)setPre_title:(NSString *)pre_title reduce_weight:(NSString *)reduce_weight after_title:(NSString *)after_title  handlerBlock:(void(^)(NSInteger))handleBlock ;
@end

