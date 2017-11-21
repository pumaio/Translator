//
//  TranslationTransport.m
//  Translator
//
//  Created by MS on 17.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import "TranslationTransport.h"

NSString *const TranslateURLString = @"/api/v1.5/tr.json/translate";

NSString *const langParam = TranslationLanguages;

@implementation TranslationTransport

- (void)translateText:(NSString *)text
                                success:(void (^)(NSDictionary *translationJSON))success
                                failure:(void (^)(NSString *errorMessage))failure {
    NSString *url = [self translateURL];
    
    NSString *bodyString = [NSString stringWithFormat:@"text=%@", text];
    NSData *postData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [self postRequestWithURL:url parameters:nil];
    [request setHTTPBody:postData];
    
    [[self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                success(responseObject);
            }
        } else {
            failure(error.localizedDescription);
        }
    }] resume];
}

#pragma mark - Helpers Methods

- (NSString *)translateURL {
    NSString *urlStringWithParams = [TranslateURLString stringByAppendingString:[NSString stringWithFormat:@"?key=%@&lang=%@", [self apiKey], langParam]];
    NSString *url = [BaseURL stringByAppendingString:urlStringWithParams];
    return url;
}

- (NSMutableURLRequest *)postRequestWithURL:(NSString *)url parameters:(id)parameters {
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
    request.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    return request;
}

- (NSString *)apiKey {
    return [[NSBundle mainBundle] infoDictionary][@"YandexTranslationApiKey"];
}

@end
