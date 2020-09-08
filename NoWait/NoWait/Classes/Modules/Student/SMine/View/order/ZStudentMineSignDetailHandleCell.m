//
//  ZStudentMineSignDetailHandleCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSignDetailHandleCell.h"
@interface ZStudentMineSignDetailHandleCell ()
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UIButton *signBtn;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@end

@implementation ZStudentMineSignDetailHandleCell
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
    
    [self.contentView addSubview:self.lessonLabel];
    
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.signBtn];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(200));
    }];
    
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(98));
        make.height.mas_equalTo(CGFloatIn750(48));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.signBtn.mas_left).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.mas_centerY);
    }];
}


- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont fontContent]];
    }
    return _lessonLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont fontSmall]];
    }
    return _timeLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        
        _rightLabel.numberOfLines = 1;
        _rightLabel.textAlignment = NSTextAlignmentRight;
        [_rightLabel setFont:[UIFont fontContent]];
    }
    return _rightLabel;
}


- (UIButton *)signBtn {
    if (!_signBtn) {
        _signBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        ViewRadius(_signBtn, CGFloatIn750(24));
        
        
        [_signBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_signBtn.titleLabel setFont:[UIFont fontContent]];
        _signBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        
        __weak typeof(self) weakSelf = self;
        [_signBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                if ([self.model.type intValue] == 6) {
                    weakSelf.handleBlock(self.model,0);
                }else{
                    weakSelf.handleBlock(self.model,1);
                }
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _signBtn;
}

- (void)setModel:(ZSignInfoListModel *)model {
    _model = model;
//    类型 1：签课 2：教师代签 3：补签 4：请假 5：旷课 6:待签课
    _lessonLabel.text = [NSString stringWithFormat:@"第%@节",model.nums];
    _timeLabel.text = [model.sign_time timeStringWithFormatter:@"yyyy-MM-dd HH:mm"];
    
    _signBtn.hidden = YES;
    _timeLabel.hidden = YES;
    if ([[ZUserHelper sharedHelper].user.type intValue] == 1) {
        switch ([model.type intValue]) {
            case 1:
            {
                if (model.isNote) {
                    _rightLabel.text = @"已签课";
                }else{
                    _rightLabel.text = @"已扫码签课";
                }
                
                _timeLabel.hidden = NO;
                
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 2:
            {
                _rightLabel.text = @"教师代签";
                _timeLabel.hidden = NO;
                
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 3:
            {
                _rightLabel.text = @"已补签";
                _timeLabel.hidden = NO;
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 4:
            {
                _rightLabel.text = @"请假";
                _timeLabel.hidden = NO;
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 5:
            {
                _rightLabel.text = @"旷课";
                _timeLabel.hidden = NO;
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 6:
            {
                _rightLabel.text = @"待签课";
                _signBtn.hidden = NO;
                [_signBtn setTitle:@"签课" forState:UIControlStateNormal];
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
                
            default:
            {
                _rightLabel.hidden = YES;
                _signBtn.hidden = YES;
                _timeLabel.hidden = YES;
                
            }
                break;
        }
    }else if([[ZUserHelper sharedHelper].user.type intValue] == 2){
        switch ([model.type intValue]) {
            case 1:
            {
                _rightLabel.text = @"已扫码签课";
                _timeLabel.hidden = NO;
                
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 2:
            {
                _rightLabel.text = @"教师代签";
                _timeLabel.hidden = NO;
                
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 3:
            {
                _rightLabel.text = @"已补签";
                _timeLabel.hidden = NO;
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 4:
            {
                _rightLabel.text = @"请假";
                _signBtn.hidden = NO;
                [_signBtn setTitle:@"补签" forState:UIControlStateNormal];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 5:
            {
                _rightLabel.text = @"旷课";
                _signBtn.hidden = NO;
                [_signBtn setTitle:@"补签" forState:UIControlStateNormal];
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 6:
            {
                _rightLabel.text = @"待签课";
                _signBtn.hidden = NO;
                [_signBtn setTitle:@"签课" forState:UIControlStateNormal];
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
                
            default:
            {
                _rightLabel.hidden = YES;
                _signBtn.hidden = YES;
                _timeLabel.hidden = YES;
                
            }
                break;
        }
    }else{
        _signBtn.hidden = YES;
        switch ([model.type intValue]) {
            case 1:
            {
                _rightLabel.text = @"已扫码签课";
                _timeLabel.hidden = NO;
                
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 2:
            {
                _rightLabel.text = @"教师代签";
                _timeLabel.hidden = NO;
                
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 3:
            {
                _rightLabel.text = @"已补签";
                _timeLabel.hidden = NO;
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 4:
            {
                _rightLabel.text = @"请假";
                _timeLabel.hidden = NO;
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 5:
            {
                _rightLabel.text = @"旷课";
                _timeLabel.hidden = NO;
                [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
                
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
            case 6:
            {
                _rightLabel.text = @"待签课";
                [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(CGFloatIn750(242));
                    make.centerY.equalTo(self.mas_centerY);
                }];
            }
                break;
                
            default:
            {
                _rightLabel.hidden = YES;
                _signBtn.hidden = YES;
                _timeLabel.hidden = YES;
                
            }
                break;
        }
    }

}

- (void)setCan_operation:(NSString *)can_operation {
    _can_operation = can_operation;
    if ([can_operation intValue] != 1) {
        self.signBtn.hidden = YES;
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(80);
}
@end

