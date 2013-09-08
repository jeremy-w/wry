//
//  VersionCommand.m
//  wry
//
//  Created by Rob Warner on 3/20/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "VersionCommand.h"

@implementation VersionCommand

- (BOOL)run:(NSArray *)params error:(NSError **)error {
  WryApplication *app = [WryApplication application];
  [app println:[NSString stringWithFormat:@"%@ version %@", app.appName, app.version]];
  [app println:@"Copyright (C) 2013, Rob Warner (@hoop33)"];
  [app println:@"http://grailbox.com/wry"];
  [app println:@""];
  [app println:@"Acknowledgments:"];
  [app println:@"Jeremy W. Sherman (@jws): Post via STDIN (redirection, pipe, interactive input)."];
  [app println:@"SSKeychain (https://github.com/soffes/sskeychain): Keychain access."];
  return YES;
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  return @"Displays version information about this application.";
}

- (NSString *)summary {
  return @"Display version information";
}

@end
