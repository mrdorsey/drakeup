//
//  DUViewController.h
//  Drake Up
//
//  Created by Michael Dorsey on 2/10/14.
//  Copyright (c) 2014 Drake Up. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DUAlarmListViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, retain) AVAudioPlayer *drakeAudioPlayer;

@end
