//
//  MRFMovieController.m
//  MovieSearchOBJC
//
//  Created by Michael Flowers on 10/11/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import "MRFMovieController.h"
//These are to construct the url
NSString *const kBaseURL = @"https://api.themoviedb.org/3/search/movie";
NSString *const kApiKeyKey = @"api_key";
NSString *const kApiKeyValue = @"3021207a0f44385e84ef7cc905fb9320";
NSString *const kQuery = @"query";
NSString *const kPosterURL = @"http://image.tmdb.org/t/p/w500";
NSString *const kResultsDictionaryKey = @"results";

@implementation MRFMovieController

+ (MRFMovieController *)sharedInstance
{
    static MRFMovieController * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MRFMovieController alloc] init];
    });
    
    return sharedInstance;
}

- (void)fetchMovieSearchTerm:(NSString *)searchTerm completion:(void (^)(BOOL))completion
{
    NSURL *baseURL = [NSURL URLWithString:kBaseURL];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *apiQueryItem = [NSURLQueryItem queryItemWithName:kApiKeyKey value:kApiKeyValue];
    NSURLQueryItem *queryQueryItem = [NSURLQueryItem queryItemWithName:kQuery value:searchTerm.lowercaseString];
    urlComponents.queryItems =  @[apiQueryItem, queryQueryItem];
    
    NSURL *finalURL = urlComponents.URL;
    NSLog(@"THIS IS THE FETCH MOVIE FINAL URL: %@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@",error.localizedDescription);
            completion(NO);
            return;
        }
        
        if (response) {
            NSLog(@"%@", response);
        }
        
        //if we don't have data then return
        if (!data){
            NSLog(@"No data returned fetching movies");
            completion(NO);
            return;
        }
        
        NSDictionary *topLevelJson = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        
        //results is an ARRAY of (Movie) Dictionaries
        NSArray<NSDictionary *> *resultsDictionary = topLevelJson[kResultsDictionaryKey];
        
        //make a placeholder array to store the movies we get back from all of the dictionaries
        NSMutableArray<MRFMovie *> *tempHoldingMovieArray = [[NSMutableArray alloc] init];
        
        //We don't have to parse anylonger so now we can loop through the array of dictionaries and initialize our  movie object with our initWithDictionary method
        for (NSDictionary *currentMovieDictionary in resultsDictionary)
        {
            MRFMovie *movie = [[MRFMovie alloc] initWithDictionary:currentMovieDictionary];
            [tempHoldingMovieArray addObject:movie];
        }
        
        MRFMovieController.sharedInstance.movies = tempHoldingMovieArray;
        completion(YES);
        
    }]resume];
}

- (void)fetchPostImageWithMovie:(MRFMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    NSString *baseURLString = kPosterURL;
    NSString *moviePosterURLString = [baseURLString stringByAppendingString:movie.poster];
    NSURL * finalURL = [NSURL URLWithString:moviePosterURLString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@",error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (response) {
            NSLog(@"%@", response);
        }
        
            //no data then return
        if (!data){
            NSLog(@"No data returned fetching poster images for movies");
            completion(nil);
            return;
        }
        
        //turn data into an image
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
        
    }]resume];
}

@end
