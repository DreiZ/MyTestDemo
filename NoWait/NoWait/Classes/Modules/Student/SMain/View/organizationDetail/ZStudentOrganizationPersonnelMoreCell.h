//
//  ZStudentOrganizationPersonnelMoreCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentDetailModel.h"

@interface ZStudentOrganizationPersonnelMoreCell : ZBaseCell
@property (nonatomic,strong) ZStudentDetailOrderSubmitListModel *model;
@property (nonatomic,strong) void (^moreBlock)(void);
@end

