//
//  ZOrganizationLessonManageListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonManageListCell.h"

@interface ZOrganizationLessonManageListCell ()

@property (nonatomic,strong) UILabel *lessonNameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *lessonStatelabel;
@property (nonatomic,strong) UILabel *scoreLabel;
@property (nonatomic,strong) UILabel *salesNumLabel;

@property (nonatomic,strong) UILabel *failHintLabel;
@property (nonatomic,strong) UILabel *failLabel;

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *midView;
@property (nonatomic,strong) UIView *failView;
@property (nonatomic,strong) UIView *topView;

@property (nonatomic,strong) UIButton *delBtn;
@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *openBtn;

@end

@implementation ZOrganizationLessonManageListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(0));
    }];
    
    
    [self.contView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    
    [self.contView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(136));
    }];
    
    [self.contView addSubview:self.failView];
    [self.failView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.height.mas_equalTo(50);
    }];
    
    
    [self.contView addSubview:self.midView];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.failView.mas_top);
    }];
    
    [self.topView addSubview:self.lessonStatelabel];
    [self.lessonStatelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    [self.midView addSubview:self.leftImageView];
    [self.midView addSubview:self.priceLabel];
    [self.midView addSubview:self.salesNumLabel];
    [self.midView addSubview:self.lessonNameLabel];
    [self.midView addSubview:self.scoreLabel];

   [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.midView.mas_left).offset(CGFloatIn750(30));
       make.top.bottom.equalTo(self.midView);
       make.width.mas_equalTo(CGFloatIn750(240));
   }];

    [self.lessonNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.leftImageView.mas_top).offset(CGFloatIn750(2));
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonNameLabel.mas_left);
        make.top.equalTo(self.leftImageView.mas_centerY).offset(CGFloatIn750(0));
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];

    [self.salesNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonNameLabel.mas_left);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(CGFloatIn750(16));
    }];

    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.salesNumLabel.mas_centerY);
    }];

    
    [self.bottomView addSubview:self.editBtn];
    [self.bottomView addSubview:self.openBtn];
    [self.bottomView addSubview:self.closeBtn];
    [self.bottomView addSubview:self.delBtn];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);;
    }];
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.failView addSubview:self.failHintLabel];
    [self.failView addSubview:self.failLabel];
    [self.failHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.failView);
    }];

    [self.failLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.failView);
    }];
    [ZPublicTool setLineSpacing:CGFloatIn750(10) label:self.failLabel];
}


#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(12));
    }
    return _contView;
}

- (UIView *)failView {
    if (!_failView) {
        _failView = [[UIView alloc] init];
        _failView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _failView.clipsToBounds = YES;
    }
    return _failView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _topView.clipsToBounds = YES;
    }
    return _topView;
}

- (UIView *)midView {
    if (!_midView) {
        _midView = [[UIView alloc] init];
        _midView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _midView.clipsToBounds = YES;
    }
    return _midView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _bottomView.clipsToBounds = YES;
    }
    return _bottomView;
}

- (UILabel *)lessonNameLabel {
    if (!_lessonNameLabel) {
        _lessonNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonNameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _lessonNameLabel.text = @"开放课程";
        _lessonNameLabel.numberOfLines = 1;
        _lessonNameLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonNameLabel setFont:[UIFont boldFontTitle]];
    }
    return _lessonNameLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorRedForButton],[UIColor colorRedForButton]);
        _priceLabel.text = @"$345";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont fontContent]];
    }
    return _priceLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"serverTopbg"];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_leftImageView, CGFloatIn750(12));
    }
    return _leftImageView;
}


- (UILabel *)salesNumLabel {
    if (!_salesNumLabel) {
        _salesNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _salesNumLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _salesNumLabel.text = @"已售20";
        _salesNumLabel.numberOfLines = 1;
        _salesNumLabel.textAlignment = NSTextAlignmentLeft;
        [_salesNumLabel setFont:[UIFont fontSmall]];
    }
    return _salesNumLabel;
}


- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _scoreLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _scoreLabel.text = @"4.0分";
        _scoreLabel.numberOfLines = 1;
        _scoreLabel.textAlignment = NSTextAlignmentRight;
        [_scoreLabel setFont:[UIFont fontSmall]];
    }
    return _scoreLabel;
}


- (UILabel *)lessonStatelabel {
    if (!_lessonStatelabel) {
        _lessonStatelabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonStatelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _lessonStatelabel.text = @"";
        _lessonStatelabel.numberOfLines = 1;
        _lessonStatelabel.textAlignment = NSTextAlignmentLeft;
        [_lessonStatelabel setFont:[UIFont fontSmall]];
    }
    return _lessonStatelabel;
}


- (UILabel *)failHintLabel {
    if (!_failHintLabel) {
        _failHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _failHintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _failHintLabel.text = @"失败原因:";
        _failHintLabel.numberOfLines = 1;
        _failHintLabel.textAlignment = NSTextAlignmentLeft;
        [_failHintLabel setFont:[UIFont fontSmall]];
    }
    return _failHintLabel;
}


- (UILabel *)failLabel {
    if (!_failLabel) {
        _failLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _failLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _failLabel.text = @"";
        _failLabel.numberOfLines = 0;
        _failLabel.textAlignment = NSTextAlignmentLeft;
        [_failLabel setFont:[UIFont fontSmall]];
    }
    return _failLabel;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        __weak typeof(self) weakSelf = self;
        _editBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_editBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_editBtn, CGFloatIn750(28), CGFloatIn750(2), [UIColor colorMain]);
        [_editBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0,self.model);
            };
        }];
    }
    return _editBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        __weak typeof(self) weakSelf = self;
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_closeBtn setTitle:@"关闭课程" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_closeBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_closeBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_closeBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1,self.model);
            };
        }];
    }
    return _closeBtn;
}

