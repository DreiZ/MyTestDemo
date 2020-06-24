//
//  ZPublicTool.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/12/12.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZPushModel;
NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, ZFormatterType) {
    ZFormatterTypeAny = 0,             //不过滤
    ZFormatterTypePhoneNumber,         //11位电话号码
    ZFormatterTypeNumber,              //数字
    ZFormatterTypeDecimal,             //小数
    ZFormatterTypeAlphabet,            //英文字母
    ZFormatterTypeNumberAndAlphabet,   //数字+英文字母
    ZFormatterTypeIDCard,              //18位身份证
    ZFormatterTypeCustom,               //自定义
    ZFormatterTypeAnyByte               //按字节数算
};


@interface ZPublicTool : NSObject
//拨打电话
+ (void)callTel:(NSString *)tel;

//截图
+ (UIImage *)snapshotForView:(UIView *)view;

//压缩
-(UIImage *)compressImage:(UIImage *)image;

//保存图片到相册
+ (void)saveImageToPhoto:(UIImage *)image;

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

+ (void)checkUpdateVersion;

+ (void)settingCheckUpdateVersion;
@end

NS_ASSUME_NONNULL_END
