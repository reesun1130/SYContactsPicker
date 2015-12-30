//
//  SYContacter.m
//  SYContactsPicker
//
//  Created by reesun on 15/12/30.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "SYContacter.h"

@implementation SYContacter

- (NSString *)getContacterName {
    if (_name && _name.length > 0) {
        return _name;
    }
    return @"";
}

@end
