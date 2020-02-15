//
//  ZStudentMessageListDetailCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMessageListDetailCell.h"
@interface ZStudentMessageListDetailCell ()

@property (nonatomic,strong) UIImageView *arrowImageView;
@property (nonatomic,strong) UILabel *messageTitleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *checkLabel;
@property (nonatomic,strong) UIButton *detailbtn;

@end

@implementation ZStudentMessageListDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
    
    UIView *contView = [[UIView alloc] init];
    contView.layer.masksToBounds = YES;
    contView.layer.cornerRadius = CGFloatIn750(12);
    [self.contentView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-20));
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(30));
    }];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    [contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.right.top.equalTo(contView);
    }];

    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    [contView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.bottom.equalTo(contView.mas_bottom).offset(-CGFloatIn750(20));
        make.left.right.equalTo(contView);
    }];


    UIView *middleView = [[UIView alloc] initWithFrame:CGRectZero];
    middleView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    [contView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(bottomView.mas_top).offset(-CGFloatIn750(0));
        make.left.right.equalTo(contView);
    }];


    [topView addSubview:self.messageTitleLabel];
    [middleView addSubview:self.detailLabel];
    
    [bottomView addSubview:self.arrowImageView];
    [bottomView addSubview:self.checkLabel];
    [bottomView addSubview:self.detailbtn];
    
    [self.messageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(35));
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorBlackBG]);
    [topView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(topView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(middleView.mas_left).offset(CGFloatIn750(35));
        make.top.equalTo(middleView.mas_top).offset(CGFloatIn750(30));
        make.right.equalTo(middleView.mas_right).offset(-CGFloatIn750(35));
    }];

    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.right.equalTo(bottomView.mas_right).offset(CGFloatIn750(8));
    }];

    
    [self.checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.mas_left).offset(CGFloatIn750(-30));
        make.centerY.equalTo(self.arrowImageView.mas_centerY);
    }];
    
    
    [self.detailbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(bottomView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(40));
        make.width.mas_equalTo(CGFloatIn750(100));
    }];
    
    [ZPublicTool setLineSpacing:CGFloatIn750(14) label:self.detailLabel];
}


#pragma mark -Getter
-(UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"rightBlackArrow"];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImageView.clipsToBounds = YES;
    }
    
    return _arrowImageView;
}

- (UILabel *)messageTitleLabel {
    if (!_messageTitleLabel) {
        _messageTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _messageTitleLabel.text = @"课程消息";
        _messageTitleLabel.numberOfLines = 1;
        _messageTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_messageTitleLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(28)]];
    }
    return _messageTitleLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = [UIColor colorTextGray];
        _detailLabel.text = @"暑期瑜伽班公司接发哦坯价格平均阿婆说价格破解爱唯欧评价安慰法噶是干啥的噶是的";
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [_detailLabel setFont:[UIFont fontContent]];
    }
    return _detailLabel;
}

- (UILabel *)checkLabel {
    if (!_checkLabel) {
        _checkLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _checkLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _checkLabel.text = @"查看详情";
        _checkLabel.numberOfLines = 1;
        _checkLabel.textAlignment = NSTextAlignmentLeft;
        [_checkLabel setFont:[UIFont fontSmall]];
    }
    return _checkLabel;
}


- (UIButton *)detailbtn {
    if (!_detailbtn) {
        _detailbtn = [[UIButton alloc] initWithFrame:CGRectZero];
        __weak typeof(self) weakSelf = self;
        [_detailbtn bk_whenTapped:^{
            if (weakSelf.detailBlock) {
                weakSelf.detailBlock();
            }
        }];
    }
    return _detailbtn;
}

+(CGFloat)z_getCellHeight:(id)sender {
    CGSize tsize = [@"暑期瑜伽班公司接发哦坯价格平均阿婆说价格破解爱唯欧评价安慰法噶是干啥的噶是的" tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(110), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(14)];

    return CGFloatIn750(180 + 40) + tsize.height;

}
@end

