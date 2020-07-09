//
//  ZOrganizationEvaDetailTitleCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationEvaDetailTitleCell.h"
#import "CWStarRateView.h"

@interface ZOrganizationEvaDetailTitleCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) CWStarRateView *crView;
@property (nonatomic,strong) UIImageView *editImageView;
@property (nonatomic,strong) UIButton *editBtn;

@end

@implementation ZOrganizationEvaDetailTitleCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.crView];
    [self.contentView addSubview:self.editImageView];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
   
    [self.editImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(20));
    }];
    
    [self.contentView addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.editImageView.mas_left).offset(-CGFloatIn750(40));
    }];

    [self.crView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(16));
        make.right.equalTo(self.editImageView.mas_left).offset(-CGFloatIn750(30));
        make.width.offset(CGFloatIn750(110.));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}


#pragma mark -Getter
-(CWStarRateView *)crView
{
    if (!_crView) {
        _crView = [[CWStarRateView alloc] init];
    }
    return _crView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.text = @"课程评价";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}

- (UIImageView *)editImageView {
    if (!_editImageView) {
        _editImageView = [[UIImageView alloc] init];
        _editImageView.image = [[UIImage imageNamed:@"changeEva"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _editImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    }
    return _editImageView;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        __weak typeof(self) weakSelf = self;
        [_editBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _editBtn;
}

- (void)setData:(NSDictionary *)data {
    if (ValidDict(data)) {
        _nameLabel.text = data[@"title"];
        _crView.scorePercent = [data[@"star"] doubleValue]/10.0f * 2;
        
        if ([data objectForKey:@"no"] && [data[@"no"] isEqualToString:@"0"]) {
            self.editBtn.hidden = NO;
            self.editImageView.hidden = NO;
            [self.crView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(CGFloatIn750(16));
                make.right.equalTo(self.editImageView.mas_left).offset(-CGFloatIn750(30));
                make.width.offset(CGFloatIn750(110.));
                make.centerY.equalTo(self.mas_centerY);
            }];
        }else{
            self.editBtn.hidden = YES;
            self.editImageView.hidden = YES;
            [self.crView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(CGFloatIn750(16));
                make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                make.width.offset(CGFloatIn750(110.));
                make.centerY.equalTo(self.mas_centerY);
            }];
        }
    }
    
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(70);
}
@end



