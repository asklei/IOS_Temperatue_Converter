//
//  TemperatureConverter.m
//  TemperatureUnitConverter
//
//  Created by Lei Xu on 7/20/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "TemperatureConverter.h"

@implementation TemperatureConverter

+ (float) celciusToFah:(float)celcius {
    return celcius * 1.8 + 32;
}

@end
