//
//  ZStudentLessonOrderDetailOrganizationCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonOrderDetailOrganizationCell.h"

@interface ZStudentLessonOrderDetailOrganizationCell ()
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIImageView *telImageView;
@property (nonatomic,strong) UILabel *telLabel;


@end

@implementation ZStudentLessonOrderDetailOrganizationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initMainView];
    }
    
    return self;
}

- (void)initMainView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.telImageView];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.telLabel];
    
    
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(200));
        make.height.mas_equalTo(CGFloatIn750(160));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImageView.mas_top).offset(CGFloatIn750(12));
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
    }];
    
    [self.telImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leftImageView.mas_bottom).offset(-CGFloatIn750(12));
        make.left.equalTo(self.addressLabel.mas_left);
    }];
    
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.telImageView.mas_centerY);
        make.left.equalTo(self.telImageView.mas_right).offset(CGFloatIn750(20));
    }];
    
}



#pragma mark -Getter
- (UIImageView *)telImageView {
    if (!_telImageView) {
        _telImageView = [[UIImageView alloc] init];
        _telImageView.image = [UIImage imageNamed:@"orderRigthtTel"];
        _telImageView.layer.masksToBounds = YES;
        _telImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _telImageView;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImageView;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = KBlackColor;
        _addressLabel.text = @"";
        _addressLabel.numberOfLines = 0;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [_addressLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _addressLabel;
}

- (UILabel *)telLabel {
    if (!_telLabel) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _telLabel.textColor = KRedColor;
        _telLabel.text = @"";
        _telLabel.numberOfLines = 1;
        _telLabel.textAlignment = NSTextAlignmentRight;
        [_telLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _telLabel;
}


- (void)setModel:(ZStudentLessonOrganizationModel *)model {
    _model = model;
    
    _leftImageView.image = [UIImage imageNamed:model.image];
    _addressLabel.text = model.address;
    _telLabel.text = model.tel;
    
    [ZPublicTool setLineSpacing:6 label:_addressLabel];
}


+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(210);
}
@end




