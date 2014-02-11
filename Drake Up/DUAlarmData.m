//
//  DUAlarmData.m
//  Drake Up
//
//  Created by Michael Dorsey on 2/10/14.
//  Copyright (c) 2014 Drake Up. All rights reserved.
//

#import "DUAlarmData.h"

@interface DUAlarmData ()

@property (nonatomic, strong) NSString *name;

@end

@implementation DUAlarmData

- (id)initWithAttributes:(NSDictionary *)attributes;
{
	if (!(self = [super init])) {
		return nil;
	}
	
	NSArray *attributeNames = @[ @"name"];
 	for (NSString *key in attributeNames) {
		[self setValue:attributes[key] forKey:key];
	}
	
	return self;
}


#pragma mark private helpers

- (NSString *)_mp3FileName:(NSString *)name;
{
	return [NSString stringWithFormat:@"%@", name];
}

- (NSString *)_mp3FilePath:(NSString *)name;
{
	return [[NSBundle mainBundle] pathForResource:[self _mp3FileName:name] ofType:@"mp3"];
}

@end
