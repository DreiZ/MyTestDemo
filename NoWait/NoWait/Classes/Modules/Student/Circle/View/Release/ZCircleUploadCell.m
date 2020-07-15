//
//  ZCircleUploadCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleUploadCell.h"
#import "FBAttachmentUploadCollectionViewCell.h"
#import "FBCustomUploadProgress.h"

#import "XLPaymentSuccessHUD.h"
#import "XLPaymentLoadingHUD.h"
#import "XLPaymentErrorHUD.h"

#define SECTION_LEFT_MARGIN 10
#define ITEM_SPACE 10

@interface ZCircleUploadCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UIView *topBackView;
@property (nonatomic,strong) UIView *bottomBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation ZCircleUploadCell

- (void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    _dataSource = @[].mutableCopy;
    
    [self.contentView addSubview:self.contView];
    [self.contView addSubview:self.bottomBackView];
    [self.contView addSubview:self.funBackView];
    [self.contView addSubview:self.topBackView];
    [self.topBackView addSubview:self.titleLabel];
    [self.funBackView addSubview:self.iCollectionView];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(10));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(10));
    }];
    
    [self.topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.topBackView.mas_bottom);
        make.bottom.equalTo(self.bottomBackView.mas_top);
    }];
    
    [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(120));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topBackView);
        make.centerY.equalTo(self.topBackView.mas_centerY);
    }];

    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.funBackView);
    }];
    
    _titleLabel.text = @"";
}


#pragma mark -Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.clipsToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(16));
    }
    return _contView;
}

- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
        _funBackView.layer.masksToBounds = YES;
        _funBackView.clipsToBounds = YES;
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    }
    return _funBackView;
}

- (UIView *)bottomBackView {
    if (!_bottomBackView) {
        _bottomBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - CGFloatIn750(60), CGFloatIn750(120))];
        _bottomBackView.layer.masksToBounds = YES;
        _bottomBackView.clipsToBounds = YES;
        _bottomBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
        [_bottomBackView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.bottomBackView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _bottomBackView;
}

- (UIView *)topBackView {
    if (!_topBackView) {
        _topBackView = [[UIView alloc] init];
        _topBackView.layer.masksToBounds = YES;
        _topBackView.clipsToBounds = YES;
        _topBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
        [_topBackView addSubview:bottomLineView];
        
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.topBackView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _topBackView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont boldFontContent]];
    }
    return _titleLabel;
}

- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(100)) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = NO;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        
        [_iCollectionView registerClass:[FBAttachmentUploadCollectionViewCell class] forCellWithReuseIdentifier:@"kAttachmentUploadCellIdentifier"];
    }
    
    return _iCollectionView;
}


#pragma mark collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FBAttachmentUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kAttachmentUploadCellIdentifier" forIndexPath:indexPath];

    [cell layoutIfNeeded];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(FBAttachmentUploadCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    ZFileUploadDataModel *taskData = self.dataSource[indexPath.row];
    cell.taskModel = taskData;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    FBAttachmentUploadCollectionViewCell *cell = (FBAttachmentUploadCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//
//    if (self.isUploading) {
//        NSLog(@"上传中，不要选图片...");
//        return;
//    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(10), SECTION_LEFT_MARGIN, CGFloatIn750(10), SECTION_LEFT_MARGIN);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return ITEM_SPACE;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return ITEM_SPACE;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = ((KScreenWidth - CGFloatIn750(40)) - SECTION_LEFT_MARGIN*2 - (3-1)*ITEM_SPACE)/3;
    return CGSizeMake(w-0.5, w);
}

#pragma mark 类型
+(CGFloat)z_getCellHeight:(id)sender {
    ZCircleUploadModel *model = sender;
    NSArray *list = model.uploadList;
    CGFloat height = 0;
    CGFloat w = ((KScreenWidth - CGFloatIn750(40)) - SECTION_LEFT_MARGIN*2 - (3-1)*ITEM_SPACE)/3;
    if (list.count%3 > 0) {
        height = (list.count/3 + 1) * w + ((list.count/3) * CGFloatIn750(4))+ CGFloatIn750(40);
    }else{
        height = list.count/3  * w + (list.count/3 - 1)  * CGFloatIn750(4) + CGFloatIn750(40);
    }
    return height + CGFloatIn640(200);
}

- (void)setModel:(ZCircleUploadModel *)model {
    _model = model;
    _dataSource = model.uploadList;
    _titleLabel.text = [NSString stringWithFormat:@"上传动态：%@",model.title];
    
    model.progressBlock = ^(CGFloat progress) {
        [self showLoadingAnimation];
    };
    model.completeBlock = ^(id obj) {
        if (model.uploadStatus == ZCircleUploadStatusUploadOtherData) {
            [self showLoadingAnimation];
        }else if(model.uploadStatus == ZCircleUploadStatusComplete){
            [self showSuccessAnimation];
        }
    };
    model.errorBlock = ^(NSError *error) {
        [self showErrorAnimation];
    };
    
    if (model.uploadStatus == ZCircleUploadStatusComplete) {
        [self showSuccessAnimation];
    }else if(model.uploadStatus == ZCircleUploadStatusError){
        [self showErrorAnimation];
    }else {
        [self showLoadingAnimation];
    }
    [self.iCollectionView reloadData];
}


#pragma mark - set loading view
-(void)showLoadingAnimation{
    
    //隐藏支付完成动画
    [XLPaymentSuccessHUD hideIn:self.bottomBackView];
    //显示支付中动画
    [XLPaymentLoadingHUD showIn:self.bottomBackView];
}

-(void)showSuccessAnimation{
    
    //隐藏支付中成动画
    [XLPaymentLoadingHUD hideIn:self.bottomBackView];
    //显示支付完成动画
    [XLPaymentSuccessHUD showIn:self.bottomBackView];
}

-(void)showErrorAnimation{
    //隐藏支付中成动画
    [XLPaymentLoadingHUD hideIn:self.bottomBackView];
    //显示支付完成动画
    [XLPaymentErrorHUD showIn:self.bottomBackView];
}
@end
