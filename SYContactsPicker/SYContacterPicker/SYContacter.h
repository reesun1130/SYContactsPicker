//
//  SYContacter.h
//  SYContactsPicker
//
//  Created by reesun on 15/12/30.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYContacter : NSObject

@property (nonatomic) NSInteger section;
@property (nonatomic) NSInteger recordID;
@property (nonatomic) BOOL selected;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;

- (NSString *)getContacterName;

@end
