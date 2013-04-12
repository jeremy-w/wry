//
//  AuthorizeCommand.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "AuthorizeCommand.h"
#import "WryErrorCodes.h"

@implementation AuthorizeCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  [app println:[NSString stringWithFormat:@"You authorize %@ through a Web browser on the App.net website.",
                                          app.appName]];
  [app println:[NSString stringWithFormat:@"After signing in to App.net and authorizing %@ to use your App.net account,",
                                          app.appName]];
  [app println:@"return to this terminal window and enter the code from your Web browser."];
  [app print:@"Press ENTER to open a Web browser and begin the authorization process -->"];
  [app getInput];

  [app openURL:[NSString stringWithFormat:self.oauthURLFormat, self.clientID, self.redirectURI, self.scope]];

  [app println:@""];
  [app print:@"Enter code from your Web browser: "];
  NSString *accessToken = [app getInput];
  if (accessToken.length > 0) {
    app.accessToken = accessToken;
    return YES;
  } else {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You entered a blank code"}];
    }
    return NO;
  }
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Opens a browser to sign in to App.net and authorize this application.\n"];
  [help appendString:@"After authorization, your browser will show you a code.\n"];
  [help appendString:@"Return to your terminal and paste this code to complete authorization.\n"];
  [help appendString:@"This code is then stored in your Mac OS X Keychain for future use."];
  return help;
}

- (NSString *)summary {
  return @"Authorize with App.net";
}

- (NSString *)oauthURLFormat {
  return @"https://account.app.net/oauth/authenticate?client_id=%@&response_type=token&redirect_uri=%@&scope=%@";
}

- (NSString *)clientID {
  return @"zEKkE4JBYNjnarYvEwGZxvFq7zuhEfnU";
}

- (NSString *)redirectURI {
  return @"http://grailbox.com/wry/callback.html";
}

- (NSString *)scope {
  return @"basic stream email write_post follow public_messages messages files";
}

@end
