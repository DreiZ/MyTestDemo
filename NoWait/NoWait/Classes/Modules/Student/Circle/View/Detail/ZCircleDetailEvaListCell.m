//
//  ZCircleDetailEvaListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailEvaListCell.h"

#import "ZOrganizationEvaListUserInfoCell.h"

@interface ZCircleDetailEvaListCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZCircleDetailEvaListCell

-(void)setupView
{
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.cellConfigArr = @[].mutableCopy;
    [self.contentView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-4));
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
        _iTableView.clipsToBounds = YES;
    }
    return _iTableView;
}

#pragma mark - tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    __weak typeof(self) weakSelf = self;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
   
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListUserInfoCell"]) {
        ZOrganizationEvaListUserInfoCell *lcell = (ZOrganizationEvaListUserInfoCell *)cell;
        lcell.crView.hidden = YES;
        lcell.userBlock = ^{
            if (weakSelf.userBlock) {
                weakSelf.userBlock(self.model);
            }
        };
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

+ (CGFloat)z_getCellHeight:(id)sender {
    
    
    
    CGFloat cellHeight = 0;
    {
        cellHeight += CGFloatIn750(14);
        cellHeight += [ZOrganizationEvaListUserInfoCell z_getCellHeight:nil];
        cellHeight += CGFloatIn750(10);
    }
    if ([sender isKindOfClass:[ZCircleDynamicEvaModel class]]) {
        ZCircleDynamicEvaModel *evaModel = sender;
        if (ValidStr(evaModel.content)) {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"des");
            model.zz_titleLeft(evaModel.content);
            model.zz_lineHidden(YES);
            model.zz_leftMultiLine(YES);
            model.zz_marginLeft(CGFloatIn750(86));
            model.zz_marginRight(CGFloatIn750(20));
            model.zz_cellHeight(CGFloatIn750(52));
            model.zz_fontLeft([UIFont fontContent]);
            model.zz_cellWidth(KScreenWidth - CGFloatIn750(60));
            cellHeight += [ZBaseLineCell z_getCellHeight:model];
        }
        cellHeight += CGFloatIn750(10);
    }
    
    
    return  cellHeight;
}

- (void)setModel:(ZCircleDynamicEvaModel *)model {
    _model = model;
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(14))];
        ZCellConfig *top1CellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListUserInfoCell className] title:[ZOrganizationEvaListUserInfoCell className] showInfoMethod:@selector(setCrModel:) heightOfCell:[ZOrganizationEvaListUserInfoCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.model];
        [self.cellConfigArr addObject:top1CellConfig];
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(10))];
    }
    
    if (ValidStr(self.model.content)) {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"des");
        model.zz_titleLeft(self.model.content);
        model.zz_lineHidden(YES);
        model.zz_leftMultiLine(YES);
        model.zz_marginLeft(CGFloatIn750(86));
        model.zz_marginRight(CGFloatIn750(20));
        model.zz_cellHeight(CGFloatIn750(52));
        model.zz_fontLeft([UIFont fontContent]);
        model.zz_cellWidth(KScreenWidth - CGFloatIn750(60));
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(10))];
}

@end

