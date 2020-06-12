//
//  ZSearchHistoryView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSearchHistoryView : UIView
@property (nonatomic,strong) NSString *searchType;

@property (nonatomic,strong) void (^searchBlock)(NSString *);

- (void)reloadHistoryData;
@end

NS_ASSUME_NONNULL_END
