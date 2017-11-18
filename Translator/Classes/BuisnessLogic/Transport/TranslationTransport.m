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

- (NSURLSessionDataTask *)translateText:(NSString *)text
                                success:(void (^)(NSDictionary *translationJSON))success
                                failure:(void (^)(NSString *errorMessage))failure {
    NSString *url = [TranslateURLString stringByAppendingString:[NSString stringWithFormat:@"?key=%@&lang=%@", [self apiKey], langParam]];
    NSDictionary *params = @{@"text" : text};
    return [self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

- (NSString *)apiKey {
    return [[NSBundle mainBundle] infoDictionary][@"YandexTranslationApiKey"];
}

@end
