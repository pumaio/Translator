//
//  TranslationService.h
//  Translator
//
//  Created by MS on 17.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FavoriteTranslation;
@class RLMResults;

@interface TranslationService : NSObject

- (void)translateText:(NSString *)text
              success:(void (^)(NSString *translation))success
              failure:(void (^)(NSString *errorMessage))failure;

- (RLMResults *)getAllFavorites;

- (void)saveTranslationWithOriginalText:(NSString *)originalText
                         translatedText:(NSString *)translatedText;

- (void)deleteTranslation:(FavoriteTranslation *)translation;


@end
