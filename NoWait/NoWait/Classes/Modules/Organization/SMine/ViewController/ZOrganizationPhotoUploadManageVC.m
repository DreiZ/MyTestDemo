//
//  ZOrganizationPhotoUploadManageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationPhotoUploadManageVC.h"
#import "FBAttachmentUploadCollectionViewCell.h"
#import "FBAttachmentUploadCollectionViewCell.h"

#import "XLPaymentSuccessHUD.h"
#import "XLPaymentLoadingHUD.h"

#import "ZFileManager.h"
#import "ZFileUploadTask.h"
#import "ZFileUploadManager.h"

#import "ZOriganizationPhotoViewModel.h"

/**每行显示的个数*/
static CGFloat kPerLineNumber = 3;
/**cell的identifier*/
static NSString *kAttachmentUploadCellIdentifier = @"kAttachmentUploadCellIdentifier";

#define SECTION_LEFT_MARGIN 30
#define ITEM_SPACE 20

@interface ZOrganizationPhotoUploadManageVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FBAttachmentUploadCollectionViewCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *uploadArr;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation ZOrganizationPhotoUploadManageVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"相册上传列表"];
    
    [self setMainView];
    self.collectionView.hidden = NO;
    
    [self setDataSource];
    
    [self configData];
}

- (void)setDataSource {

    NSMutableArray *tasklist = @[].mutableCopy;
    
    for (int i = 0; i < self.imageArr.count; i++) {
        ZFileUploadDataModel *dataModel = [[ZFileUploadDataModel alloc] init];
        dataModel.image = self.imageArr[i];
        dataModel.taskState = ZUploadStateWaiting;
        [tasklist addObject:dataModel];
        [ZFileUploadManager addTaskDataToUploadWith:dataModel];
    }
    
    [self showLoadingAnimation];
//    //异步串行
    [[ZFileUploadManager sharedInstance] asyncSerialUpload:tasklist progress:^(CGFloat p, NSInteger index) {

    } completion:^(id obj) {
        if (obj && [obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = obj;
            NSMutableArray *images = @[].mutableCopy;
            for (int i = 0; i < arr.count; i++) {
                ZBaseNetworkBackModel *dataModel = arr[i];
                if (ValidDict(dataModel.data)) {
                    ZBaseNetworkImageBackModel *imageModel = [ZBaseNetworkImageBackModel mj_objectWithKeyValues:dataModel.data];
                    if ([dataModel.code integerValue] == 0 ) {
                        [images addObject:SafeStr(imageModel.url)];
                    }
                }
            }

            [self updateData:images];
        }
    }];
//    asyncConcurrentGroupUpload asyncConcurrentConstUpload
}

- (void)setMainView {
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(200));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}


#pragma mark - lazy
- (UICollectionView *)collectionView
{
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = ITEM_SPACE;
    layout.minimumInteritemSpacing = ITEM_SPACE/2;
    layout.sectionInset = UIEdgeInsetsMake(20, SECTION_LEFT_MARGIN, 20, SECTION_LEFT_MARGIN);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.alwaysBounceVertical = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = YES;
    _collectionView = collectionView;
    
    [collectionView registerClass:[FBAttachmentUploadCollectionViewCell class] forCellWithReuseIdentifier:kAttachmentUploadCellIdentifier];
    
    return _collectionView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(200))];
    }
    return _bottomView;
}

#pragma mark - configUI
/**
 重写此方法，拦截导航栏返回按钮的点击相应方法

 @return bool值
 */
- (BOOL)navigationShouldPopOnBackButton {
    return YES;
}

#pragma mark - configData
/**
 配置数据
 */
- (void)configData {
    _uploadArr = [ZFileUploadManager sharedInstance].taskModelList;

    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.uploadArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FBAttachmentUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAttachmentUploadCellIdentifier forIndexPath:indexPath];

    [cell layoutIfNeeded];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(FBAttachmentUploadCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    ZFileUploadDataModel *taskData = self.uploadArr[indexPath.row];
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

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = (KScreenWidth - SECTION_LEFT_MARGIN*2 - (kPerLineNumber-1)*ITEM_SPACE)/kPerLineNumber;
    return CGSizeMake(w, w);
}

#pragma mark - FBAttachmentUploadCollectionViewCellDelegate
- (void)configCellDelete:(FBAttachmentUploadCollectionViewCell *)cell withOject:(id)object
{

//        if (indexPath.row>0) {
//            [mutArray removeObjectAtIndex:indexPath.row - 1];
//        }
//        self.dataArray = [mutArray copy];
//        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


#pragma mark - set loading view
-(void)showLoadingAnimation{
    
    //隐藏支付完成动画
    [XLPaymentSuccessHUD hideIn:self.bottomView];
    //显示支付中动画
    [XLPaymentLoadingHUD showIn:self.bottomView];
}

-(void)showSuccessAnimation{
    
    //隐藏支付中成动画
    [XLPaymentLoadingHUD hideIn:self.bottomView];
    //显示支付完成动画
    [XLPaymentSuccessHUD showIn:self.bottomView];
}

- (void)dealloc {
    NSLog(@"%@销毁了",[self class]);
}

#pragma mark - 上传图片url
- (void)updateData:(NSArray *)imageUrlArr {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    [params setObject:SafeStr(self.type) forKey:@"type"];
    [params setObject:imageUrlArr forKey:@"images"];
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@"上传图片中..."];
    [ZOriganizationPhotoViewModel addImage:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [weakSelf showSuccessAnimation];
            if (weakSelf.uploadCompleteBlock) {
                weakSelf.uploadCompleteBlock();
            }
            [TLUIUtility showSuccessHint:message];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}
@end
