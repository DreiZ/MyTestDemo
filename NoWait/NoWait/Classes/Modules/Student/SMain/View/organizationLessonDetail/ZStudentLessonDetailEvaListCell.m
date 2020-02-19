//
//  ZStudentLessonDetailEvaListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonDetailEvaListCell.h"
#import "CWStarRateView.h"

@interface ZStudentLessonDetailEvaListCell ()

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *starLabel;
@property (nonatomic,strong) UILabel *evaLabel;
@property (nonatomic,strong) CWStarRateView *crView;
@end

@implementation ZStudentLessonDetailEvaListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.starLabel];
    [self.contentView addSubview:self.evaLabel];
    [self.contentView addSubview:self.crView];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(30));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(20));
        make.width.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.userImageView.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(180));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.userNameLabel.mas_centerY);
    }];
    
    [self.crView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(CGFloatIn750(20));
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(20));
        make.width.offset(CGFloatIn750(160.));
        make.height.offset(CGFloatIn750(30.));
    }];
    
    [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.crView.mas_centerY);
        make.left.equalTo(self.crView.mas_right).offset(CGFloatIn750(20));
    }];
    
    [self.evaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.userImageView.mas_bottom).offset(CGFloatIn750(20));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayBGDark]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(self.userImageView.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
}


#pragma mark -Getter
-(UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.image = [UIImage imageNamed:@"wallhaven5"];
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userImageView.layer.masksToBounds = YES;
        _userImageView.layer.cornerRadius = CGFloatIn750(44);
        _userImageView.clipsToBounds = YES;
    }
    
    return _userImageView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _userNameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _userNameLabel.text = @"";
        _userNameLabel.numberOfLines = 1;
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        [_userNameLabel setFont:[UIFont fontContent]];
    }
    return _userNameLabel;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _timeLabel.text = @"";
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont fontSmall]];
    }
    return _timeLabel;
}

- (UILabel *)starLabel {
    if (!_starLabel) {
        _starLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _starLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _starLabel.text = @"";
        _starLabel.numberOfLines = 1;
        _starLabel.textAlignment = NSTextAlignmentRight;
        [_starLabel setFont:[UIFont fontMin]];
    }
    return _starLabel;
}

- (UILabel *)evaLabel {
    if (!_evaLabel) {
        _evaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _evaLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _evaLabel.text = @"";
        _evaLabel.numberOfLines = 0;
        _evaLabel.textAlignment = NSTextAlignmentLeft;
        [_evaLabel setFont:[UIFont fontContent]];
    }
    return _evaLabel;
}


-(CWStarRateView *)crView
{
    if (!_crView) {
        _crView = [[CWStarRateView alloc] init];
    }
    return _crView;
}


+(CGFloat)z_getCellHeight:(id)sender {
    ZStudentDetailEvaListModel *model = sender;
    CGSize tsize = [model.evaDes tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(148), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(14)];

    return CGFloatIn750(135 + 40) + tsize.height;
}

- (void)setModel:(ZStudentDetailEvaListModel *)model {
    _model = model;
    _userImageView.image = [UIImage imageNamed:model.userImage];
    _userNameLabel.text = model.userName;
    _starLabel.text = model.star;
    _evaLabel.text = model.evaDes;
    _timeLabel.text = model.time;
    
     [self.crView setScorePercent:[model.star floatValue]];
    
    [ZPublicTool setLineSpacing:CGFloatIn750(14) label:self.evaLabel];

}
@end

