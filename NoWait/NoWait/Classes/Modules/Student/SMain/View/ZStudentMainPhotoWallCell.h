//
//  ZStudentMainPhotoWallCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentMainModel.h"

@interface ZStudentMainPhotoWallCell : ZBaseCell
@property (nonatomic,strong) void (^menuBlock)(ZStudentPhotoWallItemModel *);

@property (nonatomic,strong) NSArray <ZStudentPhotoWallItemModel *>*channelList;
@end

