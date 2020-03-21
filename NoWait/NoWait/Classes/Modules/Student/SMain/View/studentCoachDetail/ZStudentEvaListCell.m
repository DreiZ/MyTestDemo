//
//  ZStudentEvaListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentEvaListCell.h"
#import "ZOrganizationEvaListUserInfoCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZSpaceEmptyCell.h"

@interface ZStudentEvaListCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZStudentEvaListCell

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
//    __weak typeof(self) weakSelf = self;
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
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListEvaBtnCell"]) {
        
    }
    if (self.evaBlock) {
        self.evaBlock(1);
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    ZStudentOrderEvaModel *evaModel = sender;
    
    CGFloat cellHeight = 0;
    cellHeight += [ZOrganizationEvaListUserInfoCell z_getCellHeight:nil];
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = evaModel.coachEva;
        model.cellWidth = KScreenWidth;
        model.singleCellHeight = CGFloatIn750(60);
        model.cellHeight = CGFloatIn750(62);
        model.rightFont = [UIFont fontSmall];
        cellHeight += [ZMultiseriateContentLeftLineCell z_getCellHeight:nil];
    }
 
    
    return  cellHeight+= CGFloatIn750(124);
}

- (void)setModel:(ZStudentOrderEvaModel *)model {
    _model = model;
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    {
        ZCellConfig *topSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(24) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:topSpaceCellConfig];
        
        ZCellConfig *top1CellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListUserInfoCell className] title:[ZOrganizationEvaListUserInfoCell className] showInfoMethod:nil heightOfCell:[ZOrganizationEvaListUserInfoCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:top1CellConfig];
        
        ZCellConfig *bottomSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(10) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:bottomSpaceCellConfig];
    }
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = self.model.coachEva;
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth;
        model.singleCellHeight = CGFloatIn750(60);
        model.leftMargin = CGFloatIn750(86);
        model.rightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(62);
        model.rightFont = [UIFont fontContent];
        model.rightColor = [UIColor colorTextBlack];
        model.rightDarkColor =  [UIColor colorTextBlackDark];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.leftTitle = @"游泳 初级";
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth;
        model.singleCellHeight = CGFloatIn750(42);
        model.leftMargin = CGFloatIn750(86);
        model.rightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(46);
        model.leftFont = [UIFont fontMin];
        model.leftColor = [UIColor colorTextGray1];
        model.leftDarkColor = [UIColor colorTextGray1Dark];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.leftTitle = @"2019-12-31 15:20";
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth;
        model.singleCellHeight = CGFloatIn750(42);
        model.leftMargin = CGFloatIn750(86);
        model.rightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(46);
        model.leftFont = [UIFont fontMin];
        model.leftColor = [UIColor colorTextGray1];
        model.leftDarkColor = [UIColor colorTextGray1Dark];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
    }
    
}

@end


