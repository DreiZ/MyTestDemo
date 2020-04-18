//
//  ZBaseTextViewCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZBaseCellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZBaseTextViewCell : ZBaseCell
@property (nonatomic,strong) ZBaseTextFieldCellModel *model;
@property (nonatomic,strong) void (^valueBlock)(NSString *);
@property (nonatomic,strong) UITextView *iTextView;
@end

NS_ASSUME_NONNULL_END
