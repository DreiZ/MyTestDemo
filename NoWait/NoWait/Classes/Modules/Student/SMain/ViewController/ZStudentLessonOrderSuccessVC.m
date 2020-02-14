//
//  ZStudentLessonOrderSuccessVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonOrderSuccessVC.h"
#import "ZStudentLessonOrderLessonVC.h"

@interface ZStudentLessonOrderSuccessVC ()
@property (nonatomic,strong) UIImageView *hintImageView;
@property (nonatomic,strong) UILabel *successLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UIButton *mainBtn;
@property (nonatomic,strong) UIButton *detailBtn;

@end

@implementation ZStudentLessonOrderSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavigation];
    [self setupMainView];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"提交成功"];
}

- (void)setupMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);

    [self.view addSubview:self.hintImageView];
    [self.view addSubview:self.successLabel];
    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.mainBtn];
    [self.view addSubview:self.detailBtn];
    
    [self.hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(40));
    }];
    
    [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hintImageView.mas_bottom).offset(CGFloatIn750(50));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.successLabel.mas_bottom).offset(CGFloatIn750(20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.statusLabel.mas_bottom).offset(CGFloatIn750(90));
        make.height.mas_equalTo(CGFloatIn750(94));
        make.width.mas_equalTo(CGFloatIn750(468));
    }];
    
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.mainBtn.mas_bottom).offset(CGFloatIn750(40));
        make.height.mas_equalTo(CGFloatIn750(94));
        make.width.mas_equalTo(CGFloatIn750(468));
    }];
    
}

#pragma mark -懒加载
- (UIImageView *)hintImageView {
    if (!_hintImageView) {
        _hintImageView = [[UIImageView alloc] init];
        _hintImageView.image = [UIImage imageNamed:@"orderSuccess"];
        _hintImageView.layer.masksToBounds = YES;
        _hintImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _hintImageView;
}

- (UILabel *)successLabel {
    if (!_successLabel) {
        _successLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _successLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _successLabel.text = @"恭喜您已经成功预约";
        _successLabel.numberOfLines = 1;
        _successLabel.textAlignment = NSTextAlignmentCenter;
        [_successLabel setFont:[UIFont fontMax1Title]];
    }
    return _successLabel;
}



- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.textColor = [UIColor colorTextGray];
        _statusLabel.text = @"等待商家确认";
        _statusLabel.numberOfLines = 1;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [_statusLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _statusLabel;
}

- (UIButton *)mainBtn {
    if (!_mainBtn) {
        _mainBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _mainBtn.layer.masksToBounds = YES;
        _mainBtn.layer.cornerRadius = CGFloatIn750(47);
        [_mainBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_mainBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_mainBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_mainBtn.titleLabel setFont:[UIFont fontMax1Title]];
        [_mainBtn bk_whenTapped:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
    return _mainBtn;
}


- (UIButton *)detailBtn {
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _detailBtn.layer.masksToBounds = YES;
        _detailBtn.layer.cornerRadius = CGFloatIn750(47);
        _detailBtn.layer.borderColor = [UIColor  colorMain].CGColor;
        _detailBtn.layer.borderWidth = 1;
        [_detailBtn setTitle:@"查看预约详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_detailBtn.titleLabel setFont:[UIFont fontMax1Title]];
        [_detailBtn bk_whenTapped:^{
            ZStudentLessonOrderLessonVC *orderLessonVC = [[ZStudentLessonOrderLessonVC alloc] init];
            [self.navigationController pushViewController:orderLessonVC animated:YES];
        }];
    }
    return _detailBtn;
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 0) {
        _hintImageView.image = [UIImage imageNamed:@"orderSuccess"];
        _successLabel.text = @"恭喜您已经成功预约";
        _statusLabel.text = @"等待商家确认";
        [_detailBtn setTitle:@"查看预约详情" forState:UIControlStateNormal];
    }else{
        _hintImageView.image = [UIImage imageNamed:@"paySuccess"];
        _successLabel.text = @"订单支付成功";
        _statusLabel.text = @"订单号SN23958353";
        [_detailBtn setTitle:@"查看订单详情" forState:UIControlStateNormal];
    }
}
@end
