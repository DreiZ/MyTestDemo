//
//  ZOrganizationTeachingScheduleLessonCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeachingScheduleLessonCell.h"

@interface ZOrganizationTeachingScheduleLessonCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIImageView *lessonImageView;
@property (nonatomic,strong) UILabel *numLabel;

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIButton *editBtn;

@end

@implementation ZOrganizationTeachingScheduleLessonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(0));
    }];
    
    [self.contView addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.editBtn addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.editBtn.mas_top);
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(0.5);
    }];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.bottom.equalTo(self.editBtn.mas_top);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *lessonBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [lessonBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(1, weakSelf.model);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:lessonBtn];
    [lessonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(topView);
    }];
    
    
    [topView addSubview:self.lessonImageView];
    [topView addSubview:self.detailLabel];
    [topView addSubview:self.nameLabel];
    [topView addSubview:self.numLabel];
    
    [self.lessonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(40));
        make.width.mas_equalTo(CGFloatIn750(240));
        make.height.mas_equalTo(CGFloatIn750(160));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageView.mas_right).offset(CGFloatIn750(16));
        make.top.equalTo(self.lessonImageView.mas_top).offset(CGFloatIn750(10));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
    }];


    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(24));
        make.right.equalTo(self.nameLabel.mas_right);
    }];
    
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.nameLabel.mas_right);
    }];
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

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.text = @"";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray1Dark]);
        _detailLabel.text = @"";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [_detailLabel setFont:[UIFont fontContent]];
    }
    return _detailLabel;
}

- (UIImageView *)lessonImageView {
    if (!_lessonImageView) {
        _lessonImageView = [[UIImageView alloc] init];
        ViewRadius(_lessonImageView, CGFloatIn750(22));
    }
    return _lessonImageView;
}


- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray1Dark]);
        _numLabel.text = @"";
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentLeft;
        [_numLabel setFont:[UIFont fontContent]];
    }
    return _numLabel;
}


- (UIButton *)editBtn {
    if (!_editBtn) {
        __weak typeof(self) weakSelf = self;
        _editBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_editBtn setTitle:@"新建排课" forState:UIControlStateNormal];
        [_editBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_editBtn.titleLabel setFont:[UIFont fontContent]];
        [_editBtn bk_addEventHandler:^(id sender) {
            
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0,self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

- (void)setModel:(ZOriganizationLessonScheduleListModel *)model {
    _model = model;
    
    _nameLabel.text = model.name;
    _detailLabel.text = [NSString stringWithFormat:@"排课人数：%@人",model.wait_students];
    _numLabel.text = [NSString stringWithFormat:@"补课人数：%@人",model.fill_students];
    [_lessonImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.image_url)]];
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(360);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
}
@end




