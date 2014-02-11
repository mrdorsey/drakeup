//
//  DUAlarmData.h
//  Drake Up
//
//  Created by Michael Dorsey on 2/10/14.
//  Copyright (c) 2014 Drake Up. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kDUAlarmDataNameKey = @"name";

@interface DUAlarmData : NSObject

@property (nonatomic, readonly) NSString *name;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
