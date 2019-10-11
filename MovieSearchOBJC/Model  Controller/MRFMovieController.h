//
//  MRFMovieController.h
//  MovieSearchOBJC
//
//  Created by Michael Flowers on 10/11/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRFMovie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MRFMovieController : NSObject
//Create data source of truth
@property NSArray<MRFMovie *> *movies;

+ (MRFMovieController *)sharedInstance;

- (void)fetchMovieSearchTerm:(NSString *)searchTerm completion:(void (^) (BOOL))completion;

- (void)fetchPostImageWithMovie:(MRFMovie *)movie completion:(void (^) (UIImage * _Nullable ))completion;

@end

NS_ASSUME_NONNULL_END
