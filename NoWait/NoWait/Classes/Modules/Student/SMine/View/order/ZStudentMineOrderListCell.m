//
//  ZStudentMineOrderListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderListCell.h"
#import "ZStudentLessonDetailLessonListCell.h"
#import "ZSpaceEmptyCell.h"

#import "ZStudentDetailModel.h"


@interface ZStudentMineOrderListCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) UILabel *orderSNLabel;
@property (nonatomic,strong) UILabel *orderStateLabel;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *payBtn;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZStudentMineOrderListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    _cellConfigArr = @[].mutableCopy;
    
    UIView *contView = [[UIView alloc] init];
//    contView.layer.masksToBounds = YES;
//    contView.layer.cornerRadius = CGFloatIn750(12);
    [self.contentView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.right.top.equalTo(contView);
    }];

    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [contView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(88));
        make.left.right.bottom.equalTo(contView);
    }];
    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectZero];
    middleView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [contView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(bottomView.mas_top);
        make.left.right.equalTo(contView);
    }];


    [topView addSubview:self.orderSNLabel];
    [bottomView addSubview:self.cancelBtn];
    [bottomView addSubview:self.payBtn];
    [bottomView addSubview:self.orderStateLabel];
    
    [self.orderSNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(topView.mas_centerY);
    }];

    [middleView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(middleView);
    }];
    
    UIView *topBottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    topBottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayBGDark]);
    [topView addSubview:topBottomLineView];
    [topBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(topView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayBGDark]);
    [bottomView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bottomView);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(20));
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(bottomView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(46));
        make.width.mas_equalTo(CGFloatIn750(130));
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.payBtn.mas_left).offset(-CGFloatIn750(20));
        make.centerY.equalTo(bottomView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(46));
        make.width.mas_equalTo(CGFloatIn750(130));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [detailBtn bk_whenTapped:^{
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(ZLessonOrderHandleTypeDetail);
        }
    }];
    [self.contentView addSubview:detailBtn];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(middleView);
    }];
    
    [self setData];
}


#pragma mark lazy loading...
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
        } else {
            
        }
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.layer.masksToBounds = YES;
        _iTableView.scrollEnabled = NO;
    }
    return _iTableView;
}

- (UILabel *)orderSNLabel {
    if (!_orderSNLabel) {
        _orderSNLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderSNLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _orderSNLabel.text = @"订单号：NS239854385892";
        _orderSNLabel.numberOfLines = 1;
        _orderSNLabel.textAlignment = NSTextAlignmentLeft;
        [_orderSNLabel setFont:[UIFont fontContent]];
    }
    return _orderSNLabel;
}


- (UILabel *)orderStateLabel {
    if (!_orderStateLabel) {
        _orderStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderStateLabel.textColor = [UIColor colorRedDefault];
        _orderStateLabel.text = @"待支付";
        _orderStateLabel.numberOfLines = 1;
        _orderStateLabel.textAlignment = NSTextAlignmentLeft;
        [_orderStateLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
    }
    return _orderStateLabel;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.cornerRadius = 3;
        _cancelBtn.layer.borderColor = [UIColor colorRedDefault].CGColor;
        _cancelBtn.layer.borderWidth = 1;
        [_cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorRedDefault] forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
        
        __weak typeof(self) weakSelf = self;
        [_cancelBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeCancel);
            }
        }];
    }
    return _cancelBtn;
}


- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _payBtn.layer.masksToBounds = YES;
        _payBtn.layer.cornerRadius = 3;
        _payBtn.layer.borderColor = [UIColor colorRedDefault].CGColor;
        _payBtn.layer.borderWidth = 1;
        [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor colorRedDefault] forState:UIControlStateNormal];
        [_payBtn.titleLabel setFont:[UIFont fontSmall]];
        
        __weak typeof(self) weakSelf = self;
        [_payBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeCancel);
            }
        }];
    }
    return _payBtn;
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
    if ([cellConfig.title isEqualToString:@"ZStudentLessonDetailLessonListCell"]) {
        ZStudentLessonDetailLessonListCell *listCell = (ZStudentLessonDetailLessonListCell *)cell;
        listCell.isHiddenBottomLine = YES;
    }
   
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


+ (CGFloat)z_getCellHeight:(id)sender {
    NSMutableArray *list = @[].mutableCopy;
    
    NSArray *des = @[@"课程：少儿英语", @"教练：伊可新", @"购买课时：20节课", @"有效时间：2019年12日31日"];
    for (int i = 0; i < des.count; i++) {
        ZStudentDetailDesListModel *model = [[ZStudentDetailDesListModel alloc] init];
        model.desTitle = des[i];
        [list addObject:model];
    }
    return CGFloatIn750(168) + CGFloatIn750(40) + [ZStudentLessonDetailLessonListCell z_getCellHeight:list];
}


- (void)setData {
    NSMutableArray *list = @[].mutableCopy;
    NSArray *des = @[@"课程：少儿英语", @"教练：伊可新", @"购买课时：20节课", @"有效时间：2019年12日31日"];
    for (int i = 0; i < des.count; i++) {
        ZStudentDetailDesListModel *model = [[ZStudentDetailDesListModel alloc] init];
        model.desTitle = des[i];
        [list addObject:model];
    }

    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
    [_cellConfigArr addObject:topCellConfig];
    
    ZCellConfig *lessonDesCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailLessonListCell className] title:[ZStudentLessonDetailLessonListCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentLessonDetailLessonListCell z_getCellHeight:list] cellType:ZCellTypeClass dataModel:list];
    [_cellConfigArr addObject:lessonDesCellConfig];
//

    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
    [_cellConfigArr addObject:bottomCellConfig];
    
    [self.iTableView reloadData];
}
@end

