//
//  ZPublicTool.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/12/12.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZPushModel;
NS_ASSUME_NONNULL_BEGIN

@interface ZPublicTool : NSObject
//拨打电话
+ (void)callTel:(NSString *)tel;

// 行间距
+ (void)setLineSpacing:(CGFloat)spacing label:(UILabel *)label;


//textView 汉字高亮去除，字数限制
+ (NSString *)textView:(UITextView *)textView maxLenght:(NSInteger)maxLength;

//textField 汉字高亮去除，字数限制
+ (NSString *)textField:(UITextField *)textField maxLenght:(NSInteger)maxLength type:(ZFormatterType)type;


+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string type:(ZFormatterType)type;

+ (void)playNotifySound;

+(void)pushNotifyHandle:(ZPushModel *)pushModel;

+ (BOOL)getNetworkStatus;

@end

NS_ASSUME_NONNULL_END
