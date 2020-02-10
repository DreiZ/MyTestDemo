//
//  ZMineStudentEvaListHadEvaCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineStudentEvaListHadEvaCell.h"
#import "ZMineStudentEvaListEvaOrderCell.h"
#import "ZMineStudentEvaListEvaCoachCell.h"
#import "ZMineStudentEvaListEvaOrderDesCell.h"
#import "ZMineStudentEvaListEvaImageCell.h"
#import "ZMineStudentEvaListEvaImageCollectionCell.h"

#import "ZSpaceEmptyCell.h"

@interface ZMineStudentEvaListHadEvaCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZMineStudentEvaListHadEvaCell

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
    self.contentView.backgroundColor = KAdaptAndDarkColor(KBackColor, K2eBackColor);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cellConfigArr = @[].mutableCopy;
    [self.contentView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
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
    if ([cellConfig.title isEqualToString:@"ZSpaceEmptyCell"]){
//        ZSpaceEmptyCell *enteryCell = (ZSpaceEmptyCell *)cell;
        
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
    if ([cellConfig.title isEqualToString:@"ZSpaceCell"]) {
        
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    ZStudentOrderEvaModel *model = sender;
    
    CGFloat cellHeight = 0;
    cellHeight += [ZMineStudentEvaListEvaOrderCell z_getCellHeight:nil];
    cellHeight += CGFloatIn750(14);
    cellHeight += [ZMineStudentEvaListEvaCoachCell z_getCellHeight:nil];
    cellHeight += CGFloatIn750(14);
    cellHeight += [ZMineStudentEvaListEvaImageCollectionCell z_getCellHeight:model.coachEvaImages];
    cellHeight += [ZMineStudentEvaListEvaOrderDesCell z_getCellHeight:model.coachEva];

    
    return  cellHeight;
}

- (void)setModel:(ZStudentOrderEvaModel *)model {
    _model = model;
    
    [self initCellConfigArr];
    [self.iTableView reloadData];	
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaListEvaOrderCell className] title:[ZMineStudentEvaListEvaOrderCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaListEvaOrderCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:orderCellConfig];
    
    ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(14) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor(KWhiteColor, K1aBackColor)];
    [self.cellConfigArr addObject:coachSpaceCellConfig];
    
    ZCellConfig *coachCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaListEvaCoachCell className] title:[ZMineStudentEvaListEvaCoachCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaListEvaCoachCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:coachCellConfig];
    
    ZCellConfig *coachBottomSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(14) cellType:ZCellTypeClass dataModel:KAdaptAndDarkColor(KWhiteColor, K1aBackColor)];
    [self.cellConfigArr addObject:coachBottomSpaceCellConfig];
    
    ZCellConfig *desCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaListEvaOrderDesCell className] title:[ZMineStudentEvaListEvaOrderDesCell className] showInfoMethod:@selector(setEvaDes:) heightOfCell:[ZMineStudentEvaListEvaOrderDesCell z_getCellHeight:self.model.coachEva] cellType:ZCellTypeClass dataModel:self.model.coachEva];
    [self.cellConfigArr addObject:desCellConfig];
    
    ZCellConfig *imageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaListEvaImageCollectionCell className] title:[ZMineStudentEvaListEvaImageCollectionCell className] showInfoMethod:@selector(setImages:) heightOfCell:[ZMineStudentEvaListEvaImageCollectionCell z_getCellHeight:self.model.coachEvaImages] cellType:ZCellTypeClass dataModel:self.model.coachEvaImages];
    [self.cellConfigArr addObject:imageCellConfig];
}

@end

