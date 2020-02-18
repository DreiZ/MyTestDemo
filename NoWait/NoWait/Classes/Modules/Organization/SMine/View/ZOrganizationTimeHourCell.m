//
//  ZOrganizationTimeHourCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTimeHourCell.h"

@interface ZOrganizationTimeHourCell ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIPickerView *pickView;

@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel *> *data1;
@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel *> *data2;
@property (nonatomic,assign) NSInteger proIndex;
@property (nonatomic,assign) NSInteger cityIndex;
@end

@implementation ZOrganizationTimeHourCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    
    self.proIndex = 0;
    self.cityIndex = 0;
    for (int i = 0; i < 24; i++) {
       ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
        if (i < 10) {
            model.name = [NSString stringWithFormat:@"0%d.00",i];
        }else{
            model.name = [NSString stringWithFormat:@"%d.00",i];
        }
       
       [self.data1 addObject:model];
    }
    
    for (int i = 0; i < 24; i++) {
       ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
        if (i < 10) {
            model.name = [NSString stringWithFormat:@"0%d.00",i];
        }else{
            model.name = [NSString stringWithFormat:@"%d.00",i];
        }
       
       [self.data2 addObject:model];
    }
    
    
    [self.contentView addSubview:self.pickView];
    
    [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.pickView reloadAllComponents];
}


- (UIPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] init];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    return _pickView;
}


//自定义每个pickview的label
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIView *sectionView = [[UIView alloc] init];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [sectionView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(sectionView);
        make.height.mas_equalTo(0.5);
    }];

    UILabel* pickerLabel = [UILabel new];
    pickerLabel.numberOfLines = 0;
    pickerLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    [pickerLabel setFont:[UIFont fontContent]];
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];

    [sectionView addSubview:pickerLabel];
    [pickerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView.mas_left).offset(CGFloatIn750(20));
        make.top.bottom.right.equalTo(sectionView);
    }];

    return sectionView;
}


#pragma mark - picker delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        _proIndex = row;
    }
    
    if (component == 1) {
        _cityIndex = row;
    }
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.data1[row].name;
    }else if (component == 1){
        return self.data2[row].name;
    }
    
    return nil;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return self.data1.count;
    }else if (component == 1){
        return self.data2.count;
    }
    
    return 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return CGFloatIn750(86);
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(360);
}
@end

