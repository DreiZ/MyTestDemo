//
//  ZStudentMineOrderDetailCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderDetailCell.h"
#import "ZStudentMineOrderDetailSubDesCell.h"

@interface ZStudentMineOrderDetailCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@property (nonatomic,strong) UILabel *clubLabel;
@property (nonatomic,strong) UILabel *orderNameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *statelabel;

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *clubImageView;

@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *midView;
@property (nonatomic,strong) UIView *subView;
@property (nonatomic,strong) UIView *topView;

@property (nonatomic,strong) UIButton *delBtn;

@end

@implementation ZStudentMineOrderDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    _cellConfigArr = @[].mutableCopy;
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(20));
    }];
    
    [self.contView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.contView addSubview:self.bottomView];
    [self.bottomView addSubview:self.delBtn];
    [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(CGFloatIn750(56));
        make.width.mas_equalTo(CGFloatIn750(142));
    }];
    
    self.bottomView.hidden = YES;
    
    [self.contView addSubview:self.subView];
    [self.subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(40));
        make.height.mas_equalTo(50);
    }];
    
    [self.contView addSubview:self.midView];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.subView.mas_top);
    }];
    
    [self.topView addSubview:self.clubLabel];
    [self.clubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    [self.topView addSubview:self.statelabel];
    [self.statelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    _clubImageView = [[UIImageView alloc] init];
    _clubImageView.image = [[UIImage imageNamed:@"rightBlackArrowN"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _clubImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    [self.topView addSubview:_clubImageView];
    [self.clubImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.clubLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *clubBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [clubBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(ZLessonOrderHandleTypeClub, weakSelf.model);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:clubBtn];
    [clubBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.topView);
        make.right.equalTo(self.clubImageView.mas_right).offset(CGFloatIn750(20));
    }];
    
    
    
    [self.midView addSubview:self.leftImageView];
    [self.midView addSubview:self.priceLabel];
    [self.midView addSubview:self.detailLabel];
    [self.midView addSubview:self.orderNameLabel];
    [self.midView addSubview:self.timeLabel];

   [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.midView.mas_left).offset(CGFloatIn750(30));
       make.top.bottom.equalTo(self.midView);
       make.width.mas_equalTo(CGFloatIn750(240));
   }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(80));
        make.centerY.equalTo(self.orderNameLabel.mas_centerY);
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];

    [self.orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.leftImageView.mas_top).offset(CGFloatIn750(2));
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
        make.height.mas_lessThanOrEqualTo(CGFloatIn750(70));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNameLabel.mas_left);
        make.right.equalTo(self.topView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.leftImageView.mas_centerY).offset(CGFloatIn750(0));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).offset(-CGFloatIn750(30));
        make.left.equalTo(self.orderNameLabel.mas_left);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(CGFloatIn750(14));
    }];
 

    UIButton *lessonBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [lessonBtn bk_addEventHandler:^(id sender) {
       if (weakSelf.handleBlock) {
           weakSelf.handleBlock(ZLessonOrderHandleTypeLesson, weakSelf.model);
       }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.midView addSubview:lessonBtn];
    [lessonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(self.midView);
    }];
    
    [self.subView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.subView);
    }];
    
    self.priceLabel.hidden = YES;
}


#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        _contView.clipsToBounds = YES;
//        ViewShadowRadius(_contView, CGFloatIn750(20), CGSizeMake(0, 0), 0.5, isDarkModel() ? [UIColor colorGrayContentBGDark] : [UIColor colorGrayContentBG]);
         _contView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _contView;
}

-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.backgroundColor = [UIColor whiteColor];
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } 
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.layer.masksToBounds = YES;
        _iTableView.scrollEnabled = NO;
    }
    return _iTableView;
}

- (UIView *)subView {
    if (!_subView) {
        _subView = [[UIView alloc] init];
        _subView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBGDark]);
        _subView.clipsToBounds = YES;
    }
    return _subView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _topView.clipsToBounds = YES;
        _topView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _topView;
}


- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _bottomView.clipsToBounds = YES;
        _bottomView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _bottomView;
}

- (UIView *)midView {
    if (!_midView) {
        _midView = [[UIView alloc] init];
        _midView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _midView.clipsToBounds = YES;
    }
    return _midView;
}

