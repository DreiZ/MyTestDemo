//
//  ZCircleReleaseDetailTextViewCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

@interface ZCircleReleaseDetailTextViewCell : ZBaseCell
@property (nonatomic,assign) ZFormatterType formatterType;
@property (nonatomic,assign) NSInteger max;
@property (nonatomic,strong) NSString *hint;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) void (^textChangeBlock)(NSString *);
@end


