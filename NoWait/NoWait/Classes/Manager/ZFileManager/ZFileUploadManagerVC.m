//
//  ZFileUploadManagerVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZFileUploadManagerVC.h"
#import "FBAttachmentUploadCollectionViewCell.h"
#import "FBAttachmentUploadCollectionViewCell.h"

#import "ZFileManager.h"
#import "ZFileUploadTask.h"
#import "ZFileUploadManager.h"

static ZFileUploadManagerVC *fileUploadManager;

/**每行显示的个数*/
static CGFloat kPerLineNumber = 3;
/**cell的identifier*/
static NSString *kAttachmentUploadCellIdentifier = @"kAttachmentUploadCellIdentifier";

#define SECTION_LEFT_MARGIN 30
#define ITEM_SPACE 20

@interface ZFileUploadManagerVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FBAttachmentUploadCollectionViewCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *uploadArr;

@end

@implementation ZFileUploadManagerVC

+ (ZFileUploadManagerVC *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        fileUploadManager = [[ZFileUploadManagerVC alloc] init];
    });
    return fileUploadManager;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self configData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"上传列表"];
    
    self.collectionView.hidden = NO;
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
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    [collectionView registerClass:[FBAttachmentUploadCollectionViewCell class] forCellWithReuseIdentifier:kAttachmentUploadCellIdentifier];
    
    return _collectionView;
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

#pragma mark - actions


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.uploadArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FBAttachmentUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAttachmentUploadCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;

    [cell layoutIfNeeded];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(FBAttachmentUploadCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    ZFileUploadTask *task = self.uploadArr[indexPath.row];
//    cell.task = task;
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
//    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
//    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:self.dataArray];
//    if (self.dataArray.count == kAttachmentPhotoMaxNumber) {
//        [mutArray removeObjectAtIndex:indexPath.row];
//        self.dataArray = [mutArray copy];
//        [self.collectionView reloadData];
//    }else {
//        if (indexPath.row>0) {
//            [mutArray removeObjectAtIndex:indexPath.row - 1];
//        }
//        self.dataArray = [mutArray copy];
//        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
//    }
}



- (void)dealloc {
    NSLog(@"%@销毁了",[self class]);
}

@end
