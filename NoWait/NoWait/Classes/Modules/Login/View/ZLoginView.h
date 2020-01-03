//
//  ZLoginView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZLoginView : UIView
@property (nonatomic,strong) void (^editBlock)(NSInteger,NSString*);
@property (nonatomic,strong) void (^handleBlock)(NSInteger);

- (void)inputResignFirstResponder;
@end

