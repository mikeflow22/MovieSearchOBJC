//
//  MRFMovie.m
//  MovieSearchOBJC
//
//  Created by Michael Flowers on 10/11/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import "MRFMovie.h"
//these are to be used to parse through the dictionary
NSString *const kTitle = @"title";
NSString *const kOverview = @"overview";
NSString *const kRating = @"vote_average";
NSString *const kPoster = @"poster_path";

@implementation MRFMovie
- (MRFMovie *)initMovieWithTitle:(NSString *)title overview:(NSString *)overview rating:(double)rating poster:(NSString *)poster
{
    self = [super init];
    if (self)
    {
        _title = title;
        _overview = overview;
        _rating = rating;
        _poster = poster;
        
    }
    return self;
}
@end

@implementation MRFMovie (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictitionary
{
    NSString *title = dictitionary[kTitle];
    NSString *overview =  dictitionary[kOverview];
    double rating = [dictitionary[kRating] doubleValue];
    NSString *poster = dictitionary[kPoster];
    
    return [self initMovieWithTitle:title overview:overview rating:rating poster:poster];
}

@end
