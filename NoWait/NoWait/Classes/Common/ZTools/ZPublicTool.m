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
#import "HNShowPopViewHandler.h"
#import "HNUpdateAlertView.h"

@interface ZPublicTool ()
@property (nonatomic, strong) HNShowPopViewHandler *showPopViewHandler;
@end

@implementation ZPublicTool

+ (ZPublicTool *)shareManager
{
    static ZPublicTool *helper;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[ZPublicTool alloc] init];
    });
    return helper;
}


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

#pragma mark -
-(UIImage *)compressImage:(UIImage *)image {
    NSData *imgdata = UIImagePNGRepresentation(image);
    if (imgdata.length > 1024000 || image.size.width>600) {
        if(image.size.width>600)
        {
            image  = [self OriginImage:image scaleToSize:CGSizeMake(600., (image.size.height*600.)/image.size.width)];
        }else{
            image  = [self OriginImage:image scaleToSize:CGSizeMake(image.size.width/2.0, image.size.height/2.0)];
        }
        
        image = [self compressImage:image];
        return image;
    }else{
        return image;
    }
}

//图片处理，图片压缩
- (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
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
                DLog(@"保存失败：%@", error);
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
    if (label && ValidStr(label.text)) {
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:spacing];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
        [label setAttributedText:attributedString];
    }
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
            if (type == ZFormatterTypeAnyByte) {
                if ([ZPublicTool convertToInt:textField.text] > maxLength) {
                    [TLUIUtility showErrorHint:@"输入内容超出限制"];
                    NSRange range;
                    NSUInteger byteLength = 0;
                    for(int i=0; i < textField.text.length && byteLength <= maxLength; i += range.length) {
                       range = [textField.text rangeOfComposedCharacterSequenceAtIndex:i];
                       byteLength += strlen([[textField.text substringWithRange:range] UTF8String]);
                       if (byteLength > maxLength) {
                           NSString* newText = [textField.text substringWithRange:NSMakeRange(0, range.location)];
                           textField.text = newText;
                       }
                    }
                }
            }else{
                if (textField.text.length > maxLength) {
                    [TLUIUtility showErrorHint:@"输入内容超出限制"];
                    textField.text = [textField.text substringToIndex:maxLength];
                }
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
        if (type == ZFormatterTypeAnyByte) {
            if ([ZPublicTool convertToInt:textField.text] > maxLength) {
                [TLUIUtility showErrorHint:@"输入内容超出限制"];
                NSRange range;
                NSUInteger byteLength = 0;
                for(int i=0; i < textField.text.length && byteLength <= maxLength; i += range.length) {
                   range = [textField.text rangeOfComposedCharacterSequenceAtIndex:i];
                   byteLength += strlen([[textField.text substringWithRange:range] UTF8String]);
                   if (byteLength > maxLength) {
                       NSString* newText = [textField.text substringWithRange:NSMakeRange(0, range.location)];
                       textField.text = newText;
                   }
                }
            }
        }else{
            if (textField.text.length > maxLength) {
                textField.text = [textField.text substringToIndex:maxLength];
                [TLUIUtility showErrorHint:@"输入内容超出限制"];
            }
        }
    }
    
    return textField.text;
}

+ (void)textView:(UITextView *)textView lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font textColor:(UIColor *)textColor{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    paragraphStyle.lineSpacing = lineSpacing;// 字体的行间距
    NSDictionary *attributes = @{NSForegroundColorAttributeName:textColor? textColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]),NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    
    // 获取键盘输入模式

    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { // zh-Hans代表简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];

        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];

        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
        }

    } else {// 中文输入法以外的直接统计
        textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    }


//    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}

+ (NSString *)textView:(UITextView *)textField maxLenght:(NSInteger)maxLength type:(ZFormatterType)type{
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
            if (type == ZFormatterTypeAnyByte) {
                if ([ZPublicTool convertToInt:textField.text] > maxLength) {
                    [TLUIUtility showErrorHint:@"输入内容超出限制"];
                    NSRange range;
                    NSUInteger byteLength = 0;
                    for(int i=0; i < textField.text.length && byteLength <= maxLength; i += range.length) {
                       range = [textField.text rangeOfComposedCharacterSequenceAtIndex:i];
                       byteLength += strlen([[textField.text substringWithRange:range] UTF8String]);
                       if (byteLength > maxLength) {
                           NSString* newText = [textField.text substringWithRange:NSMakeRange(0, range.location)];
                           textField.text = newText;
                       }
                    }
                }
            }else{
                if (textField.text.length > maxLength) {
                    [TLUIUtility showErrorHint:@"输入内容超出限制"];
                    textField.text = [textField.text substringToIndex:maxLength];
                }
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
        if (type == ZFormatterTypeAnyByte) {
            if ([ZPublicTool convertToInt:textField.text] > maxLength) {
                [TLUIUtility showErrorHint:@"输入内容超出限制"];
                NSRange range;
                NSUInteger byteLength = 0;
                for(int i=0; i < textField.text.length && byteLength <= maxLength; i += range.length) {
                   range = [textField.text rangeOfComposedCharacterSequenceAtIndex:i];
                   byteLength += strlen([[textField.text substringWithRange:range] UTF8String]);
                   if (byteLength > maxLength) {
                       NSString* newText = [textField.text substringWithRange:NSMakeRange(0, range.location)];
                       textField.text = newText;
                   }
                }
            }
        }else{
            if (textField.text.length > maxLength) {
                textField.text = [textField.text substringToIndex:maxLength];
                [TLUIUtility showErrorHint:@"输入内容超出限制"];
            }
        }
    }
    
    return textField.text;
}


