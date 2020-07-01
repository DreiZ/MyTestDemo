//
//  ZIntroductryPagesView.m
//  ZProject
//
//  Created by zzz on 2018/6/7.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZIntroductryPagesView.h"
#import <YYAnimatedImageView.h>
#import <YYImage.h>

@interface ZIntroductryPagesView ()<UIScrollViewDelegate>
/** <#digest#> */
@property (nonatomic, strong) NSArray<NSArray <NSString *>*> *imagesArray;

@property (nonatomic,strong) UIPageControl *pageControl;

/** <#digest#> */
@property (weak, nonatomic) UIScrollView *scrollView;

@end

@implementation ZIntroductryPagesView

+ (instancetype)pagesViewWithFrame:(CGRect)frame images:(NSArray<NSArray <NSString *>*> *)images{
    ZIntroductryPagesView *pagesView = [[self alloc] initWithFrame:frame];
    pagesView.imagesArray = images;
    return pagesView;
}



- (void)setupUIOnce{
    self.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    
    //添加手势
    UITapGestureRecognizer *singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:singleRecognizer];
}

- (void)setImagesArray:(NSArray<NSArray <NSString *>*> *)imagesArray {
    _imagesArray = imagesArray;
    [self loadPageView];
}

- (void)loadPageView {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((self.imagesArray.count + 1) * kScreenWidth, kScreenHeight);
    self.pageControl.numberOfPages = self.imagesArray.count;
//    self.pageControl.hidden = YES;
    
    
    
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"introTop"];
    topImageView.layer.masksToBounds = YES;
    [self.scrollView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.width.mas_equalTo(KScreenWidth*2.0/3.0f + 20);
        make.height.equalTo(topImageView.mas_width).multipliedBy(839.0/837.0);
    }];
    
    UIImageView *bottomImageView = [[UIImageView alloc] init];
    bottomImageView.image = [UIImage imageNamed:@"introBottom"];
    bottomImageView.layer.masksToBounds = YES;
    [self.scrollView addSubview:bottomImageView];
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self);
        make.width.mas_equalTo(KScreenWidth/2.0f);
        make.height.equalTo(bottomImageView.mas_width).multipliedBy(830.0/669.0);
    }];

    NSArray *titleArr = @[@[@"启蒙教师找好的",@"海量机构入驻，选择少犯错，找到合适你的培训机构"],@[@"精准课程表",@"实时掌握课程时间，不错过每一节课"],@[@"线上交易有保障",@"保证您的资金安全，避免资金纠纷"]];
    NSArray *multiArr = @[@(1422.0f/945.0),@(1314.0/991.0),@(1343.0/935.0)];
    __block UIView *tempImageView = nil;
    [self.imagesArray enumerateObjectsUsingBlock:^(NSArray <NSString *>* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        imageView.frame = CGRectMake(idx * kScreenWidth, 0, kScreenWidth, kScreenHeight);
//        imageView.backgroundColor = [UIColor redColor];
        
        YYImage *image = [YYImage imageNamed:obj[0]];
        
        
        if (image) {
            [imageView setImage:image];
        }else{
            [imageView setImage:[UIImage imageNamed:obj[0]]];
        }
        
        [self.scrollView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (KScreenHeight >= 812) {
                make.top.equalTo(self.scrollView.mas_top).offset(130);
                make.width.mas_equalTo(KScreenWidth - 60);
            }else if(KScreenHeight >= 736) {
                make.top.equalTo(self.scrollView.mas_top).offset(88);
                make.width.mas_equalTo(KScreenWidth - 110);
            }else if(KScreenHeight >= 667) {
                make.top.equalTo(self.scrollView.mas_top).offset(64);
                make.width.mas_equalTo(KScreenWidth - 94);
            }else{
                make.top.equalTo(self.scrollView.mas_top).offset(40);
                make.width.mas_equalTo(KScreenWidth - 106);
            }
            make.height.equalTo(imageView.mas_width).multipliedBy([multiArr[idx] doubleValue]);
            make.centerX.equalTo(self.scrollView.mas_left).offset(idx * KScreenWidth + KScreenWidth/2.0);
        }];
        
        {
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
            titleLabel.text = titleArr[idx][0];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(38)]];
            [self.scrollView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                if (tempImageView) {
                    make.top.equalTo(tempImageView.mas_top);
                }else{
                    if (KScreenHeight >= 812) {
                        make.top.equalTo(imageView.mas_bottom).offset(16);
                    }else if(KScreenHeight >= 736) {
                        make.top.equalTo(imageView.mas_bottom).offset(15);
                    }else if(KScreenHeight >= 667) {
                        make.top.equalTo(imageView.mas_bottom).offset(CGFloatIn750(18));
                    }else{
                        make.top.equalTo(imageView.mas_bottom).offset(8);
                    }
                }
                make.centerX.equalTo(imageView.mas_centerX);
            }];
            
            UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            subTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGray1]);
            subTitleLabel.text = titleArr[idx][1];
            subTitleLabel.textAlignment = NSTextAlignmentCenter;
            [subTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
            [self.scrollView addSubview:subTitleLabel];
            [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titleLabel.mas_bottom).offset(CGFloatIn750(20));
                make.centerX.equalTo(imageView.mas_centerX);
            }];
            tempImageView = titleLabel;
            
            if (idx == 2) {
                YYAnimatedImageView *btnImageView = [[YYAnimatedImageView alloc]init];
                YYImage *image = [YYImage imageNamed:@"introBtn"];
                if (image) {
                    [btnImageView setImage:image];
                }else{
                    [btnImageView setImage:[UIImage imageNamed:@"introBtn"]];
                }
                [self.scrollView addSubview:btnImageView];
                [btnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(subTitleLabel.mas_centerX);
                    make.top.equalTo(subTitleLabel.mas_bottom).offset(CGFloatIn750(60) + 30);
                }];
            }
        }
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView.mas_centerX);
        make.top.equalTo(tempImageView.mas_bottom).offset(CGFloatIn750(80));
        make.height.mas_equalTo(40);
    }];
}

-(void)handleSingleTapFrom {
    if (_pageControl.currentPage == self.imagesArray.count-1) {
        [self removeFromSuperview];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offSet = scrollView.contentOffset;
    NSInteger page = (offSet.x / (self.bounds.size.width) + 0.5);
    self.pageControl.currentPage = page;//计算当前的页码
//    self.pageControl.hidden = (page > self.imagesArray.count - 1);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x >= (_imagesArray.count) * kScreenWidth) {
        [self removeFromSuperview];
    }
}


- (UIScrollView *)scrollView {
    if(!_scrollView)
    {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:scrollView];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;//设置分页
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if(!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight - 40, 0, 40)];
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.pageIndicatorTintColor = [UIColor  colorMain];
        pageControl.currentPageIndicatorTintColor = adaptAndDarkColor([UIColor colorBlackBGDark], [UIColor colorWhite]);
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUIOnce];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUIOnce];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
@end

