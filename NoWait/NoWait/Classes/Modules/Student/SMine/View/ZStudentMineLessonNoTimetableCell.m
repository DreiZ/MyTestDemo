//
//  ZStudentMineLessonNoTimetableCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/5.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineLessonNoTimetableCell.h"
#import "ZStudentMineLessonTimetableCollectionCell.h"

@interface ZStudentMineLessonNoTimetableCell ()
@property (nonatomic,strong) UILabel *lessonTitleLabel;
@property (nonatomic,strong) UILabel *timeTitleLabel;
@property (nonatomic,strong) UILabel *noDataLabel;

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *bottomView;
@end

@implementation ZStudentMineLessonNoTimetableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(20));
    }];
    
    UIView *topTitleBackView = [[UIView alloc] initWithFrame:CGRectZero];
    topTitleBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contView addSubview:topTitleBackView];
    [topTitleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(122));
        make.right.equalTo(self.contView);
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(14));
    }];
    
    [topTitleBackView addSubview:self.lessonTitleLabel];
    [self.lessonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topTitleBackView.mas_centerY).offset(-CGFloatIn750(20));
        make.centerX.equalTo(topTitleBackView.mas_centerX);
    }];
    
    [topTitleBackView addSubview:self.timeTitleLabel];
    [self.timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.lessonTitleLabel.mas_centerX);
        make.top.equalTo(self.lessonTitleLabel.mas_bottom).offset(CGFloatIn750(8));
    }];
    
    
    [self.contView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(108));
    }];
    
    [self.contView addSubview:self.noDataLabel];
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topTitleBackView.mas_bottom).offset(CGFloatIn750(0));
        make.left.equalTo(self.contView.mas_left);
        make.right.equalTo(self.contView.mas_right);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
}


#pragma mark - 懒加载
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] initWithFrame:CGRectZero];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _contView.layer.cornerRadius = CGFloatIn750(16);
        _contView.clipsToBounds = YES;
    }
    return _contView;
}


- (UILabel *)noDataLabel {
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _noDataLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _noDataLabel.text = @"今日暂无课程";
        _noDataLabel.numberOfLines = 0;
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        [_noDataLabel setFont:[UIFont boldFontContent]];
        
    }
    return _noDataLabel;
}

- (UILabel *)lessonTitleLabel {
    if (!_lessonTitleLabel) {
        _lessonTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _lessonTitleLabel.text = @"今日课程";
        _lessonTitleLabel.numberOfLines = 0;
        _lessonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonTitleLabel setFont:[UIFont boldFontContent]];
    }
    return _lessonTitleLabel;
}

- (UILabel *)timeTitleLabel {
    if (!_timeTitleLabel) {
        
        _timeTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _timeTitleLabel.text = [[NSString stringWithFormat:@"%f",[[NSDate new] timeIntervalSince1970]] timeStringWithFormatter:@"MM/dd"];
        _timeTitleLabel.numberOfLines = 0;
        _timeTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_timeTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(16)]];
    }
    return _timeTitleLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        UIButton *moreBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [moreBtn setTitle:@"查看本周课程  >" forState:UIControlStateNormal];
        [moreBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [moreBtn.titleLabel setFont:[UIFont fontSmall]];
        [moreBtn bk_addEventHandler:^(id sender) {
            if (self.moreBlock) {
                self.moreBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bottomView);
        }];
        
        UIView *spaceLineView = [[UIView alloc] initWithFrame:CGRectZero];
        spaceLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
        [_bottomView addSubview:spaceLineView];
        [spaceLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView.mas_top);
            make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(30));
            make.height.mas_equalTo(1);
        }];
    }
    return _bottomView;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(73 * 2 + 60*2) + CGFloatIn750(40) + CGFloatIn750(60);
}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewShadowRadius(self.contView, CGFloatIn750(20), CGSizeMake(CGFloatIn750(0), CGFloatIn750(0)), 1, adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]));
}
@end


