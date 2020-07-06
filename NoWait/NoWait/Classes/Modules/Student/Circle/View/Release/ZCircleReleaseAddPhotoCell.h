//
//  ZCircleReleaseAddPhotoCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

@interface ZCircleReleaseAddPhotoCell : ZBaseCell
@property (nonatomic,strong) void (^menuBlock)(NSInteger, BOOL);
@property (nonatomic,strong) void (^seeBlock)(NSInteger);
@property (nonatomic,strong) void (^addBlock)(void);
@property (nonatomic,strong) NSMutableArray <ZFileUploadDataModel *>*imageList;
@end

