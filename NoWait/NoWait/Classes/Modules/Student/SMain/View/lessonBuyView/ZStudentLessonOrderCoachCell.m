//
//  ZStudentLessonOrderCoachCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.

#import "ZStudentLessonOrderCoachCell.h"

@interface ZStudentLessonOrderCoachCell ()

@property (nonatomic,strong) UIImageView *coachImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *adeptLabel;
@property (nonatomic,strong) UILabel *desLabel;
@property (nonatomic,strong) UILabel *authLabel;

@property (nonatomic,strong) UIView *introductionView;
@property (nonatomic,strong) UIView *activityView;
@property (nonatomic,strong) UIView *authView;


@end

@implementation ZStudentLessonOrderCoachCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    
    [self.contentView addSubview:self.coachImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.adeptLabel];
    [self.contentView addSubview:self.desLabel];
    [self.contentView addSubview:self.authView];
    [self.contentView addSubview:self.activityView];
    [self.contentView addSubview:self.introductionView];
    
    [self.coachImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(30));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(20));
        make.width.height.mas_equalTo(CGFloatIn750(160));
    }];
    
    [self.authView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coachImageView.mas_top).offset(CGFloatIn750(8));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(0.1));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coachImageView.mas_right).offset(CGFloatIn750(16));
        make.centerY.equalTo(self.authView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(70));
    }];
    
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(CGFloatIn750(4));
        make.top.equalTo(self.nameLabel.mas_top);
        make.right.equalTo(self.authView.mas_left).offset(CGFloatIn750(-10));
    }];
    
    [self.adeptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coachImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.activityView.mas_bottom).offset(CGFloatIn750(26));
        make.width.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.introductionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.adeptLabel.mas_right).offset(CGFloatIn750(4));
        make.top.equalTo(self.activityView.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.introductionView.mas_bottom).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
    }];
    
}


#pragma mark -Getter
-(UIImageView *)coachImageView {
    if (!_coachImageView) {
        _coachImageView = [[UIImageView alloc] init];
        _coachImageView.image = [UIImage imageNamed:@"serverTopbg"];
        _coachImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coachImageView.clipsToBounds = YES;
    }
    
    return _coachImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _nameLabel.text = @"图形俱乐部";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}


- (UILabel *)adeptLabel {
    if (!_adeptLabel) {
        _adeptLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _adeptLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _adeptLabel.text = @"";
        _adeptLabel.numberOfLines = 1;
        _adeptLabel.textAlignment = NSTextAlignmentLeft;
        [_adeptLabel setFont:[UIFont fontContent]];
    }
    return _adeptLabel;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _desLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _desLabel.text = @"";
        _desLabel.numberOfLines = 0;
        _desLabel.textAlignment = NSTextAlignmentLeft;
        [_desLabel setFont:[UIFont fontContent]];
    }
    return _desLabel;
}


- (UILabel *)authLabel {
    if (!_authLabel) {
        _authLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _authLabel.textColor = [UIColor colorOrangeMoment];
        _authLabel.text = @"";
        _authLabel.numberOfLines = 1;
        _authLabel.textAlignment = NSTextAlignmentLeft;
        [_authLabel setFont:[UIFont fontMin]];
    }
    return _authLabel;
}



- (UIView *)introductionView {
    if (!_introductionView) {
        _introductionView = [[UIView alloc] init];
        _introductionView.layer.masksToBounds = YES;
    }
    return _introductionView;
}

- (UIView *)activityView {
    if (!_activityView) {
        _activityView = [[UIView alloc] init];
        _activityView.layer.masksToBounds = YES;
    }
    return _activityView;
}


- (UIView *)authView {
    if (!_authView) {
        _authView = [[UIView alloc] init];
        _authView.layer.masksToBounds = YES;
        _authView.clipsToBounds = YES;
        _authView.layer.borderColor = [UIColor colorOrangeMoment].CGColor;
        _authView.layer.cornerRadius = CGFloatIn750(16);
        _authView.layer.borderWidth = 1;
        
        UIImageView *authImageView = [[UIImageView alloc] init];
        authImageView.image = [UIImage imageNamed:@"orderAuthLesson"];
        authImageView.layer.masksToBounds = YES;
        [_authView addSubview:authImageView];
        [authImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.authView.mas_left).offset(CGFloatIn750(10));
            make.centerY.equalTo(self.authView.mas_centerY);
        }];
        
        [_authView addSubview:self.authLabel];
        [self.authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.authView.mas_centerY);
            make.left.equalTo(authImageView.mas_right).offset(CGFloatIn750(8));
        }];
    }
    return _authView;
}



