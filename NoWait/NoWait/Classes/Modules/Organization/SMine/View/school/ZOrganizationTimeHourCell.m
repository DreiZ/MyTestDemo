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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    self.data1 = @[].mutableCopy;
    self.data2 = @[].mutableCopy;
    
    self.proIndex = 0;
    self.cityIndex = 0;
    for (int i = 0; i < 24; i++) {
       ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
        if (i < 10) {
            model.name = [NSString stringWithFormat:@"0%d:00",i];
        }else{
            model.name = [NSString stringWithFormat:@"%d:00",i];
        }
       
       [self.data1 addObject:model];
    }
    
    for (int i = 0; i < 24; i++) {
       ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
        if (i < 10) {
            model.name = [NSString stringWithFormat:@"0%d:00",i];
        }else{
            model.name = [NSString stringWithFormat:@"%d:00",i];
        }
       
       [self.data2 addObject:model];
    }
    
    
    [self.contentView addSubview:self.pickView];
    
    [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.pickView reloadAllComponents];
    
    
    UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    middleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    middleLabel.text = @"~";
    middleLabel.numberOfLines = 0;
    middleLabel.textAlignment = NSTextAlignmentCenter;
    [middleLabel setFont:[UIFont fontContent]];
    [self.pickView addSubview:middleLabel];
    [middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.pickView);
    }];
}


- (UIPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] init];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.showsSelectionIndicator = YES;
        _pickView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _pickView;
}


//自定义每个pickview的label
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIView *sectionView = [[UIView alloc] init];
//    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
//    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
//    [sectionView addSubview:bottomLineView];
//    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(sectionView);
//        make.height.mas_equalTo(0.5);
//    }];

    UILabel* pickerLabel = [UILabel new];
    pickerLabel.numberOfLines = 0;
    if (component == 0) {
        if (row == self.proIndex) {
            pickerLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
            [pickerLabel setFont:[UIFont fontMax2Title]];
        }else{
            pickerLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
            [pickerLabel setFont:[UIFont fontMaxTitle]];
        }
    }else{
        if (row == self.cityIndex) {
            pickerLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
            [pickerLabel setFont:[UIFont fontMax2Title]];
        }else{
            pickerLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
            [pickerLabel setFont:[UIFont fontMaxTitle]];
        }
    }
    
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];

    [sectionView addSubview:pickerLabel];
    [pickerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView.mas_left).offset(CGFloatIn750(20));
        make.top.bottom.right.equalTo(sectionView);
    }];

    return sectionView;
}

- (void)setStart:(NSString *)start end:(NSString *)end {
    for (int i = 0; i < self.data1.count; i++) {
        ZAlertDataItemModel *model = self.data1[i];
        if ([start isEqualToString:model.name]) {
            _proIndex = i;
        }
    }
    
    for (int i = 0; i < self.data2.count; i++) {
        ZAlertDataItemModel *model = self.data2[i];
        if ([end isEqualToString:model.name]) {
            _cityIndex = i;
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.pickView selectRow:self.proIndex inComponent:self.cityIndex animated:YES];
    });
}


#pragma mark - picker delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        _proIndex = row;
        if (_cityIndex < _proIndex) {
            _cityIndex = _proIndex;
            [pickerView selectRow:_cityIndex inComponent:1 animated:YES];
        }
    }
    
    if (component == 1) {
        _cityIndex = row;
    }
    if (self.handleBlock) {
        ZAlertDataItemModel *start = self.data1[_proIndex];
        ZAlertDataItemModel *end = self.data2[_cityIndex];
        self.handleBlock(start.name, end.name);
    }
    [pickerView reloadAllComponents];
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
    return CGFloatIn750(68);
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(360);
}
@end

