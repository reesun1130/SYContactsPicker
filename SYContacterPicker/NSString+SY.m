//
//  NSString+SY.m
//  SYContactsPicker
//
//  Created by reesun on 15/12/30.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "NSString+SY.h"

@implementation NSString (SY)

- (BOOL)sy_containsString:(NSString *)string {
    NSRange range = [[self lowercaseString] rangeOfString:[string lowercaseString]];
    return range.location != NSNotFound;
}

- (NSString *)sy_reformatPhoneNumber {
    NSString *string = self;
    if ([string sy_containsString:@"-"]) {
        string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    if ([string sy_containsString:@"("]) {
        string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    }
    
    if ([string sy_containsString:@")"]) {
        string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    }
    
    if (([string sy_containsString:@"+86"])) {
        string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    }
    
    if ([string sy_containsString:@" "]) {
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    }

    return string;
}

- (BOOL)sy_validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *email = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [email evaluateWithObject:self];
}

- (BOOL)sy_validatePhone {
//    NSString *phoneRegex = @"^13[0-9]{9}$|^14[0-9]{9}$|^15[0-9]{9}$|^18[0-9]{9}$|^17[0-9]{9}$|^400[0-9]{7}-?([1-9]{1}[0-9]{0,4})?$";
    NSString *phoneRegex = @"^1\\d{10}$";
    
    NSPredicate *phone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phone evaluateWithObject:self];
}

- (NSString *)sy_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