- (UILabel *)orderNameLabel {
    if (!_orderNameLabel) {
        _orderNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderNameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _orderNameLabel.text = @"";
        _orderNameLabel.numberOfLines = 0;
        _orderNameLabel.textAlignment = NSTextAlignmentLeft;
        [_orderNameLabel setFont:[UIFont boldFontContent]];
        _orderNameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _orderNameLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _priceLabel.text = @"";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont boldFontContent]];
    }
    return _priceLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_leftImageView, CGFloatIn750(12));
    }
    return _leftImageView;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _detailLabel.text = @"";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [_detailLabel setFont:[UIFont fontSmall]];
    }
    return _detailLabel;
}


- (UILabel *)clubLabel {
    if (!_clubLabel) {
        _clubLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _clubLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _clubLabel.text = @"";
        _clubLabel.numberOfLines = 1;
        _clubLabel.textAlignment = NSTextAlignmentLeft;
        [_clubLabel setFont:[UIFont fontContent]];
    }
    return _clubLabel;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _timeLabel.text = @"";
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont fontSmall]];
    }
    return _timeLabel;
}


- (UILabel *)statelabel {
    if (!_statelabel) {
        _statelabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _statelabel.text = @"";
        _statelabel.numberOfLines = 1;
        _statelabel.textAlignment = NSTextAlignmentRight;
        [_statelabel setFont:[UIFont boldFontSmall]];
    }
    return _statelabel;
}


- (UIButton *)delBtn {
    if (!_delBtn) {
        __weak typeof(self) weakSelf = self;
        _delBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_delBtn setTitle:@"申请退款" forState:UIControlStateNormal];
        [_delBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_delBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_delBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeRefund,self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZRecordWeightMoreCell"]) {
       
    }
}

#pragma mark - set model
- (void)setModel:(ZOrderDetailModel *)model {
    _model = model;
    
    [self.leftImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.course_image_url)] placeholderImage:[UIImage imageNamed:@"default_image32"]];
    self.orderNameLabel.text = model.course_name;
    self.clubLabel.text = model.store_name;
    self.bottomView.hidden = YES;
    self.delBtn.enabled = NO;
 
    switch (self.model.order_type) {
        case ZOrganizationOrderTypeForPay:
            {
                [self setOrderDetailDes];
                self.priceLabel.text = @"";
                CGSize temp = [self.model.experience_price tt_sizeWithFont:[UIFont boldFontContent]];
                [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(temp.width + 2);
                    make.centerY.equalTo(self.orderNameLabel.mas_centerY);
                    make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
                }];
                [self setOrderDetailMidViewBottom];
            }
            break;
        case ZStudentOrderTypeForPay://待付款（去支付，取消）
            {
                [self setDetailDes];
                [self setSubDetail];
                self.priceLabel.text = @"";
                
                [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(1);
                    make.centerY.equalTo(self.orderNameLabel.mas_centerY);
                    make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
                }];
                [self setDetailSubViewBottom];
            }
            break;
        case ZOrganizationOrderTypeHadPay:
            {
                [self setDetailDes];
                [self setSubDetail];
                [self setDetailSubViewBottom];
            }
            break;
        case ZStudentOrderTypeHadPay://已付款（评价，退款，删除）
            {
                [self setDetailDes];
                [self setSubDetail];
                if ([self.model.has_can_refund intValue] == 1 ) {
                    [self setDetailBottomViewBottom];
                }else{
                    [self setDetailSubViewBottom];
                }
            }
            break;
        case ZOrganizationOrderTypeHadEva:
            {
                [self setDetailDes];
                [self setSubDetail];
                [self setDetailSubViewBottom];
            }
            break;
        case ZStudentOrderTypeHadEva://完成已评价(删除)
            {
                [self setDetailDes];
                [self setSubDetail];
                [self setDetailBottomViewBottom];
            }
            break;
        case ZOrganizationOrderTypeOrderOutTime:
        case ZOrganizationOrderTypeOutTime:
            {
                [self setDetailDes];
                [self setSubDetail];
                [self setDetailSubViewBottom];
            }
            break;
        case ZStudentOrderTypeOrderOutTime:
        case ZStudentOrderTypeOutTime://超时(删除)
            {
                [self setDetailDes];
                [self setSubDetail];
                [self setDetailSubViewBottom];
            }
            break;
        case ZOrganizationOrderTypeCancel:
            {
                [self setDetailDes];
                [self setSubDetail];
                [self setDetailSubViewBottom];
            }
            break;
        case ZStudentOrderTypeCancel://已取消(删除)
            {
                [self setDetailDes];
                [self setSubDetail];
                [self setDetailSubViewBottom];
            }
            break;
        case ZOrganizationOrderTypeOrderForPay:
        case ZStudentOrderTypeOrderForPay://待付款（去支付，取消）
            {
                [self setOrderDetailDes];
                self.priceLabel.text = @"";
                
                [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(1);
                    make.centerY.equalTo(self.orderNameLabel.mas_centerY);
                    make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
                }];
                [self setOrderDetailMidViewBottom];
            }
            break;
        case ZOrganizationOrderTypeOrderForReceived:
        case ZStudentOrderTypeOrderForReceived://待接收（预约）
            {
                [self setOrderDetailDes];
                [self setOrderDetailMidViewBottom];
            }
            break;
        case ZOrganizationOrderTypeOrderComplete:
        case ZStudentOrderTypeOrderComplete://已完成（预约，删除）
            {
                [self setOrderDetailDes];
                [self setOrderDetailMidViewBottom];
            }
            break;
        case ZOrganizationOrderTypeOrderRefuse:
        case ZStudentOrderTypeOrderRefuse://已拒绝（预约）
            {
                [self setOrderDetailDes];
                [self setOrderDetailMidViewBottom];
            }
            break;
        default:
            break;
    }
    if ([self.model.has_can_refund intValue] == 1 && !model.isRefund) {
        if (self.model.isStudent) {
            self.delBtn.enabled = YES;
            [_delBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(142));
            }];
        }
    }else{
        [_delBtn setTitle:@"" forState:UIControlStateNormal];
        self.delBtn.hidden = YES;
    }
}

