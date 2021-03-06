//
//  ADNPost.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNPost.h"
#import "ADNUser.h"
#import "ADNAnnotation.h"
#import "ADNLink.h"
#import "ADNHashtag.h"
#import "WryApplication.h"
#import "WryUtils.h"
#import "SeparatorSetting.h"
#import "ADNSource.h"

@implementation ADNPost

- (NSString *)description {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendString:(self.user == nil ? @"[RETIRED USER]" : [self.user shortDescription])];
  [str appendFormat:@"\n%@", (self.text == nil ? @"[REDACTED]" : self.text)];
  [str appendFormat:@"\nID: %ld -- %@ (%@)", self.objectID, self.createdAt, self.source.name];
  for (ADNLink *link in self.links) {
    [str appendFormat:@"\n%@", [link description]];
  }
  for (ADNHashtag *hashtag in self.hashtags) {
    [str appendFormat:@"\n%@", [hashtag description]];
  }
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation description]];
  }
  [str appendFormat:@"\n%@", [[WryApplication application].settings stringValue:[WryUtils nameForSettingForClass:[SeparatorSetting class]]]];
  return str;
}

- (NSString *)colorDescription {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendString:(self.user == nil ? [self colorize:@"[RETIRED USER]" colorSetting:WryColorAlert] : [self.user colorShortDescription])];
  [str appendFormat:@"\n%@", (self.text == nil ? [self colorize:@"[REDACTED]" colorSetting:WryColorAlert] : [self colorize:self.text colorSetting:WryColorText])];
  [str appendFormat:@"\nID: %@ -- %@ (%@)",
                    [self colorize:[NSString stringWithFormat:@"%ld", self.objectID] colorSetting:WryColorID],
                    [self colorize:[self.createdAt description] colorSetting:WryColorMuted],
                    [self colorize:self.source.name colorSetting:WryColorID]
  ];
  for (ADNLink *link in self.links) {
    [str appendFormat:@"\n%@", [link colorDescription]];
  }
  for (ADNHashtag *hashtag in self.hashtags) {
    [str appendFormat:@"\n%@", [hashtag colorDescription]];
  }
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation colorDescription]];
  }
  [str appendFormat:@"\n%@", [[WryApplication application].settings stringValue:[WryUtils nameForSettingForClass:[SeparatorSetting class]]]];
  return str;
}

@end
