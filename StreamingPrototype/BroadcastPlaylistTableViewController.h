//
//  BroadcastPlaylistTableViewController.h
//  StreamingPrototype
//
//  Created by Alexander Person on 11/11/15.
//  Copyright © 2015 Alexander Person. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface BroadcastPlaylistTableViewController : UITableViewController <MCBrowserViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *songTitles;
@property (strong, nonatomic) NSArray *songs;

@end
