//
//  ZOrganizationDetailNumAndMinCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/1.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationDetailNumAndMinCell.h"
@interface ZOrganizationDetailNumAndMinCell ()

@property (nonatomic,strong) UILabel *minLabel;
@property (nonatomic,strong) UILabel *numLabel;

@property (nonatomic,strong) UIImageView *numHintImageView;

@end

@implementation ZOrganizationDetailNumAndMinCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.minLabel];
    [self.contentView addSubview:self.numHintImageView];
    [self.contentView addSubview:self.numLabel];

    
    [self.minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.numHintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLabel.mas_left).offset(-CGFloatIn750(12));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}


#pragma mark -Getter
- (UILabel *)minLabel {
    if (!_minLabel) {
        _minLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _minLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _minLabel.text = @"";
        _minLabel.numberOfLines = 1;
        _minLabel.textAlignment = NSTextAlignmentLeft;
        [_minLabel setFont:[UIFont fontSmall]];
    }
    return _minLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _numLabel.text = @"30人";
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentRight;
        [_numLabel setFont:[UIFont fontSmall]];
    }
    return _numLabel;
}


- (UIImageView *)numHintImageView {
    if (!_numHintImageView) {
        _numHintImageView = [[UIImageView alloc] init];
        _numHintImageView.image = [[UIImage imageNamed:@"peoples_hint"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _numHintImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _numHintImageView.layer.masksToBounds = YES;
        _numHintImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _numHintImageView;
}

- (void)setModel:(ZBaseSingleCellModel *)model {
    _model = model;
    _minLabel.text = [NSString stringWithFormat:@"%@",model.leftTitle];
    _numLabel.text = [NSString stringWithFormat:@"%@人",model.rightTitle];
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(60);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    _numHintImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
}
@end


