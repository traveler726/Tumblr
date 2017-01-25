//
//  TumblrPostModel.h
//  Tumblr
//
//  Created by Jennifer Beck on 1/25/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TumblrPostModel : NSObject

- (instancetype) initWithDictionary: (NSDictionary *) otherDictionary;

@property (nonatomic, strong) NSURL    *imageURL;

@end
