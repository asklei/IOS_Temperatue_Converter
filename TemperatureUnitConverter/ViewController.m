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
@property(nonatomic, weak) UISlider *slider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger leading = 10;
    NSInteger trailing = -10;
    NSInteger heightOffset = 20;
    
    UILabel *cLabel = [UILabel new];
    UILabel *fLabel = [UILabel new];
    UISlider *slider = [UISlider new];
    
    [self.view addSubview:cLabel];
    [self.view addSubview:fLabel];
    [self.view addSubview:slider];
    
    self.cLabel = cLabel;
    self.fLabel = fLabel;
    self.slider = slider;
    
    cLabel.textAlignment = NSTextAlignmentRight;
    fLabel.textAlignment = NSTextAlignmentRight;
    [cLabel setFont:[UIFont boldSystemFontOfSize:60]];
    [fLabel setFont:[UIFont boldSystemFontOfSize:60]];
    slider.tintColor = [UIColor colorWithHue:0.22 saturation:1.0 brightness:0.9 alpha:1.0];
    slider.minimumValue = -100;
    slider.maximumValue = 100;
    [self updateBackgrondColor];
    
    
    
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
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-heightOffset);
        make.leading.equalTo(self.view.mas_leading).offset(leading);
        make.trailing.equalTo(self.view.mas_trailing).offset(trailing);
    }];
    
    [self.slider addTarget:self action:@selector(updateBackgrondColor) forControlEvents:UIControlEventValueChanged];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(float)ceciusToF:(float) c {
    return 1.8*c + 32;
}

- (void)updateBackgrondColor {
    self.view.backgroundColor = [UIColor colorWithHue:self.slider.value/100 saturation:0.8 brightness:0.8 alpha:0.5];
    self.cLabel.text = [NSString stringWithFormat:@"%.2f °C", self.slider.value];
    self.fLabel.text = [NSString stringWithFormat:@"%.2f °F", [TemperatureConverter celciusToFah:self.slider.value]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
