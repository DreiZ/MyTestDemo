//
//  ZOrganizationCampusTextFieldCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"


@interface ZOrganizationCampusTextFieldCell : ZBaseCell
@property (nonatomic,strong) ZBaseTextFieldCellModel *model;
@property (nonatomic,strong) void (^valueChangeBlock)(NSString *text);
@end

