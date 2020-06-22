//
//  ZOrganizationPhotoUploadManageVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationPhotoUploadManageVC : ZViewController
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong) void (^uploadCompleteBlock)(void);
@end

NS_ASSUME_NONNULL_END
