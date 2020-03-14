//
//  ZSingleLeftRoundImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSingleLeftRoundImageCell.h"

@implementation ZSingleLeftRoundImageCell


- (void)setModel:(ZBaseSingleCellModel *)model {
    [super setModel:model];
    
    if (model.leftImage && model.leftImage.length > 0) {
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(model.leftMargin);
            make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(20));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(20));
            make.width.equalTo(self.leftImageView.mas_height);
        }];
        ViewRadius(self.leftImageView, (model.cellHeight - CGFloatIn750(40))/2.0);
    }
}

@end
