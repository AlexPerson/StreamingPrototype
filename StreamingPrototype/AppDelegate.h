//
//  AppDelegate.h
//  StreamingPrototype
//
//  Created by Alexander Person on 11/11/15.
//  Copyright © 2015 Alexander Person. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MPCHandler.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MPCHandler *mpcHandler;

@end

