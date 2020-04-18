//
//  ZMineAccountTextFieldCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZLoginModel.h"

@interface ZMineAccountTextFieldCell : ZBaseCell
@property (nonatomic,assign) ZFormatterType formatterType;
@property (nonatomic,assign) NSInteger max;
@property (nonatomic,strong) NSString *placeholder;
@property (nonatomic,assign) NSInteger type; //0：通常 1：code 2：图形验证码 3:密码
@property (nonatomic,strong) UIImage *codeImage;
@property (nonatomic,strong) UITextField *inputTextField;

@property (nonatomic,strong) void (^getCodeBlock)(void (^)(NSString *));

@property (nonatomic,strong) void (^imageCodeBlock)(NSString *);
@property (nonatomic,strong) void (^valueChangeBlock)(NSString *);

- (void)getImageCode;
@end
