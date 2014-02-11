//
//  DUAlarmFactory.h
//  Drake Up
//
//  Created by Michael Dorsey on 2/10/14.
//  Copyright (c) 2014 Drake Up. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DUAlarmData.h"

@interface DUAlarmFactory : NSObject

+ (DUAlarmFactory *)sharedFactory;

- (NSArray *)allAlarms;
- (DUAlarmData *)alarmWithName:(NSString *)name;

@end