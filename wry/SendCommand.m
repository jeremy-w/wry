//
//  SendCommand.m
//  wry
//
//  Created by Rob Warner on 5/14/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "SendCommand.h"
#import "ADNService.h"
#import "WryUtils.h"
#import "WryComposer.h"
#import "WryEnhancer.h"
#import "UnescapeBangEnhancer.h"

@implementation SendCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performObjectOperation:params
                            minimumParams:1
                             errorMessage:@"You must specify a channel to send to"
                                formatter:formatter
                                  options:options
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  NSString *channelID = [params objectAtIndex:0];
                                  id <WryEnhancer> unescapeBangEnhancer = [[UnescapeBangEnhancer alloc] init];
                                  NSString *text = [unescapeBangEnhancer enhance:[[params subarrayWithRange:NSMakeRange(1, params.count - 1)] componentsJoinedByString:@" "]];
                                  if (!text.length) {
                                    WryComposer *composer = [[WryComposer alloc] init];
                                    text = [composer compose];
                                  }
                                  return [service sendMessage:nil replyID:nil
                                                    channelID:channelID text:text
                                                        error:error];
                                }];
}

- (NSString *)usage {
  return @"<channelid> [text]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:
    @"Sends a message to the specified channel. You must specify the channel.\n"
      @"If supplying the text of your message as command-line arguments, note\n"
      "that the shell's parsing rules are respected, so escape\n"
      @"your text appropriately. Quotes are optional.\n"
      @"\n"];
  [help appendString:[WryComposer help]];
  return help;
}

- (NSString *)summary {
  return @"Send a message to a channel";
}

@end