- (void)setDetailDes {
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.model.order_amount];
    self.detailLabel.text = [NSString stringWithFormat:@"教师：%@",self.model.teacher_name];
    self.timeLabel.text = [NSString stringWithFormat:@"课节：%@节",self.model.course_number];
    
    CGSize priceSize = [[NSString stringWithFormat:@"￥%@",self.model.order_amount] tt_sizeWithFont:[UIFont fontContent]];
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(priceSize.width + 3);
        make.centerY.equalTo(self.orderNameLabel.mas_centerY);
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];
}

- (void)setSubDetail {
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(28))];
    
    NSArray *titleArr = @[@[@"单节课时",[NSString stringWithFormat:@"%@分钟",SafeStr(_model.course_min)]],
                          @[@"总时长",[NSString stringWithFormat:@"%@分钟",SafeStr(_model.course_total_min)]],
                          @[@"课程有效期",[NSString stringWithFormat:@"%@月",SafeStr(_model.valid_at)]]];
    
    for (NSArray *tempArr in titleArr) {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontSmall];
        mModel.leftFont = [UIFont fontSmall];
        mModel.rightColor = [UIColor colorTextGray];
        mModel.rightDarkColor = [UIColor colorTextGrayDark];
        mModel.leftColor = [UIColor colorTextBlack];
        mModel.leftDarkColor = [UIColor colorTextBlackDark];
        mModel.singleCellHeight = CGFloatIn750(52);
        mModel.cellHeight = CGFloatIn750(54);
        mModel.titleWidth = CGFloatIn750(250);
        mModel.cellWidth = KScreenWidth - CGFloatIn750(60);
        mModel.rightTitle = [NSString stringWithFormat:@"%@",tempArr[1]];
        mModel.leftTitle = tempArr[0];
        mModel.isHiddenLine = YES;

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderDetailSubDesCell className] title:mModel.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZStudentMineOrderDetailSubDesCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        
        [self.cellConfigArr addObject:menuCellConfig];
        
    }
}

