//
//  TranslationTransport.m
//  Translator
//
//  Created by MS on 17.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import "TranslationTransport.h"

NSString *const TranslateURLString = @"/api/v1.5/tr.json/translate";

NSString *const langParam = @"ru-en";

@implementation TranslationTransport

- (void)translateText:(NSString *)text
                                success:(void (^)(NSDictionary *translationJSON))success
                                failure:(void (^)(NSString *errorMessage))failure {
    NSString *urlStringWithParams = [TranslateURLString stringByAppendingString:[NSString stringWithFormat:@"?key=%@&lang=%@", [self apiKey], langParam]];
    NSString *url = [BaseURL stringByAppendingString:urlStringWithParams];
    
    NSString *postDataString = [NSString stringWithFormat:@"text=%@", text];
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[postDataString dataUsingEncoding:NSUTF8StringEncoding]];

    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    request.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
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

- (NSString *)apiKey {
    return [[NSBundle mainBundle] infoDictionary][@"YandexTranslationApiKey"];
}

@end
