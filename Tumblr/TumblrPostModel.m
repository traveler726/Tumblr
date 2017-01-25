//
//  TumblrPostModel.m
//  Tumblr
//
//  Created by Jennifer Beck on 1/25/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "TumblrPostModel.h"

@implementation TumblrPostModel

- (instancetype) initWithDictionary: (NSDictionary *) dictionary {
    
    self = [super init];
    
    if (self) {  // Verify that it exists.
        
        // Initial the model by parsing the JSON Dictionary
        self.imageURL = [NSURL URLWithString:dictionary[@"photos"][0][@"original_size"][@"url"]];
        NSLog(@"The TumblrPost has an imageURL of %@", self.imageURL);
        
        // Build the image path from the poster path and API:
        // The movie poster is available by appending the returned poster_path to https://image.tmdb.org/t/p/w342.
        
        // Too Much Memory trashing...
        // NSString *urlPath   = dictionary[@"poster_path"]; // path only!
        // NSString *urlString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w342%@", urlPath];
        
    }
    
    return self;
}
@end
