//
//  ZStudentOrganizationLessonListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationLessonListCell.h"

@interface ZStudentOrganizationLessonListCell ()

@property (nonatomic,strong) UIImageView *lessonImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *favourablePriceLabel;
@property (nonatomic,strong) UILabel *goodReputationLabel;
@property (nonatomic,strong) UILabel *sellCountLabel;
@property (nonatomic,strong) UIButton *collectionBtn;

@end

@implementation ZStudentOrganizationLessonListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.lessonImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.favourablePriceLabel];
    [self.contentView addSubview:self.goodReputationLabel];
    [self.contentView addSubview:self.sellCountLabel];
    [self.contentView addSubview:self.collectionBtn];
    
    [self.lessonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(210));
        make.height.mas_equalTo(CGFloatIn750(140));
    }];
    
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_right);
        make.height.width.mas_equalTo(CGFloatIn750(84));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.lessonImageView.mas_top);
        make.right.equalTo(self.collectionBtn.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageView.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.lessonImageView.mas_centerY);
    }];
    
    [self.favourablePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.priceLabel.mas_bottom).offset(-3);
        make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(4));
    }];
    
    [self.goodReputationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageView.mas_right).offset(CGFloatIn750(24));
        make.top.equalTo(self.favourablePriceLabel.mas_bottom).offset(CGFloatIn750(16));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(120));
    }];
    
    [self.sellCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.goodReputationLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
}


#pragma mark -Getter
-(UIImageView *)lessonImageView {
    if (!_lessonImageView) {
        _lessonImageView = [[UIImageView alloc] init];
        _lessonImageView.contentMode = UIViewContentModeScaleAspectFill;
        _lessonImageView.clipsToBounds = YES;
        _lessonImageView.layer.cornerRadius = 3;
        _lessonImageView.layer.masksToBounds = YES;
    }
    
    return _lessonImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontTitle]];
    }
    return _titleLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = [UIColor colorRedDefault];
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont fontContent]];
    }
    return _priceLabel;
}

- (UILabel *)favourablePriceLabel {
    if (!_favourablePriceLabel) {
        _favourablePriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _favourablePriceLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _favourablePriceLabel.numberOfLines = 1;
        _favourablePriceLabel.textAlignment = NSTextAlignmentRight;
        [_favourablePriceLabel setFont:[UIFont fontMin]];
    }
    return _favourablePriceLabel;
}

- (UILabel *)goodReputationLabel {
    if (!_goodReputationLabel) {
        _goodReputationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodReputationLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        
        _goodReputationLabel.numberOfLines = 1;
        _goodReputationLabel.textAlignment = NSTextAlignmentLeft;
        [_goodReputationLabel setFont:[UIFont fontSmall]];
    }
    return _goodReputationLabel;
}

- (UILabel *)sellCountLabel {
    if (!_sellCountLabel) {
        _sellCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _sellCountLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _sellCountLabel.numberOfLines = 1;
        _sellCountLabel.textAlignment = NSTextAlignmentRight;
        [_sellCountLabel setFont:[UIFont fontSmall]];
    }
    return _sellCountLabel;
}


- (UIButton *)collectionBtn {
    if (!_collectionBtn) {
        __weak typeof(self) weakSelf = self;
        _collectionBtn = [[UIButton alloc] initWithFrame:CGRectZero];
//        [_collectionBtn setImage:[UIImage imageNamed:@"collectionHandle"] forState:UIControlStateNormal];
        UIImageView *collectionImageView = [[UIImageView alloc] init];
        collectionImageView.image = [UIImage imageNamed:@"collectionHandle"];
        collectionImageView.layer.masksToBounds = YES;
        [_collectionBtn addSubview:collectionImageView];
        [collectionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.collectionBtn);
            make.height.width.mas_equalTo(CGFloatIn750(20));
        }];
        [_collectionBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(self.model);
            };
        }];
    }
    return _collectionBtn;
}


- (void)setModel:(ZOriganizationLessonListModel *)model {
    _model = model;
    [_lessonImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.image_url)] placeholderImage:[UIImage imageNamed:@"default_image32"]];
    _sellCountLabel.text = [NSString stringWithFormat:@"已售%@",model.pay_nums];
    _goodReputationLabel.text = [NSString stringWithFormat:@"%d%@好评",[model.score intValue] * 20,@"%"];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    _titleLabel.text = model.name;
//    _favourablePriceLabel.text = @"￥256";
    
    if (model.isStudentCollection) {
        [self.collectionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
            make.height.width.mas_equalTo(CGFloatIn750(84));
        }];
    }else {
        [self.collectionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_right);
            make.height.width.mas_equalTo(CGFloatIn750(84));
        }];
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(170);
}
@end
