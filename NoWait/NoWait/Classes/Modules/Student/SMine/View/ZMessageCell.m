//
//  ZMessageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMessageCell.h"

@interface ZMessageCell ()
@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) UILabel *hintLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *bRightLabel;
@property (nonatomic,strong) UILabel *bLeftLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@end

@implementation ZMessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(10));
    }];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(106));
        make.left.right.top.equalTo(self.contView);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendBtn bk_whenTapped:^{
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(self.model);
        }
    }];
    [topView addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(160));
        make.left.top.bottom.equalTo(topView);
    }];

    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(106));
        make.bottom.equalTo(self.contView.mas_bottom);
        make.left.right.equalTo(self.contView);
    }];


    UIView *middleView = [[UIView alloc] initWithFrame:CGRectZero];
    middleView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(bottomView.mas_top);
        make.left.right.equalTo(self.contView);
    }];

    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];

    [topView addSubview:self.hintLabel];
    [topView addSubview:self.timeLabel];
    
    [middleView addSubview:self.titleLabel];
    [middleView addSubview:self.contentLabel];
    
    [bottomView addSubview:self.bLeftLabel];
    [bottomView addSubview:self.bRightLabel];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(middleView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(middleView.mas_top).offset(CGFloatIn750(0));
        make.right.equalTo(middleView.mas_right).offset(-CGFloatIn750(30));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(28));
        make.left.equalTo(middleView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(middleView.mas_right).offset(-CGFloatIn750(30));
    }];
    
    [self.bLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    
    [self.bRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
}


#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _hintLabel.numberOfLines = 1;
        _hintLabel.textAlignment = NSTextAlignmentLeft;
        [_hintLabel setFont:[UIFont fontContent]];
    }
    return _hintLabel;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [_timeLabel setFont:[UIFont fontSmall]];
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont boldFontMaxTitle]];
    }
    return _titleLabel;
}


- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        [_contentLabel setFont:[UIFont fontContent]];
    }
    return _contentLabel;
}

- (UILabel *)bRightLabel {
    if (!_bRightLabel) {
        _bRightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _bRightLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        
        _bRightLabel.numberOfLines = 1;
        _bRightLabel.textAlignment = NSTextAlignmentLeft;
        [_bRightLabel setFont:[UIFont fontSmall]];
    }
    return _bRightLabel;
}


- (UILabel *)bLeftLabel {
    if (!_bLeftLabel) {
        _bLeftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _bLeftLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        
        _bLeftLabel.numberOfLines = 1;
        _bLeftLabel.textAlignment = NSTextAlignmentRight;
        [_bLeftLabel setFont:[UIFont fontSmall]];
    }
    return _bLeftLabel;
}

- (void)setModel:(ZMineMessageModel *)model {
    _model = model;
    if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
        _hintLabel.text = [NSString stringWithFormat:@"%@:%@人 >",model.type_msg,model.send_num];
    }
    
    _timeLabel.text = [model.create_at timeStringWithFormatter:@"MM-dd HH:mm"];
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    _bRightLabel.text = model.sender1;
    _bLeftLabel.text = model.sender2;
    _hintLabel.text = model.type_msg;
}

+(CGFloat)z_getCellHeight:(id)sender {
    ZMineMessageModel *model = sender;
    CGSize tempSize = [model.content tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(120), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(10)];
    return CGFloatIn750(334) + tempSize.height;
}
@end



