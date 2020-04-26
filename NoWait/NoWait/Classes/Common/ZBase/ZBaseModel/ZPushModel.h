//
//  ZPushModel.h
//  ZBigHealth
//
//  Created by zzz on 2019/4/13.
//  Copyright © 2019 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPushAlertModel : NSObject
@property (nonatomic,copy) NSString *body;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *title;
@end

@interface ZPushApsModel : NSObject
@property (nonatomic,strong) ZPushAlertModel *alert;
@property (nonatomic,copy) NSString *badge;
@property (nonatomic,copy) NSString *sound;
@end

@interface ZPushExtraModel : NSObject
@property (nonatomic,copy) NSString *after_open;
@property (nonatomic,copy) NSString *custom;
@property (nonatomic,copy) NSString *msg_id;
@property (nonatomic,copy) NSString *type;
@end

@interface ZPushModel : NSObject
@property (nonatomic,strong) ZPushApsModel *aps;
@property (nonatomic,strong) ZPushExtraModel *extra;
@property (nonatomic,copy) NSString *p;
@property (nonatomic,copy) NSString *d;
@end