- (UIButton *)delBtn {
    if (!_delBtn) {
        __weak typeof(self) weakSelf = self;
        _delBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_delBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_delBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_delBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_delBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2,self.model);
            };
        }];
    }
    return _delBtn;
}


- (UIButton *)openBtn {
    if (!_openBtn) {
        __weak typeof(self) weakSelf = self;
        _openBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_openBtn setTitle:@"开放课程" forState:UIControlStateNormal];
        [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_openBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [_openBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_openBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]));
        [_openBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(3,self.model);
            };
        }];
    }
    return _openBtn;
}

#pragma mark - set model
- (void)setModel:(ZOriganizationLessonListModel *)model {
    _model = model;
    
    [self.leftImageView tt_setImageWithURL:[NSURL URLWithString:model.image]];
    self.lessonStatelabel.text = model.state;
    self.lessonNameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.salesNumLabel.text = [NSString stringWithFormat:@"已售%@",model.sale];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@分",model.score];
    self.failLabel.text = model.fail;
    
    switch (model.type) {
        case ZOrganizationLessonTypeOpen:
        {
            self.lessonStatelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
            
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(self.contView);
                make.height.mas_equalTo(CGFloatIn750(136));
            }];
            
            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.bottomView.mas_top);
            }];
            
            self.bottomView.hidden = NO;
            self.failView.hidden = YES;
            self.editBtn.hidden = NO;
            self.closeBtn.hidden = NO;
            
            self.openBtn.hidden = YES;
            self.delBtn.hidden = YES;
            
            [self.editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(116));
            }];
            
            [self.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.editBtn.mas_left).offset(CGFloatIn750(-20));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
        }
            break;
        case ZOrganizationLessonTypeClose:
        {
            self.lessonStatelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
            
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(self.contView);
                make.height.mas_equalTo(CGFloatIn750(136));
            }];
            
            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.bottomView.mas_top);
            }];
            
            self.bottomView.hidden = NO;
            self.failView.hidden = YES;
            self.editBtn.hidden = NO;
            self.closeBtn.hidden = YES;
            
            self.openBtn.hidden = NO;
            self.delBtn.hidden = NO;
            
            
            [self.editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(116));
            }];
            
            [self.openBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.editBtn.mas_left).offset(CGFloatIn750(-20));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
            
            [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.openBtn.mas_left).offset(CGFloatIn750(-20));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(116));
            }];
        }
            break;
        case ZOrganizationLessonTypeExamine:
        {
            self.lessonStatelabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray1Dark]);
            self.salesNumLabel.text = @"审核中...";
            
            
            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
            }];
            
            self.bottomView.hidden = YES;
            self.failView.hidden = YES;
            self.editBtn.hidden = YES;
            self.closeBtn.hidden = YES;
            
            self.openBtn.hidden = YES;
            self.delBtn.hidden = YES;
            
        }
            break;
        case ZOrganizationLessonTypeExamineFail:
        {
            self.lessonStatelabel.textColor = adaptAndDarkColor([UIColor colorRedDefault],[UIColor colorRedDefault]);
            self.salesNumLabel.text = @"";
            
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.bottom.equalTo(self.contView.mas_bottom);
                make.height.mas_equalTo(CGFloatIn750(136));
            }];
            
            NSString *fail = self.model.fail ? self.model.fail : @"";
            CGSize failSize = [fail tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake((KScreenWidth - CGFloatIn750(30) * 2 - CGFloatIn750(30) - CGFloatIn750(16) - CGFloatIn750(240) - CGFloatIn750(30)), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(10)];
            
            [self.failView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.bottom.equalTo(self.bottomView.mas_top);
                make.height.mas_equalTo(CGFloatIn750(36) + failSize.height + 4);
            }];
            
            [self.failHintLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.leftImageView);
                make.top.equalTo(self.failView.mas_top).offset(CGFloatIn750(34));
            }];
            
            
            [self.failLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.failHintLabel.mas_right).offset(CGFloatIn750(16));
                make.top.equalTo(self.failHintLabel.mas_top);
                make.right.equalTo(self.failView.mas_right).offset(-CGFloatIn750(30));
            }];
            
            [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.failView.mas_top);
            }];
            
            
            self.bottomView.hidden = NO;
            self.failView.hidden = NO;
            self.editBtn.hidden = NO;
            self.closeBtn.hidden = YES;
                       
            self.openBtn.hidden = YES;
            self.delBtn.hidden = NO;
            
            [self.editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(116));
            }];
            
            [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.editBtn.mas_left).offset(CGFloatIn750(-20));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(116));
            }];
            
            [ZPublicTool setLineSpacing:CGFloatIn750(10) label:self.failLabel];
        }
            break;
            
        default:
            break;
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    if (sender && [sender isKindOfClass:[ZOriganizationLessonListModel class]]) {
        ZOriganizationLessonListModel *listModel = (ZOriganizationLessonListModel *)sender;
        if (listModel.type == ZOrganizationLessonTypeExamine) {
            return CGFloatIn750(308);
        }else if (listModel.type == ZOrganizationLessonTypeExamineFail){
            NSString *fail = listModel.fail ? listModel.fail : @"";
            CGSize failSize = [fail tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake((KScreenWidth - CGFloatIn750(30) * 2 - CGFloatIn750(30) - CGFloatIn750(16) - CGFloatIn750(240) - CGFloatIn750(30)), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(10)];
            return CGFloatIn750(404) + failSize.height + CGFloatIn750(40);
        } else{
            return CGFloatIn750(404);
        }
    }
    
    return CGFloatIn750(0);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_closeBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    
    ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
}
@end


