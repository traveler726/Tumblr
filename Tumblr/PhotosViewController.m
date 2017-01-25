//
//  PhotosViewController.m
//  Tumblr
//
//  Created by Jennifer Beck on 1/25/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "PhotosViewController.h"
#import "TumblrPostTableViewCell.h"
#import "TumblrPostModel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>  // Adds functionality to the ImageView

@interface PhotosViewController () <UITableViewDataSource>;

@property (weak, nonatomic) IBOutlet UITableView *tumblrTableView;

@property (strong, nonatomic) NSArray<TumblrPostModel *> *posts;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tumblrTableView.rowHeight = 320;
    self.tumblrTableView.dataSource = self;
    [self fetchPosts];
}
-(void) fetchPosts {

    // Do any additional setup after loading the view, typically from a nib.
    NSString *apiKey = @"Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV";
    NSString *urlString =
    [@"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=" stringByAppendingString:apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"Response: %@", responseDictionary);
                                                    
                                                    // Parse the dictionary 'results' array into individual movie json maps.
                                                    // Then populate the movie models from each movie json map.
                                                    NSArray *posts = responseDictionary[@"response"][@"posts"];
                                                    
                                                    NSMutableArray *models = [NSMutableArray array];
                                                    for (NSDictionary *post in posts) {
                                                        TumblrPostModel *model = [[TumblrPostModel alloc] initWithDictionary:post];
                                                        NSLog(@"Post = %@", model);
                                                        [models addObject:model];
                                                    }
                                                    // Since ViewController is defined as non-mutable the access to it will be non-mutable.
                                                    // This is true even tho the backing object is actually a mutable array.
                                                    self.posts = posts;
                                                    
                                                    // force the tableView new info to display
                                                    [self.tumblrTableView reloadData];
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [task resume];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)movieTableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TumblrPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tumblrPostCell" forIndexPath:indexPath];
    
    //  [cell.titleLabel setText:[NSString stringWithFormat:@"Row %ld", indexPath.row]];
    //  [cell.overviewLabel setText:[NSString stringWithFormat:@"Overview for row %ld", indexPath.row]];
    //  [cell.posterImage setImage:[UIImage imageNamed:@"poster_placeholder.png"]];
    
//    MovieModel *model = [self.movies objectAtIndex:indexPath.row];
//    cell.titleLabel.text = model.title;
//    cell.overviewLabel.text = model.movieDescription;
//    //  cell.posterImage.contentMode = UIViewContentModeScaleAspectFit;  // can also set in the storyboard view.
//    [cell.posterImage setImageWithURL:model.posterURL];
    
    TumblrPostModel *model = [self.posts objectAtIndex:indexPath.row];
    [cell.tumblrPostImageView setImageWithURL:model.imageURL];
    
    NSLog(@"Loading Row:$%ld", indexPath.row);
    
    return cell;
}


@end
