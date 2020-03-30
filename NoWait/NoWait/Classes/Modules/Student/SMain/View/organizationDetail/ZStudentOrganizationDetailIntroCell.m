//
//  ZStudentOrganizationDetailIntroCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailIntroCell.h"
#import "ZStudentOrganizationDetailIntroLabelCell.h"
#import "ZMultiseriateContentLeftLineCell.h"

@interface ZStudentOrganizationDetailIntroCell ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@property (nonatomic,strong) UITableView *iTableView;

@end

@implementation ZStudentOrganizationDetailIntroCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark 初始化view
- (void)setupView {
    [super setupView];
    
    [self addSubview:self.iTableView];
      [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.bottom.right.equalTo(self);
          make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
      }];
    
    [self setData];
}

- (void)setData {
    _cellConfigArr = @[].mutableCopy;
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.estimatedRowHeight = 0;
        _iTableView.estimatedSectionHeaderHeight = 0;
        _iTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
        _iTableView.scrollEnabled = NO;
        _iTableView.alwaysBounceVertical = YES;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
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
    if ([cellConfig.title isEqualToString:@"address"]) {
        if (_handleBlock) {
            _handleBlock(1);
        }
    }else if ([cellConfig.title isEqualToString:@"label"]) {
       if (_handleBlock) {
           _handleBlock(2);
       }
    }
}


#pragma mark -- setdata--
- (void)setModel:(ZStoresDetailModel *)model {
    _model = model;
    [self resetData];
}
- (void)resetData {
    [_cellConfigArr removeAllObjects];
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(80);
        mModel.isHiddenLine = YES;
        mModel.rightTitle = self.model.name;
        mModel.rightFont = [UIFont boldFontMax1Title];
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
    }

    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.rightImage = @"rightBlackArrowN";
        mModel.isHiddenLine = YES;
        mModel.rightTitle = [NSString stringWithFormat:@"%@%@%@%@",self.model.province,self.model.city,self.model.county,self.model.address];
        mModel.cellTitle = @"address";
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.isHiddenLine = YES;
        mModel.leftTitle = [NSString stringWithFormat:@"营业时间：%@~%@",self.model.opend_start,self.model.opend_end];
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateLineCell className] title:mModel.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateLineCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
    if (ValidArray(self.model.coupons_list)){
        NSMutableArray *coupons = @[].mutableCopy;
        for (ZOriganizationCardListModel *cartModel in self.model.coupons_list) {
            [coupons addObject:cartModel.title];
        }
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.cellHeight = CGFloatIn750(62);
        mModel.isHiddenLine = YES;
        mModel.data = coupons;
        mModel.cellTitle = @"label";
        mModel.rightImage = @"rightBlackArrowN";
        mModel.leftFont = [UIFont fontMax1Title];
        mModel.rightColor = [UIColor colorRedForLabel];
        mModel.rightDarkColor = [UIColor colorRedForLabelSub];
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroLabelCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
    if (ValidArray(self.model.merchant_stores_tags)){
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.rightColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.cellHeight = CGFloatIn750(62);
        mModel.isHiddenLine = YES;
        mModel.data = self.model.merchant_stores_tags;
        mModel.cellTitle = @"label";
        mModel.leftFont = [UIFont fontMax1Title];
        mModel.rightColor = [UIColor colorMain];
        mModel.rightDarkColor = [UIColor colorMainSub];
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationDetailIntroLabelCell className] title:mModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel] cellType:ZCellTypeClass dataModel:mModel];
        [self.cellConfigArr addObject:textCellConfig];
        
    }
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    [self.iTableView reloadData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    ZStoresDetailModel *detailModel = sender;
    CGFloat height = 0;
    if (!detailModel) {
        return 0;
    }
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.singleCellHeight = CGFloatIn750(80);
        mModel.cellHeight = CGFloatIn750(82);
        mModel.rightTitle = detailModel.name;
        mModel.rightFont = [UIFont boldFontMax1Title];
        height += [ZMultiseriateContentLeftLineCell z_getCellHeight:mModel];
    }
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.rightImage = @"rightBlackArrowN";
        mModel.rightTitle = [NSString stringWithFormat:@"%@%@%@%@",detailModel.province,detailModel.city,detailModel.county,detailModel.address];
        height += [ZMultiseriateContentLeftLineCell z_getCellHeight:mModel];
    }
    {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.leftTitle = [NSString stringWithFormat:@"营业时间：%@~%@",detailModel.opend_start,detailModel.opend_end];
        height += [ZMultiseriateLineCell z_getCellHeight:mModel];
    }
    if (ValidArray(detailModel.coupons_list)) {
        NSMutableArray *coupons = @[].mutableCopy;
        for (ZOriganizationCardListModel *cartModel in detailModel.coupons_list) {
            [coupons addObject:cartModel.title];
        }
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.cellHeight = CGFloatIn750(62);
        mModel.rightImage = @"rightBlackArrowN";
        mModel.data = coupons;
        mModel.leftFont = [UIFont fontMax1Title];
        height += [ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel];
        
       
    }
    if (ValidArray(detailModel.merchant_stores_tags)) {
        ZBaseMultiseriateCellModel *mModel = [[ZBaseMultiseriateCellModel alloc] init];
        mModel.rightFont = [UIFont fontContent];
        mModel.singleCellHeight = CGFloatIn750(60);
        mModel.cellHeight = CGFloatIn750(62);
        mModel.data = detailModel.merchant_stores_tags;
        mModel.leftFont = [UIFont fontMax1Title];
        height += [ZStudentOrganizationDetailIntroLabelCell z_getCellHeight:mModel];
        
        
    }
    height += CGFloatIn750(20);
    
    return height;
}

@end
