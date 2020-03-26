//
//  ZOrganizationEvaListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationEvaListCell.h"
#import "ZOrganizationEvaListUserInfoCell.h"
#import "ZOrganizationEvaListLessonCell.h"
#import "ZOrganizationEvaListEvaBtnCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZOrganizationEvaListEvaTextViewCell.h"
#import "ZOrganizationEvaListReEvaCell.h"
#import "ZSpaceEmptyCell.h"

@interface ZOrganizationEvaListCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZOrganizationEvaListCell

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
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    self.cellConfigArr = @[].mutableCopy;
    [self.contentView addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(10));
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
        ViewRadius(_iTableView, CGFloatIn750(20));
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
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListEvaTextViewCell"]){
        ZOrganizationEvaListEvaTextViewCell *enteryCell = (ZOrganizationEvaListEvaTextViewCell *)cell;
        enteryCell.textChangeBlock = ^(NSString *text) {
            
        };
    }else if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListEvaBtnCell"]){
        ZOrganizationEvaListEvaBtnCell *lcell = (ZOrganizationEvaListEvaBtnCell *)cell;
        lcell.evaBlock = ^(NSInteger index) {
            if (weakSelf.evaBlock) {
                weakSelf.evaBlock(0);
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
    ZOrderEvaListModel *evaModel = sender;
    
    CGFloat cellHeight = 0;
    cellHeight += [ZOrganizationEvaListUserInfoCell z_getCellHeight:nil];
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = evaModel.des;
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth - CGFloatIn750(120);
        model.singleCellHeight = CGFloatIn750(60);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(62);
        model.rightFont = [UIFont fontSmall];
        cellHeight += [ZMultiseriateContentLeftLineCell z_getCellHeight:nil];
    }
    
    cellHeight += [ZOrganizationEvaListLessonCell z_getCellHeight:nil];
//    cellHeight += [ZOrganizationEvaListEvaBtnCell z_getCellHeight:nil];
//    cellHeight += [ZOrganizationEvaListEvaTextViewCell z_getCellHeight:nil];
    cellHeight += [ZOrganizationEvaListReEvaCell z_getCellHeight:evaModel.des] + CGFloatIn750(40);

    
    return  cellHeight+= CGFloatIn750(80 + 30);
}

- (void)setModel:(ZOrderEvaListModel *)model {
    _model = model;
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        
        ZCellConfig *top1CellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListUserInfoCell className] title:[ZOrganizationEvaListUserInfoCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationEvaListUserInfoCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.model];
        [self.cellConfigArr addObject:top1CellConfig];
        
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    }
    
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightTitle = self.model.des;
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth - CGFloatIn750(60);
        model.singleCellHeight = CGFloatIn750(60);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(62);
        model.rightFont = [UIFont fontSmall];
        model.rightColor = [UIColor colorTextBlack];
        model.rightDarkColor =  [UIColor colorTextBlackDark];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr  addObject:menuCellConfig];
        
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    }
    {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListLessonCell className] title:[ZOrganizationEvaListLessonCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationEvaListLessonCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.model];
        [self.cellConfigArr addObject:orderCellConfig];
    }
//    {
//        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaTextViewCell className] title:[ZOrganizationEvaListEvaTextViewCell className] showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaTextViewCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
//        [self.cellConfigArr addObject:orderCellConfig];
//    }
    if ([self.model.is_reply intValue] == 1) {
        
    }else{
        
    }
    {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListReEvaCell className] title:[ZOrganizationEvaListReEvaCell className] showInfoMethod:@selector(setEvaDes:) heightOfCell:[ZOrganizationEvaListReEvaCell z_getCellHeight:_model.des] cellType:ZCellTypeClass dataModel:_model.des];
        [self.cellConfigArr addObject:orderCellConfig];
        
    }
//    {
//        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListEvaBtnCell className] title:[ZOrganizationEvaListEvaBtnCell className] showInfoMethod:nil heightOfCell:[ZOrganizationEvaListEvaBtnCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
//        [self.cellConfigArr addObject:orderCellConfig];
//    }
}

@end

