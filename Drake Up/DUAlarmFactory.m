//
//  DUAlarmFactory.m
//  Drake Up
//
//  Created by Michael Dorsey on 2/10/14.
//  Copyright (c) 2014 Drake Up. All rights reserved.
//

#import "DUAlarmFactory.h"
#import "DUAlarmData.h"

@interface DUAlarmFactory ()

@property (nonatomic, strong) NSArray *alarmData;
@property (nonatomic, strong) NSDictionary *alarms;

- (NSString *)_dataFilePath;

@end

@implementation DUAlarmFactory

#pragma mark Singleton

+ (DUAlarmFactory *)sharedFactory;
{
	static DUAlarmFactory *_sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedInstance = [[DUAlarmFactory alloc] init];
	});
	
	return _sharedInstance;
}

- (NSArray *)allAlarms;
{
	return [[self.alarms allValues] sortedArrayUsingDescriptors:@[ [NSSortDescriptor sortDescriptorWithKey:kDUAlarmDataNameKey ascending:YES]]];
}

- (DUAlarmData *)alarmWithName:(NSString *)name;
{
	return self.alarms[name];
}

#pragma mark custom accessors
- (NSDictionary *)alarms;
{
	if(_alarms == nil) {
		NSMutableDictionary *alarmData = [NSMutableDictionary dictionaryWithCapacity:self.alarmData.count];
		for (NSDictionary *alarmDict in self.alarmData) {
			[alarmData setObject:[[DUAlarmData alloc] initWithAttributes:alarmDict] forKey:alarmDict[kDUAlarmDataNameKey]];
		}
		
		_alarms = alarmData;
	}
	
	return _alarms;
}

- (NSArray *)alarmData;
{
	if(_alarmData == nil) {
		_alarmData = [NSArray arrayWithContentsOfFile:[self _dataFilePath]];
	}
	
	return _alarmData;
}

#pragma mark private helpers

- (NSString *)_dataFilePath;
{
	return [[NSBundle mainBundle] pathForResource:@"drakes" ofType:@"plist"];
}

@end
