//
//  ZBaseCell.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/11/22.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

@implementation ZBaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
}
@end
