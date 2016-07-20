//
//  ViewController.m
//  TemperatureUnitConverter
//
//  Created by Lei Xu on 7/19/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "TemperatureConverter.h"

@interface ViewController ()
@property(nonatomic, weak) UILabel *cLabel;
@property(nonatomic, weak) UILabel *fLabel;
@property(nonatomic, weak) UIPickerView *picker;
@property (strong, nonatomic) NSArray *celsiusNumbers;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger leading = 10;
    NSInteger trailing = -10;
    NSInteger heightOffset = 20;
    
    UILabel *cLabel = [UILabel new];
    UILabel *fLabel = [UILabel new];
    UIPickerView *picker = [UIPickerView new];
    
    [self.view addSubview:cLabel];
    [self.view addSubview:fLabel];
    [self.view addSubview:picker];
    
    self.cLabel = cLabel;
    self.fLabel = fLabel;
    self.picker = picker;
    
    UIColor *color = [UIColor colorWithHue:0.22 saturation:1.0 brightness:0.9 alpha:1.0];
    
    cLabel.textAlignment = NSTextAlignmentRight;
    fLabel.textAlignment = NSTextAlignmentRight;
    cLabel.textColor = color;
    fLabel.textColor = color;
    [cLabel setFont:[UIFont boldSystemFontOfSize:60]];
    [fLabel setFont:[UIFont boldSystemFontOfSize:60]];
    picker.backgroundColor = [UIColor whiteColor];
    
    [self celsiusData];
    [self updateTexts:0.0];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    [self.cLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(heightOffset);
        make.leading.equalTo(self.view.mas_leading).offset(leading);
        make.trailing.equalTo(self.view.mas_trailing).offset(trailing);
    }];
    
    [self.fLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cLabel.mas_baseline).offset(heightOffset);
        make.leading.equalTo(self.view.mas_leading).offset(leading);
        make.trailing.equalTo(self.view.mas_trailing).offset(trailing);
    }];
    
    [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-heightOffset);
        make.leading.equalTo(self.view.mas_leading).offset(leading);
        make.trailing.equalTo(self.view.mas_trailing).offset(trailing);
    }];
    
    [self.picker selectRow:100 inComponent:0 animated:true];
    

}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSNumber *celsiusNumber = [self.celsiusNumbers objectAtIndex:row];
    float celsiusFloat = [celsiusNumber floatValue];
    [self updateTexts:celsiusFloat];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSNumber *celsiusNumber = [self.celsiusNumbers objectAtIndex:row];
    int celsiusInt = [celsiusNumber intValue];
    return [NSString stringWithFormat:@"%d°C", celsiusInt];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.celsiusNumbers.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) celsiusData {
    NSMutableArray *mutableCelsiusNumbers = [NSMutableArray new];
    for (int i=-100; i<=100; i++) {
        [mutableCelsiusNumbers addObject:@(i)];
    }
    self.celsiusNumbers = [mutableCelsiusNumbers copy];
}

- (void)updateTexts: (float) f {
    self.cLabel.text = [NSString stringWithFormat:@"%.2f °C", f];
    self.fLabel.text = [NSString stringWithFormat:@"%.2f °F", [TemperatureConverter celciusToFah:f]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