+(CGFloat)z_getCellHeight:(id)sender {
//    return CGFloatIn750(200) + CGFloatIn750(168);
    
    CGFloat cellHeight = CGFloatIn750(40);
    
    
    ZStudentDetailLessonOrderCoachModel *model = sender;
    CGFloat authWidth = 0;
    if (model.auth && model.auth.length > 0) {
       CGSize tsize = [model.auth tt_sizeWithFont:[UIFont fontMin] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(230 ), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(0)];
       
       authWidth = CGFloatIn750(tsize.width + 110);
    }
    
    CGFloat nameWidth = CGFloatIn750(70);
    if (model.coachName && model.coachName.length > 0) {
       CGSize tsize = [model.coachName tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth , MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(0)];
        
       nameWidth = CGFloatIn750(tsize.width + 10);
    }
     
    NSArray *textArr = model.labelArr;
    
    CGFloat labelWidth = KScreenWidth - CGFloatIn750(260) - nameWidth - authWidth;
    CGFloat leftX = 0;
    CGFloat topY = 0;
    CGFloat space = CGFloatIn750(10);
//标签
    for (int i = 0; i < textArr.count; i++) {
        CGSize tempSize = [textArr[i] tt_sizeWithFont:[UIFont fontMin] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
        if (leftX + tempSize.width + CGFloatIn750(16) + space > labelWidth) {
            topY += CGFloatIn750(32) + space;
            leftX = 0;
        }
       
        leftX += tempSize.width+CGFloatIn750(16) + space;
    }
    
    cellHeight += (topY+CGFloatIn750(32)) + CGFloatIn750(32);
        
    //擅长
    {
        NSArray *adeptArr = model.adeptArr;
           
        CGFloat labelWidth = KScreenWidth - CGFloatIn750(290);
        CGFloat leftX = 0;
        CGFloat topY = 0;
        CGFloat space = CGFloatIn750(10);

        for (int i = 0; i < adeptArr.count; i++) {
           CGSize tempSize = [adeptArr[i] tt_sizeWithFont:[UIFont fontMin] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
           if (leftX + tempSize.width + CGFloatIn750(16) + space > labelWidth) {
               topY += CGFloatIn750(32) + space;
               leftX = 0;
           }
               

            leftX += tempSize.width + CGFloatIn750(16) + CGFloatIn750(24);
        }
        cellHeight += (topY + CGFloatIn750(32)) + CGFloatIn750(32);
    }
        
   CGSize desSize = [model.desStr tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(210), MAXFLOAT)];
    
    return cellHeight + desSize.height + CGFloatIn750(30);
}


- (UIView *)getViewWithText:(NSString *)text leftX:(CGFloat)leftX{
     CGSize tempSize = [text tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)];
    
    UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, 0, tempSize.width+6, CGFloatIn750(30))];
    actLabel.textColor = [UIColor colorWhite];
    actLabel.backgroundColor = [UIColor colorMain];
//    actLabel.layer.masksToBounds = YES;
//    actLabel.layer.cornerRadius = 2;
//    actLabel.layer.borderColor = [UIColor colorOrangeMoment].CGColor;
//    actLabel.layer.borderWidth = 0.5;
    actLabel.text = text;
    actLabel.numberOfLines = 1;
    actLabel.textAlignment = NSTextAlignmentCenter;
    [actLabel setFont:[UIFont fontMin]];
    
    
    return actLabel;
}

