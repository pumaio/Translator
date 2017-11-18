//
//  BaseDataLoader.m
//  Translator
//
//  Created by MS on 17.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import "BaseDataLoader.h"

NSString *const BaseURLString = BaseURL;

@implementation BaseDataLoader

- (instancetype)init {
    self = [super initWithBaseURL:[NSURL URLWithString:BaseURLString] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer =  [AFJSONResponseSerializer serializer];
        [self setupHeaders];
    }
    return self;
}

- (void)setupHeaders {
    [self.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"content-type"];
}

@end
