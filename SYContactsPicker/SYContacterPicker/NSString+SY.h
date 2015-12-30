//
//  NSString+SY.h
//  SYContactsPicker
//
//  Created by reesun on 15/12/30.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SY)

- (BOOL)sy_containsString:(NSString *)string;
- (NSString *)sy_reformatPhoneNumber;
- (BOOL)sy_validateEmail;
- (BOOL)sy_validatePhone;
- (NSString *)sy_trim;

@end
