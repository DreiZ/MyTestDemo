//
//  ZCircleReleaseVideoUploadVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"


@interface ZCircleReleaseVideoUploadVC : ZViewController
@property (nonatomic,assign) BOOL isVideo;
@property (nonatomic,strong) NSMutableDictionary *params;

@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) void (^uploadCompleteBlock)(void);
@end

