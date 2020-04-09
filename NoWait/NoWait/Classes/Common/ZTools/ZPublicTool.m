//
//  ZPublicTool.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/12/12.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZPublicTool.h"
#import <AudioToolbox/AudioToolbox.h>
#import "AppDelegate.h"
#import "AppDelegate+AppService.h"
#import "AFNetworkReachabilityManager.h"
#import "ZAlertView.h"

@implementation ZPublicTool

+ (void)callTel:(NSString *)tel {
    if (!tel) {
        return;
    }
    BOOL canCall = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",tel]]];
    if (!canCall) {
        [TLUIUtility showErrorHint:@"设备不支持拨打电话"];
    }else
    {
//        [MobClick event:@"拨打电话" attributes:@{@"tel":tel} counter:1];
        double version = [[[UIDevice currentDevice] systemVersion] doubleValue];
        if (version > 10.1) {
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            return;
        }
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phoneNum]]];
    }
}

#pragma mark - 截屏
+ (UIImage *)snapshotForView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

+ (void)saveImageToPhoto:(UIImage *)image {
    // 判断授权状态
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error = nil;
            
            // 保存相片到相机胶卷
            __block PHObjectPlaceholder *createdAsset = nil;
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                createdAsset = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset;
            } error:&error];
            
            if (error) {
                NSLog(@"保存失败：%@", error);
                [TLUIUtility showErrorHint:@"保存失败"];
                return;
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ZAlertView setAlertWithTitle:@"已成功保存到相册" btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
                        
                    }];
                });
                
            }
        });
    }];
}

// 行间距
+ (void)setLineSpacing:(CGFloat)spacing label:(UILabel *)label
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    [label setAttributedText:attributedString];
//    [label sizeToFit];
}


+ (NSString *)textView:(UITextView *)textView maxLenght:(NSInteger)maxLength {
    //限制输入字符数
    NSString *lang = [textView.textInputMode primaryLanguage]; // 键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            //                textField.text = [self getStrWith:textField.text];
            if (textView.text.length > maxLength) {
                [TLUIUtility showErrorHint:@"输入内容超出限制"];
                textView.text = [textView.text substringToIndex:maxLength];
            }
            
        }
        //有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            //            UITextPosition* beginning = textField.beginningOfDocument;
            //            NSInteger location = [textField offsetFromPosition:beginning toPosition:position];
            //            //            UITextPosition* selectionStart = selectedRange.start;
            //            UITextPosition* selectionEnd = selectedRange.end;
            //            NSInteger length = [textField offsetFromPosition:position toPosition:selectionEnd];
            //            NSString *tempstr = [textField.text substringWithRange:NSMakeRange(location, length)];
            //
            //            NSString *beforeTempstr = [textField.text substringWithRange:NSMakeRange(0, textField.text.length - length)];
            //            DLog(@"did have %@ length %ld str %@ before str %@",textField.text,(long)textField.text.length,tempstr,beforeTempstr);
        }
    }
    //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        //            textField.text = [self getStrWith:textField.text];
        if (textView.text.length > maxLength) {
            textView.text = [textView.text substringToIndex:maxLength];
            [TLUIUtility showErrorHint:@"输入内容超出限制"];
        }
        
    }
    return textView.text;
}

+ (NSString *)textField:(UITextField *)textField maxLenght:(NSInteger)maxLength type:(ZFormatterType)type{
    if (type == ZFormatterTypeDecimal) {
        if ([textField.text  doubleValue] - pow(10, maxLength) - 0.01  > 0.000001) {
            [TLUIUtility showErrorHint:@"输入内容超出限制"];
            NSString *str = [textField.text substringToIndex:textField.text.length - 1];
            textField.text = str;
        }
        
        
        return textField.text;
        
    }
    //限制输入字符数
    NSString *lang = [textField.textInputMode primaryLanguage]; // 键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            //                textField.text = [self getStrWith:textField.text];
            if (textField.text.length > maxLength) {
                [TLUIUtility showErrorHint:@"输入内容超出限制"];
                textField.text = [textField.text substringToIndex:maxLength];
            }
            
        }
        //有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
//            UITextPosition* beginning = textField.beginningOfDocument;
//            NSInteger location = [textField offsetFromPosition:beginning toPosition:position];
//            //            UITextPosition* selectionStart = selectedRange.start;
//            UITextPosition* selectionEnd = selectedRange.end;
//            NSInteger length = [textField offsetFromPosition:position toPosition:selectionEnd];
//            NSString *tempstr = [textField.text substringWithRange:NSMakeRange(location, length)];
//            
//            NSString *beforeTempstr = [textField.text substringWithRange:NSMakeRange(0, textField.text.length - length)];
//            DLog(@"did have %@ length %ld str %@ before str %@",textField.text,(long)textField.text.length,tempstr,beforeTempstr);
        }
    }
    //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        //            textField.text = [self getStrWith:textField.text];
        if (textField.text.length > maxLength) {
            textField.text = [textField.text substringToIndex:maxLength];
            [TLUIUtility showErrorHint:@"输入内容超出限制"];
        }
        
    }
    return textField.text;
}


+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string type:(ZFormatterType)type
{
    
    NSString *regexString;
    switch (type) {
        case ZFormatterTypeAny:
        {
            return YES;
        }
        case ZFormatterTypePhoneNumber:
        {
            regexString = @"^\\d{0,11}$";
            break;
        }
        case ZFormatterTypeNumber:
        {
            regexString = @"^\\d*$";
            break;
        }
        case ZFormatterTypeDecimal:
        {
            regexString = [NSString stringWithFormat:@"^(\\d+)\\.?(\\d{0,%lu})$", (unsigned long)1];
            break;
        }
        case ZFormatterTypeAlphabet:
        {
            regexString = @"^[a-zA-Z]*$";
            break;
        }
        case ZFormatterTypeNumberAndAlphabet:
        {
            regexString = @"^[a-zA-Z0-9]*$";
            break;
        }
        case ZFormatterTypeIDCard:
        {
            regexString = @"^\\d{1,17}[0-9Xx]?$";
            break;
        }
        case ZFormatterTypeCustom:
        {
            regexString = [NSString stringWithFormat:@"^[%@]{0,%lu}$", @"1234567890", (long)10];
            break;
        }
        default:
            break;
    }
    NSString *currentText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    
    return [regexTest evaluateWithObject:currentText] || currentText.length == 0;
}


#pragma mark - 必须得是自定义的声音，经过测试系统的声音好像都带振动
+ (void)playNotifySound {
    //获取路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EBMute" ofType:@"mp3"];
    //定义一个带振动的SystemSoundID
    SystemSoundID soundID = 1000;
    //判断路径是否存在
    if (path) {
        //创建一个音频文件的播放系统声音服务器
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([NSURL fileURLWithPath:path]), &soundID);
        //判断是否有错误
        if (error != kAudioServicesNoError) {
            DLog(@"%d",(int)error);
        }
    }
    //只播放声音，没振动
    AudioServicesPlaySystemSound(soundID);
}

+(void)pushNotifyHandle:(ZPushModel *)pushModel {
    
}

+ (void)pushShowMessageAlert:(ZPushModel *)pushModel {
    
}

+ (BOOL)getNetworkStatus {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if(mgr.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){
        //        [[HNPublicTool shareInstance] showHudMessage:@"没有网络，请检查手机网络连接"];
        return NO;
    }else{
        return YES;
    }
}

@end
