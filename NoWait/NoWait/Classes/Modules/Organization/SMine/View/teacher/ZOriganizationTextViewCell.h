//
//  ZOriganizationTextViewCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationTextViewCell : ZBaseCell
@property (nonatomic,assign) ZFormatterType formatterType;
@property (nonatomic,assign) NSInteger max;
@property (nonatomic,strong) NSString *hint;

@property (nonatomic,strong) NSString *content;
;
@property (nonatomic,strong) NSString *isBackColor;
@property (nonatomic,strong) void (^textChangeBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
