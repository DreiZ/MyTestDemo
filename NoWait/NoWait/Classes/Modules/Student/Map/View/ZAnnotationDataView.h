//
//  ZAnnotationDataView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/8/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZAnnotationDataView : UIView
@property (nonatomic,strong) NSDictionary *data;

- (void)setMain:(NSDictionary *)data;

- (void)setSubMain:(NSDictionary *)data;

- (void)setTogether:(NSDictionary *)data;

- (void)setDetail:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
