//
//  ZDSBridgePublicManager.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/12/3.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DWKWebView;
 
@interface ZDSBridgePublicManager : NSObject
+(instancetype)sharedManager;

- (void)callWebBack:(DWKWebView *)webview;
@end
