//
//  ZBaseCell.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/11/22.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZBaseCell : UITableViewCell
@property (nonatomic,strong) id (^eventAction)(id, id);
-(void)setupView;
@end

