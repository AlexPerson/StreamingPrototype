//
//  BroadcastPlaylistTableViewController.m
//  StreamingPrototype
//
//  Created by Alexander Person on 11/11/15.
//  Copyright © 2015 Alexander Person. All rights reserved.
//

#import "BroadcastPlaylistTableViewController.h"
#import "AppDelegate.h"
@import MediaPlayer;

@interface BroadcastPlaylistTableViewController ()

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (nonatomic) BOOL *advertState;

@end

@implementation BroadcastPlaylistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self.appDelegate.mpcHandler setupPeerWithDisplayName:[UIDevice currentDevice].name];
    [self.appDelegate.mpcHandler setupSession];
    [self.appDelegate.mpcHandler advertiseSelf:self.advertState];
}


- (IBAction)inviteToConnect:(id)sender {
    if (self.appDelegate.mpcHandler.session != nil) {
        [[self.appDelegate mpcHandler] setupBrowser];
        [[[self.appDelegate mpcHandler] browser] setDelegate:self];
        
        [self presentViewController:self.appDelegate.mpcHandler.browser
                           animated:YES
                         completion:nil];
    }
}

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [self.appDelegate.mpcHandler.browser dismissViewControllerAnimated:YES completion:nil];
}

- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    [self.appDelegate.mpcHandler.browser dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    MPMediaItem *current = [self.songs objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [current valueForProperty: MPMediaItemPropertyTitle];
    cell.detailTextLabel.text = [current valueForProperty:MPMediaItemPropertyAlbumArtist];
    
    MPMediaItemArtwork *artwork = [current valueForProperty:MPMediaItemPropertyArtwork];
    
    UIImage *artworkImage = [artwork imageWithSize: CGSizeMake (44, 44)];
    
    if (artworkImage) {
        cell.imageView.image = artworkImage;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"No-artwork-albums.png"];
    }
    
    return cell;
}

#pragma Media Picker

- (IBAction)addSongs:(id)sender {
    MPMediaPickerController *picker = [[MPMediaPickerController alloc]
                                       initWithMediaTypes: MPMediaTypeAnyAudio];
    
    [picker setDelegate: self];
    [picker setAllowsPickingMultipleItems: YES];
    picker.prompt =
    NSLocalizedString (@"Add songs to play",
                       "Prompt in media item picker");
    
    [self presentViewController: picker animated: YES completion:nil];
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    [self dismissViewControllerAnimated: YES completion:nil];
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker
   didPickMediaItems: (MPMediaItemCollection *) collection {
    NSLog(@"item picked %@", collection );
    
    
    [self dismissViewControllerAnimated: YES completion:nil];
    self.songs = [collection items];
//    [self mediaItemToData:collection.items[0]];
    for (MPMediaItem *song in self.songs) {
        [self.songTitles addObject:[song valueForProperty: MPMediaItemPropertyTitle]];
    }
    [self.tableView reloadData];
    NSLog(@"Song Titles Array: %@", self.songTitles);
}


@end
