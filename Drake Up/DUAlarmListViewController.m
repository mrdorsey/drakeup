//
//  DUViewController.m
//  Drake Up
//
//  Created by Michael Dorsey on 2/10/14.
//  Copyright (c) 2014 Drake Up. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "DUAlarmData.h"
#import "DUAlarmFactory.h"
#import "DUAlarmListViewController.h"

@interface DUAlarmListViewController ()

@property (nonatomic, strong) NSDictionary *sortedAlarms;

@end

@implementation DUAlarmListViewController

@synthesize drakeAudioPlayer;

- (NSDictionary *)sortedAlarms;
{
	if (_sortedAlarms == nil) {
		NSMutableDictionary *alarmsDict = [NSMutableDictionary dictionary];
		alarmsDict[@"alarms"] = [NSMutableArray array];
		
		for (DUAlarmData *alarmData in [[DUAlarmFactory sharedFactory] allAlarms]) {
			[alarmsDict[@"alarms"] addObject: alarmData];
		}
		
		// sort?
		
	    _sortedAlarms = alarmsDict;
	}
	
	return _sortedAlarms;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"Drakes";
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
	});
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
	if (tableView == self.tableView) {
		return self.sortedAlarms.count;
	}
	
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
	if (tableView == self.tableView) {
		return [self.sortedAlarms[@"alarms"] count];
	}
	
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	static NSString * const kMRDStateListViewCellIdentifier = @"DUAlarmListViewCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDUAlarmDataNameKey];
	if(cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kMRDStateListViewCellIdentifier];
	}
	
	DUAlarmData *alarmData = nil;
	if (tableView == self.tableView) {
		alarmData = [self _alarmDataAtIndexPath:indexPath];
	}
	
	cell.textLabel.text = alarmData.name;
	cell.accessoryType = UITableViewCellAccessoryNone;
	
	return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{	
	if ([drakeAudioPlayer isPlaying]) {
		[drakeAudioPlayer stop];
	}
	
	if (tableView == self.tableView) {
		DUAlarmData *alarmData = [self _alarmDataAtIndexPath:indexPath];
		NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:alarmData.name ofType: @"mp3"];
		NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
		drakeAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
		[drakeAudioPlayer play];
	}
}

#pragma mark private helpers
- (DUAlarmData *)_alarmDataAtIndexPath:(NSIndexPath *)indexPath;
{
	return self.sortedAlarms[@"alarms"][indexPath.row];
}

@end
