//
//  ZStudentMineOrderDetailInfoCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderDetailInfoCell.h"
#import "ZStudentLessonDetailLessonListCell.h"
#import "ZSpaceEmptyCell.h"

#import "ZStudentDetailModel.h"


@interface ZStudentMineOrderDetailInfoCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) UILabel *orderSNLabel;
@property (nonatomic,strong) UILabel *orderStateLabel;
@property (nonatomic,strong) UILabel *priceLabel;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZStudentMineOrderDetailInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    
    _cellConfigArr = @[].mutableCopy;
    
    UIView *contView = [[UIView alloc] init];
//    contView.layer.masksToBounds = YES;
//    contView.layer.cornerRadius = CGFloatIn750(12);
    [self.contentView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    [contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.right.top.equalTo(contView);
    }];

    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    [contView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(88));
        make.left.right.bottom.equalTo(contView);
    }];
    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectZero];
    middleView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    [contView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(bottomView.mas_top);
        make.left.right.equalTo(contView);
    }];


    [topView addSubview:self.orderSNLabel];
    [bottomView addSubview:self.orderStateLabel];
    [bottomView addSubview:self.priceLabel];
    
    [self.orderSNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(topView.mas_centerY);
    }];

    [middleView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(middleView);
    }];
    
    UIView *topBottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    topBottomLineView.backgroundColor = KLineColor;
    [topView addSubview:topBottomLineView];
    [topBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(topView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KLineColor;
    [bottomView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bottomView);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(20));
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(bottomView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(46));
//        make.width.mas_equalTo(CGFloatIn750(130));
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
        _iTableView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
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
        _orderSNLabel.textColor = KAdaptAndDarkColor(KFont3Color, KFont9Color);
        _orderSNLabel.text = @"订单号：NS239854385892";
        _orderSNLabel.numberOfLines = 1;
        _orderSNLabel.textAlignment = NSTextAlignmentLeft;
        [_orderSNLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(28)]];
    }
    return _orderSNLabel;
}


- (UILabel *)orderStateLabel {
    if (!_orderStateLabel) {
        _orderStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderStateLabel.textColor = KRedColor;
        _orderStateLabel.text = @"待支付";
        _orderStateLabel.numberOfLines = 1;
        _orderStateLabel.textAlignment = NSTextAlignmentLeft;
        [_orderStateLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _orderStateLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = KRedColor;
        _priceLabel.text = @"￥4534";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [_priceLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _priceLabel;
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

    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor(KWhiteColor, K1aBackColor)];
    [_cellConfigArr addObject:topCellConfig];
    
    ZCellConfig *lessonDesCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentLessonDetailLessonListCell className] title:[ZStudentLessonDetailLessonListCell className] showInfoMethod:@selector(setList:) heightOfCell:[ZStudentLessonDetailLessonListCell z_getCellHeight:list] cellType:ZCellTypeClass dataModel:list];
    [_cellConfigArr addObject:lessonDesCellConfig];
//

    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor(KWhiteColor, K1aBackColor)];
    [_cellConfigArr addObject:bottomCellConfig];
    
    [self.iTableView reloadData];
}
@end


