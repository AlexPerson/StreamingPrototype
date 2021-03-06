//
//  MPCHandler.h
//  StreamingPrototype
//
//  Created by Alexander Person on 11/11/15.
//  Copyright © 2015 Alexander Person. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface MPCHandler : NSObject

@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCSession *session;
@property (nonatomic, strong) MCBrowserViewController *browser;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;

- (void)setupPeerWithDisplayName:(NSString *)displayName;
- (void)setupSession;
- (void)setupBrowser;
- (void)advertiseSelf:(BOOL)advertise;

@end
