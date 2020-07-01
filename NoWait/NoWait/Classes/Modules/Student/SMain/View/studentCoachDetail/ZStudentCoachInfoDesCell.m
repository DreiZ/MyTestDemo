//
//  ZStudentCoachInfoDesCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentCoachInfoDesCell.h"

#define kLabelHeight CGFloatIn750(54)
#define kLabelSpace CGFloatIn750(10)
#define kLabelAddWidth CGFloatIn750(28)
#define kLabelSpaceY CGFloatIn750(30)


@interface ZStudentCoachInfoDesCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UIView *activityView;
@end

@implementation ZStudentCoachInfoDesCell
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
    
    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.infoLabel];
    [self.contentView addSubview:self.activityView];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.width.height.mas_equalTo(CGFloatIn750(280));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_top).offset(CGFloatIn750(40));
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(20));
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-20));
        make.top.equalTo(self.userImageView.mas_centerY).offset(CGFloatIn750(10));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(20));
    }];
    
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _infoLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _infoLabel.numberOfLines = 1;
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        [_infoLabel setFont:[UIFont fontContent]];
    }
    return _infoLabel;
}
- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        ViewRadius(_userImageView, CGFloatIn750(16));
    }
    return _userImageView;
}


- (UIView *)activityView {
    if (!_activityView) {
        _activityView = [[UIView alloc] init];
        _activityView.layer.masksToBounds = YES;
    }
    return _activityView;
}


- (CGFloat)setActivityData:(CGFloat)maxWidth textArr:(NSArray *)adeptArr{
    [self.activityView removeAllSubviews];
    
    CGFloat labelWidth = maxWidth;
    CGFloat leftX = 0;
    CGFloat topY = 0;

    for (int i = 0; i < adeptArr.count; i++) {
       CGSize tempSize = [adeptArr[i] tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
       if (leftX + tempSize.width + kLabelAddWidth + kLabelSpace > labelWidth) {
           topY += kLabelHeight + kLabelSpaceY;
           leftX = 0;
       }
           
        UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, topY, tempSize.width+kLabelAddWidth, kLabelHeight)];
        actLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        actLabel.backgroundColor = adaptAndDarkColor([UIColor colorMainSub], [UIColor colorMainSub]);
        actLabel.text = adeptArr[i];
        actLabel.numberOfLines = 1;
        actLabel.layer.masksToBounds = YES;
        actLabel.layer.cornerRadius = kLabelHeight/2.0f;
        actLabel.textAlignment = NSTextAlignmentCenter;
        [actLabel setFont:[UIFont fontSmall]];
        [self.activityView addSubview:actLabel];
        leftX = actLabel.right + kLabelSpace;
    }
    
    return topY + kLabelHeight;
}

- (void)setDetailModel:(ZOriganizationTeacherAddModel *)detailModel {
    _detailModel = detailModel;
    _nameLabel.text = detailModel.nick_name;
    _infoLabel.text = detailModel.position;
    if (ValidArray(detailModel.skills)) {
        [self setActivityData:KScreenWidth-CGFloatIn750(370) textArr:detailModel.skills];
    }
    [ _userImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(detailModel.image)] placeholderImage:[UIImage imageNamed:@"default_image"]];
}

+(CGFloat)z_getCellHeight:(id)sender {
    ZOriganizationTeacherAddModel *model = sender;
    CGFloat cellHeight = [ZStudentCoachInfoDesCell getActivityWithTextArr:model.skills];
    if (cellHeight > CGFloatIn750(140)) {
        return CGFloatIn750(368) + cellHeight - CGFloatIn750(120);
    }
    return CGFloatIn750(368);
}


+ (CGFloat)getActivityWithTextArr:(NSArray *)adeptArr{
    CGFloat labelWidth = KScreenWidth-CGFloatIn750(370);
    CGFloat leftX = 0;
    CGFloat topY = 0;
    if (!adeptArr) {
        return 0;
    }
    for (int i = 0; i < adeptArr.count; i++) {
       CGSize tempSize = [adeptArr[i] tt_sizeWithFont:[UIFont fontSmall] constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT)];
       if (leftX + tempSize.width + kLabelAddWidth + kLabelSpace > labelWidth) {
           topY += kLabelHeight + kLabelSpaceY;
           leftX = 0;
       }
           
        leftX =  kLabelSpace + leftX + tempSize.width+kLabelAddWidth;
    }
    
    return topY + kLabelHeight;
}

@end