- (void)setModel:(ZStudentDetailLessonOrderCoachModel *)model {
    [self.activityView removeAllSubviews];
    [self.introductionView removeAllSubviews];
    
    self.nameLabel.text = model.coachName;
    self.authLabel.text = model.auth;
    self.adeptLabel.text = @"擅长：";
    self.desLabel.text = model.desStr;
    
    CGFloat authWidth = 0;
    if (model.auth && model.auth.length > 0) {
       CGSize tsize = [model.auth tt_sizeWithFont:[UIFont fontMin] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(230 ), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(0)];
       
       [self.authView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.coachImageView.mas_top).offset(CGFloatIn750(8));
           make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
           make.height.mas_equalTo(CGFloatIn750(30));
           make.width.mas_equalTo(CGFloatIn750(tsize.width + 110));
       }];
       authWidth = CGFloatIn750(tsize.width + 110);
    }else{
       [self.authView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.coachImageView.mas_top).offset(CGFloatIn750(8));
           make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(10));
           make.height.mas_equalTo(CGFloatIn750(30));
           make.width.mas_equalTo(0);
       }];
    }
    
    CGFloat nameWidth = CGFloatIn750(70);
    if (model.coachName && model.coachName.length > 0) {
       CGSize tsize = [model.coachName tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth , MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(0)];
       
       [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.coachImageView.mas_right).offset(CGFloatIn750(16));
           make.centerY.equalTo(self.authView.mas_centerY);
           make.width.mas_equalTo(tsize.width + 20);
       }];
        
       nameWidth = CGFloatIn750(tsize.width + 10);
    }else{
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.coachImageView.mas_right).offset(CGFloatIn750(16));
           make.centerY.equalTo(self.authView.mas_centerY);
           make.width.mas_equalTo(CGFloatIn750(70));
       }];
    }
     
    NSArray *textArr = model.labelArr;
    
    CGFloat labelWidth = KScreenWidth - CGFloatIn750(260) - nameWidth - authWidth;
    CGFloat leftX = 0;
    CGFloat topY = 0;
    CGFloat space = CGFloatIn750(10);
//标签
    for (int i = 0; i < textArr.count; i++) {
        CGSize tempSize = [textArr[i] tt_sizeWithFont:[UIFont fontMin] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
        if (leftX + tempSize.width + CGFloatIn750(16) + space > labelWidth) {
            topY += CGFloatIn750(32) + space;
            leftX = 0;
        }
            
        UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, topY, tempSize.width+CGFloatIn750(16), CGFloatIn750(32))];
        actLabel.textColor = [UIColor colorWhite];
        actLabel.backgroundColor = [UIColor colorMain];
        actLabel.layer.masksToBounds = YES;
        actLabel.layer.cornerRadius = 2;
        actLabel.text = textArr[i];
        actLabel.numberOfLines = 1;
        actLabel.textAlignment = NSTextAlignmentCenter;
        [actLabel setFont:[UIFont fontMin]];
        [self.activityView addSubview:actLabel];
        leftX = actLabel.right + space;
    }
    [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(CGFloatIn750(4));
        make.top.equalTo(self.nameLabel.mas_top);
        make.right.equalTo(self.authView.mas_left).offset(CGFloatIn750(-10));
        make.height.mas_equalTo(topY+CGFloatIn750(32));
    }];
    
//擅长
    {
        
        NSArray *adeptArr = model.adeptArr;
           
        CGFloat labelWidth = KScreenWidth - CGFloatIn750(290);
        CGFloat leftX = 0;
        CGFloat topY = 0;
        CGFloat space = CGFloatIn750(10);

        for (int i = 0; i < adeptArr.count; i++) {
           CGSize tempSize = [adeptArr[i] tt_sizeWithFont:[UIFont fontMin] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
           if (leftX + tempSize.width + CGFloatIn750(16) + space > labelWidth) {
               topY += CGFloatIn750(32) + space;
               leftX = 0;
           }
               
           UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, topY, tempSize.width+CGFloatIn750(24), CGFloatIn750(32))];
           actLabel.textColor = [UIColor colorMain];
           actLabel.text = adeptArr[i];
           actLabel.numberOfLines = 1;
            actLabel.layer.masksToBounds = YES;
            actLabel.layer.cornerRadius = CGFloatIn750(16);
            actLabel.layer.borderColor = [UIColor colorMain].CGColor;
            actLabel.layer.borderWidth = 1;
           actLabel.textAlignment = NSTextAlignmentCenter;
           [actLabel setFont:[UIFont fontMin]];
           [self.introductionView addSubview:actLabel];
           leftX = actLabel.right + CGFloatIn750(24);
        }
        [self.introductionView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.adeptLabel.mas_right).offset(CGFloatIn750(4));
           make.top.equalTo(self.adeptLabel.mas_top);
           make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
            make.height.mas_equalTo(topY+CGFloatIn750(32));
        }];
    }
    
    self.desLabel.text = model.desStr;
    self.authLabel.text = model.auth;
    
    [ZPublicTool setLineSpacing:CGFloatIn750(8) label:self.desLabel];
}
@end
