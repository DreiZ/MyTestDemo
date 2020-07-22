//
//  ZStudentDetailEvaAboutCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentDetailEvaAboutCell.h"
@interface ZStudentDetailEvaAboutCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *titelBack;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *upBlackArrow;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZStudentDetailEvaAboutCell

-(void)setupView {
    [super setupView];
    
    _cellConfigArr = @[].mutableCopy;
    
    [self.contentView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.contentView.backgroundColor = isDarkModel() ? [UIColor colorWithRGB:0x000000 alpha:0.01] : [UIColor colorWithRGB:0xffffff alpha:0.01];
    

    _titelBack = [[UIView alloc] initWithFrame:CGRectZero];
    _titelBack.backgroundColor = isDarkModel() ? [UIColor colorWithRGB:0x000000 alpha:0.3]: [UIColor colorWithRGB:0xffffff alpha:0.7];
    [self.contentView addSubview:_titelBack];
    [_titelBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(106));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(16));
    }];
    [self.contentView addSubview:self.upBlackArrow];
    [self.upBlackArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(CGFloatIn750(10));
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(14));
        make.height.mas_equalTo(CGFloatIn750(8));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [moreBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock ) {
            weakSelf.handleBlock(nil);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.titelBack addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.titelBack);
    }];
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


- (UIImageView *)upBlackArrow {
    if (!_upBlackArrow) {
        _upBlackArrow = [[UIImageView alloc] init];
        _upBlackArrow.image = [[UIImage imageNamed:@"upBlackArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
           _upBlackArrow.tintColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _upBlackArrow.transform = CGAffineTransformRotate(_upBlackArrow.transform, M_PI);
    }
    return _upBlackArrow;
}

- (UIView *)titelBack {
    if (!_titelBack) {
        _titelBack = [[UIView alloc] init];
    }
    
    return _titelBack;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.text = @"查看更多";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont boldFontSmall]];
    }
    return _titleLabel;
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
    if (self.cellSetBlock) {
        self.cellSetBlock(cell, indexPath, cellConfig);
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
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
//    if (self.handleBlock) {
//        self.handleBlock(cellConfig);
//    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    NSMutableArray *list = sender;
    if (list) {
        CGFloat height = CGFloatIn750(80);
        for (id smodel in list) {
            if ([smodel isKindOfClass:[ZCellConfig class]]) {
                ZCellConfig *config = smodel;
                height += [NSClassFromString(config.className) z_getCellHeight:config.dataModel];
            }
        }
        return height;
    }
    return 0;
}

- (void)setConfigList:(NSArray<ZCellConfig *> *)configList {
    _configList = configList;
    [self.cellConfigArr addObjectsFromArray:configList];
    [self.iTableView reloadData];
}
@end


