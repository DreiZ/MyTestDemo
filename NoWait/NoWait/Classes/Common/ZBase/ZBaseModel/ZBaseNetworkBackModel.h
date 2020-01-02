//
//  ZBaseNetworkBackModel.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/11/21.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
//广告model
@interface ZBaseNetworkBannerModel : NSObject
@property (nonatomic,strong) NSString *bannerId;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *drive;
@property (nonatomic,strong) NSString *directive;
@property (nonatomic,strong) NSString *parameter;
@end


@interface ZBaseNetworkBackDataModel : NSObject
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *msg;
@end

//协议model
@interface ZAgreementNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *content;
@end

//分享model
@interface ZShareNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *back_image;
@property (nonatomic,strong) NSString *url;
@end


@interface ZBaseNetworkBackModel : NSObject
@property (nonatomic,strong) id data;
@property (nonatomic,strong) NSString *ret;
@property (nonatomic,strong) NSString *msg;
@end