- (void)setDetailSubViewBottom {
    [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.subView.mas_top);
    }];
    [self.subView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
        make.height.mas_equalTo(CGFloatIn750(56*3 + 28));
    }];
}

- (void)setDetailBottomViewBottom {
    [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.subView.mas_top);
    }];
    
    self.bottomView.hidden = NO;
    [self.subView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(0));
        make.height.mas_equalTo(CGFloatIn750(56*3 + 28));
    }];
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
        make.height.mas_equalTo(CGFloatIn750(56));
    }];
}

- (void)setOrderDetailDes {
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",SafeStr(self.model.experience_price)];
    self.detailLabel.text = [NSString stringWithFormat:@"体验时长：%@分钟",SafeStr(self.model.experience_duration)];
    self.timeLabel.text = [NSString stringWithFormat:@"%@(%@) %@",[self.model.schedule_time timeStringWithFormatter:@"MM-dd"],[[[NSDate alloc] initWithTimeIntervalSince1970:[self.model.schedule_time doubleValue] - 24 * 60 * 60] formatWeekday],[self.model.schedule_time timeStringWithFormatter:@"HH:mm"]];
    
    CGSize priceSize = [[NSString stringWithFormat:@"￥%@",self.model.pay_amount] tt_sizeWithFont:[UIFont fontContent]];
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(priceSize.width + 3);
        make.centerY.equalTo(self.orderNameLabel.mas_centerY);
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
    }];
}


- (void)setOrderDetailMidViewBottom {
    [self.midView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
    }];
}


+ (CGFloat)z_getCellHeight:(id)sender {
    if (sender && [sender isKindOfClass:[ZOrderDetailModel class]]) {
        ZOrderDetailModel *listModel = (ZOrderDetailModel *)sender;
        if (!listModel.isRefund && [listModel.has_can_refund intValue] == 1) {
            return CGFloatIn750(328 + 56 * 3 + 28 + 56);
        }
        switch (listModel.order_type) {
            case ZOrganizationOrderTypeForPay:
            case ZStudentOrderTypeForPay://待付款（去支付，取消）
                return CGFloatIn750(328 + 56 * 3 + 28);
                break;
            case ZOrganizationOrderTypeHadPay:
                return CGFloatIn750(328 + 56 * 3 + 28);
                break;
            case ZStudentOrderTypeHadPay://已付款（评价，退款，删除）
                if ([listModel.has_can_refund intValue] == 1) {
                    return CGFloatIn750(328 + 56 * 3 + 28 + 56);
                }else{
                    return CGFloatIn750(328 + 56 * 3 + 28 );
                }
                
                break;
            case ZOrganizationOrderTypeHadEva:
                return CGFloatIn750(328 + 56 * 3 + 28);
                break;
            case ZStudentOrderTypeHadEva://完成已评价(删除)
                return CGFloatIn750(328 + 56 * 3 + 28 + 56);
                break;
            case ZOrganizationOrderTypeOrderOutTime:
            case ZOrganizationOrderTypeOutTime:
                return CGFloatIn750(328 + 56 * 3 + 28);
                break;
            case ZStudentOrderTypeOrderOutTime:
            case ZStudentOrderTypeOutTime://超时(删除)
                return CGFloatIn750(328 + 56 * 3 + 28);
                break;
            case ZOrganizationOrderTypeCancel:
                return CGFloatIn750(328 + 56 * 3 + 28);
                break;
            case ZStudentOrderTypeCancel://已取消(删除)
                    return CGFloatIn750(328 + 56 * 3 + 28);
                break;
            case ZOrganizationOrderTypeOrderForPay:
            case ZStudentOrderTypeOrderForPay://待付款（去支付，取消）
                  
            case ZOrganizationOrderTypeOrderForReceived:
            case ZStudentOrderTypeOrderForReceived://待接收（预约）
                    
            case ZOrganizationOrderTypeOrderComplete:
            case ZStudentOrderTypeOrderComplete://已完成（预约，删除）
                    
            case ZOrganizationOrderTypeOrderRefuse:
            case ZStudentOrderTypeOrderRefuse://已拒绝（预约）
                    return CGFloatIn750(328);
                break;
            default:
                break;
        }
    }
    
    return CGFloatIn750(0);
}
@end
