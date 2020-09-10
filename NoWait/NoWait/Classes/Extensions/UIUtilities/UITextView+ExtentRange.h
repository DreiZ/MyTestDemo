//
//  UITextView+ExtentRange.h
//  NoWait
//
//  Created by zhuang zhang on 2020/9/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (ExtentRange)

- (NSRange) selectedRange;
 
- (void) setSelectedRange:(NSRange) range;
 
@end

NS_ASSUME_NONNULL_END
