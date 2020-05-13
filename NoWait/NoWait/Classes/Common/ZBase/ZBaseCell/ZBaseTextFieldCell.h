//
//  ZBaseTextFieldCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZBaseLineCell.h"

@interface ZBaseTextFieldCell : ZBaseLineCell <UITextFieldDelegate>
@property (nonatomic,strong) UITextField *inputTextField;
@property (nonatomic,strong) UIView *inputLine;
@property (nonatomic,assign) ZFormatterType formatterType;


@property (nonatomic,strong) ZTextFieldModel *model;
@property (nonatomic,strong) void (^valueChangeBlock)(NSString *);
@end


