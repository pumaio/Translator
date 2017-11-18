//
//  FavoriteTranslation.h
//  Translator
//
//  Created by MS on 18.11.2017.
//  Copyright © 2017 Personal Project. All rights reserved.
//

#import <Realm/Realm.h>

@interface FavoriteTranslation : RLMObject

@property NSString *originalText;
@property NSString *translatedText;

@end
