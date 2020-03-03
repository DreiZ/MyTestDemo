//
//  ZOrganizationTimeLeftCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTimeLeftCell.h"

@interface ZOrganizationTimeLeftCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIView *hintView;

@end

@implementation ZOrganizationTimeLeftCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.hintView];
    [self.contentView addSubview:self.nameLabel];
    
    [self.hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(2));
        make.height.mas_equalTo(CGFloatIn750(40));
        make.width.mas_equalTo(CGFloatIn750(8));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}


#pragma mark -Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.text = @"";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}

- (UIView *)hintView {
    if (!_hintView) {
        _hintView = [[UIView alloc] init];
        _hintView.backgroundColor = [UIColor colorMain];
    }
    return _hintView;
}

- (void)setModel:(ZBaseUnitModel *)model {
    _nameLabel.text = model.name;
    if (model.isSelected) {
        self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        self.hintView.hidden = NO;
    }else{
        self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        self.hintView.hidden = YES;
    }
    
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(108);
}
@end


