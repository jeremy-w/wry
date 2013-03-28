//
//  MuteCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "MuteCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation MuteCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performSingleParamOperation:app
                                            params:params
                                    successMessage:@"Muted user:"
                                      errorMessage:@"You must specify a user ID or @username to mute"
                                             error:error
                                         operation:(ADNOperationBlock) ^(ADNService *service) {
                                           return [service mute:[params objectAtIndex:0] error:error];
                                         }];
}

- (NSString *)usage {
  return @"<userid | @username>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Mutes a user. You must specify either the user's ID or @username.\n"];
  [help appendString:@"Displays the user information for the user you've muted."];
  return help;
}

- (NSString *)summary {
  return @"Mute a user";
}

@end
