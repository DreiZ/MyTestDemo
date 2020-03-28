//
//  ZStudentOrganizationDetailIntroCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOrderModel.h"


@interface ZStudentOrganizationDetailIntroCell : ZBaseCell
@property (nonatomic,strong) ZStoresDetailModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end


