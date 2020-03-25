//
//  ZOrderModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseModel.h"

@interface ZOrderListModel : ZBaseModel

@end

@interface ZOrderDetailModel : ZBaseModel

@end


@interface ZOrderDetailNetModel : ZBaseModel

@end


@interface ZOrderListNetModel : ZBaseModel

@end


@interface ZOrderAddNetModel : ZBaseModel
@property (nonatomic,strong) NSString *order_amount;
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,strong) NSString *order_no;
@property (nonatomic,strong) NSString *pay_amount;
@property (nonatomic,strong) NSString *message;

@end

@interface ZOrderModel : ZBaseModel

@end


