//
//  ZStudentMineOrderTopStateCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderTopStateCell.h"

@interface ZStudentMineOrderTopStateCell ()
@property (nonatomic,strong) UILabel *statelabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic, assign) int serviceTime;
@property (nonatomic, strong) NSTimer *timer;
@end


@implementation ZStudentMineOrderTopStateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    [self.contentView addSubview:self.statelabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.detailLabel];
    
    [self.statelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(40));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statelabel.mas_bottom).offset(CGFloatIn750(30));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(20));
        make.centerX.equalTo(self.mas_centerX);
    }];
}


- (UILabel *)statelabel {
    if (!_statelabel) {
        _statelabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statelabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _statelabel.text = @"";
        _statelabel.numberOfLines = 1;
        _statelabel.textAlignment = NSTextAlignmentCenter;
        [_statelabel setFont:[UIFont boldFontSmall]];
    }
    return _statelabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _priceLabel.text = @"";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [_priceLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(52)]];
    }
    return _priceLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _detailLabel.text = @"";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [_detailLabel setFont:[UIFont fontMin]];
    }
    return _detailLabel;
}

- (void)setModel:(ZOrderDetailModel *)model {
    _model = model;
    if (model.order_type == ZStudentOrderTypeForPay) {
        _statelabel.text = @"待付款";
        _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.pay_amount];
        _detailLabel.text = @"请完成支付，超时订单将自动取消";
        if (!_timer && [model.count_down intValue] > 0) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeLeftTime) userInfo:nil repeats:YES];
            NSRunLoop *main=[NSRunLoop currentRunLoop];
            [main addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
    else if (model.order_type == ZStudentOrderTypeOrderForPay){
        _statelabel.text = @"待付款";
        _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.pay_amount];
        _detailLabel.text = @"请完成支付，超时订单将自动取消";
        if (!_timer && [model.count_down intValue] > 0) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeLeftTime) userInfo:nil repeats:YES];
            NSRunLoop *main=[NSRunLoop currentRunLoop];
            [main addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
    else if (model.order_type == ZOrganizationOrderTypeForPay) {
        _statelabel.text = @"待付款";
        _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.pay_amount];
        _detailLabel.text = @"超时订单将自动取消";
    }else if (model.order_type == ZOrganizationOrderTypeOrderForPay){
        _statelabel.text = @"待付款";
        _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.pay_amount];
        _detailLabel.text = @"超时订单将自动取消";
    }
    _serviceTime = [model.count_down intValue];
    
}


- (NSString *)getSurplusTime:(int)endTime {
    _serviceTime --;
    NSString *surplusTime = @"";
    if(_serviceTime == 0) {
        if ([_timer isValid]) {
            [_timer invalidate];
        }
        _timer = nil;
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        int days = (int)(_serviceTime/(3600*24));
        int hours = (int)((_serviceTime - days*24*3600)/3600);
        int minute = (int)(_serviceTime - days*24*3600 - hours*3600)/60;
        int second = _serviceTime - days*24*3600 - hours*3600 - minute*60;
        
        NSString *str_day = [NSString stringWithFormat:@"%ld天",(long)days];
        if (days == 0) {
            str_day = @"";
        }
        NSString *str_hour = [NSString stringWithFormat:@"%ld小时",(long)hours];
        if (hours < 10) {
            str_hour = [NSString stringWithFormat:@"0%ld小时",(long)hours];
        }
        NSString *str_minute = [NSString stringWithFormat:@"%ld分",(long)minute];
        if (minute < 10) {
            str_minute = [NSString stringWithFormat:@"0%ld分",(long)minute];
        }
        NSString *str_second = [NSString stringWithFormat:@"%ld秒",(long)second];
        if (second < 10) {
            str_second = [NSString stringWithFormat:@"0%ld秒",(long)second];
        }
        surplusTime = [NSString stringWithFormat:@" 请于%@%@%@%@完成支付，超时订单将自动取消",str_day,str_hour,str_minute,str_second];
    }
    return surplusTime;
}


- (void)changeLeftTime {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[self getSurplusTime:_serviceTime]];
//    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
////    textAttachment.image = [UIImage imageNamed:@"pay_time"];
//    textAttachment.bounds = CGRectMake(0, -2, 15, 15);
//    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
//    [attStr insertAttributedString:attachmentAttrStr atIndex:0];
    [_detailLabel setAttributedText:attStr];
//    _timeLab.text = [NSString stringWithFormat:@"剩余支付时间：%@",[self getSurplusTime:_serviceTime]];
}



+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(252);
}
@end