+ (int)convertToInt:(NSString*)strtemp//判断中英混合的的字符串长度
{
    int strlength = 0;
    char *p = (char *)[strtemp cStringUsingEncoding:NSUTF8StringEncoding];
    for (int i=0; i < [strtemp lengthOfBytesUsingEncoding:NSUTF8StringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}


+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string type:(ZFormatterType)type
{
    
    NSString *regexString;
    switch (type) {
        case ZFormatterTypeAny:
        {
            return YES;
        }
        case ZFormatterTypeAnyByte:
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
            regexString = [NSString stringWithFormat:@"^(\\d+)\\.?(\\d{0,%lu})$", (unsigned long)2];
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
        //没有网络，请检查手机网络连接
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 强制更新处理
+ (void)checkUpdateVersion {
    NSString *isFirst = [[NSUserDefaults standardUserDefaults] objectForKey:kUpdateInApp];
    if (isFirst) {
        NSInteger nowTime = [[NSDate new] timeIntervalSince1970];
        if (nowTime - [isFirst intValue] <= 24*60*60*3) {//24*60*60*3
            return;
        }
    }
        
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)[[NSDate new] timeIntervalSince1970]] forKey:kUpdateInApp];
    
    [[ZUserHelper sharedHelper] updateVersionWithParams:@{} block:^(BOOL isSuccess, NSDictionary *data) {
        [ZPublicTool checkUpdate:data];
    }];
}

+ (void)settingCheckUpdateVersion {
    [[ZUserHelper sharedHelper] updateVersionWithParams:@{} block:^(BOOL isSuccess, NSDictionary *data) {
        [ZPublicTool checkUpdate:data];
    }];
}

+ (void)checkUpdate:(NSDictionary *)verDic
{
    NSString *versionNum;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    if ([infoDictionary objectForKey:@"CFBundleShortVersionString"]) {
        versionNum = [NSString stringWithFormat:@"%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    }
    
    if (verDic && [verDic objectForKey:@"version"]  && [verDic objectForKey:@"force_upgrade"]) {
        NSString *newVersionNum = [NSString stringWithFormat:@"%@", verDic[@"version"]];
        
        if(newVersionNum) {
            NSComparisonResult comResult = [versionNum compare:newVersionNum options:NSNumericSearch];
            if(comResult == NSOrderedAscending) {
                NSString *alertMsgStr = @"似锦APP已更新，请从App Store下载全新版本";
                if ([verDic objectForKey:@"info"]) {
                    alertMsgStr = verDic[@"info"];
                }
                
                NSString *isForce = [NSString stringWithFormat:@"%@", verDic[@"force_upgrade"]];
                
                if(isForce && [isForce isEqualToString:@"2"]) {
                    [self showForceUpateAlertView:alertMsgStr versionStr:newVersionNum force_upgrade:YES];
                }else {
                    [self showForceUpateAlertView:alertMsgStr versionStr:newVersionNum force_upgrade:NO];
                }
            }
        }
    }
}

+ (void)showForceUpateAlertView:(NSString *)alertMsgStr versionStr:(NSString *)versionStr force_upgrade:(BOOL)force_upgrade
{
    if ([ZPublicTool shareManager].showPopViewHandler) {
        [[ZPublicTool shareManager].showPopViewHandler dissmiss];
    }
    
    HNUpdateAlertView *updateAlertView = [[HNUpdateAlertView alloc] init];
    updateAlertView.versionLabel.text = [NSString stringWithFormat:@"V%@", versionStr];
//    updateAlertView.contentText = alertMsgStr;
    [updateAlertView setContentText:alertMsgStr force_upgrade:force_upgrade];
    
    [ZPublicTool shareManager].showPopViewHandler = [HNShowPopViewHandler showContentView:updateAlertView
                                                inContainerView:[AppDelegate shareAppDelegate].window
                                              useBlurBackground:NO
                                                        popType:HNShowPopViewTypeSpringTop];
    [ZPublicTool shareManager].showPopViewHandler.backgroundView.backgroundColor = [UIColorHex(0x000000) colorWithAlphaComponent:0.5];
    [ZPublicTool shareManager].showPopViewHandler.backgroundView.enabled = YES;
    [[ZPublicTool shareManager].showPopViewHandler.backgroundView removeAllTargets];
    
    @weakify(self)
    [updateAlertView.updateButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(self)
        
        [self openAppStore];
    }];
    
    [updateAlertView.cancleButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [[ZPublicTool shareManager].showPopViewHandler dissmiss];
    }];
}

+ (void)openAppStore
{
    NSString *urlStr;
//    if(_verInfoDic && _verInfoDic[@"url"]) {
//        urlStr = _verInfoDic[@"url"];
//    }
    
    if (!urlStr) {
        urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", kStoreAppId];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        } else {
            // Fallback on earlier versions
        }
    }else {
        [[UIApplication sharedApplication] openURL:url];
    }
}
@end
