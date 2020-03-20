//
//  ZOrganizationEvaListEvaTextViewCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"


@interface ZOrganizationEvaListEvaTextViewCell : ZBaseCell
@property (nonatomic,assign) ZFormatterType formatterType;
@property (nonatomic,assign) NSInteger max;
@property (nonatomic,strong) NSString *hint;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) void (^textChangeBlock)(NSString *);
@end


