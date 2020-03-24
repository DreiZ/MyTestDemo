//
//  NSString+Message.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Message)

- (NSAttributedString *)zz_toMessageString;
- (NSDictionary *)zz_JSONStringToDictionary;
-(id)zz_JSONValue ;
- (NSString *)zz_weekToIndex;
- (NSString *)zz_indexToWeek;
@end

NS_ASSUME_NONNULL_END
