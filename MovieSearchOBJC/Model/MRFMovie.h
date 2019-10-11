//
//  MRFMovie.h
//  MovieSearchOBJC
//
//  Created by Michael Flowers on 10/11/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRFMovie : NSObject
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, copy, readonly, nullable) NSString *poster;
@property (nonatomic, readonly) double rating;

- (instancetype)initMovieWithTitle:(NSString *)title overview:(NSString *)overview rating:(double)rating poster:(NSString *)poster;

@end


@interface MRFMovie (JSONConvertable)
-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictitionary;

@end

NS_ASSUME_NONNULL_END
