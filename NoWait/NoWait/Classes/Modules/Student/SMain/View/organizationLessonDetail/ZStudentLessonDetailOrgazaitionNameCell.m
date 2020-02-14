//
//  ZStudentLessonDetailOrgazaitionNameCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonDetailOrgazaitionNameCell.h"

@interface ZStudentLessonDetailOrgazaitionNameCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *evaDesLabel;

@end

@implementation ZStudentLessonDetailOrgazaitionNameCell


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
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.evaDesLabel];
    
     [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.mas_left).offset(CGFloatIn750(40));
         make.centerY.equalTo(self.mas_centerY);
         make.right.equalTo(self.mas_right).offset(-CGFloatIn750(140));
     }];
     
     [self.evaDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
            make.centerY.equalTo(self.mas_centerY);
     }];

}


#pragma mark -Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _titleLabel.text = @"图形俱乐部";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(36)]];
    }
    return _titleLabel;
}


- (UILabel *)evaDesLabel {
    if (!_evaDesLabel) {
        _evaDesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _evaDesLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray]);
        _evaDesLabel.text = @"好评率：98%";
        _evaDesLabel.numberOfLines = 0;
        _evaDesLabel.textAlignment = NSTextAlignmentRight;
        [_evaDesLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _evaDesLabel;
}



+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(90);
}

@end
