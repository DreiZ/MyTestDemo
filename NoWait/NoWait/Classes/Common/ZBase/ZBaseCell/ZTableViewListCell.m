//
//  ZTableViewListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewListCell.h"

@interface ZTableViewListCell ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZTableViewListCell

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
        make.left.equalTo(self.contentView).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contentView).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contentView).offset(-CGFloatIn750(20));
    }];
    
    [self.contView addSubview:self.contTopView];
    [self.contView addSubview:self.contBottomView];
    [self.contTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(CGFloatIn750(20));
    }];
    [self.contBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(CGFloatIn750(20));
    }];
    
    [self.contView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.contView).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contView).offset(-CGFloatIn750(20));
    }];
    
    self.contTopView.hidden = YES;
    self.contBottomView.hidden = YES;
}


#pragma mark lazy loading...
-(UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
//        ViewShadowRadius(_contView, CGFloatIn750(20), CGSizeMake(20, 20), 0.5, isDarkModel() ? [UIColor colorGrayContentBG] : [UIColor colorGrayContentBG]);
        _contView.layer.cornerRadius = CGFloatIn750(12);
        _contView.clipsToBounds = YES;
    }
    return _contView;
}

-(UIView *)contTopView {
    if (!_contTopView) {
        _contTopView = [[UIView alloc] init];
        _contTopView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
//        ViewShadowRadius(_contView, CGFloatIn750(20), CGSizeMake(0, 0), 0.5, isDarkModel() ? [UIColor colorGrayContentBG] : [UIColor colorGrayContentBG]);
        _contTopView.layer.cornerRadius = CGFloatIn750(12);
        _contTopView.clipsToBounds = YES;
    }
    return _contTopView;
}

-(UIView *)contBottomView {
    if (!_contBottomView) {
        _contBottomView = [[UIView alloc] init];
        _contBottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
//        ViewShadowRadius(_contView, CGFloatIn750(20), CGSizeMake(0, 0), 0.5, isDarkModel() ? [UIColor colorGrayContentBG] : [UIColor colorGrayContentBG]);
        _contBottomView.layer.cornerRadius = CGFloatIn750(12);
        _contBottomView.clipsToBounds = YES;
    }
    return _contBottomView;
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
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    if (self.handleBlock) {
        self.handleBlock(cellConfig);
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    NSMutableArray *list = sender;
    if (list) {
        CGFloat height = CGFloatIn750(80);
        for (id smodel in list) {
            if ([smodel isKindOfClass:[ZCellConfig class]]) {
                ZCellConfig *config = smodel;
                height += config.heightOfCell;
//                height += [NSClassFromString(config.className) z_getCellHeight:config.dataModel];
            }
        }
        return height;
    }
    return 0;
}

- (void)setConfigList:(NSArray<ZCellConfig *> *)configList {
    _configList = configList;
    [self.cellConfigArr removeAllObjects];
    [self.cellConfigArr addObjectsFromArray:configList];
    [self.iTableView reloadData];
}
@end


