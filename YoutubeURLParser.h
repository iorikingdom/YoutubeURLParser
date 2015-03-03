#import <Foundation/Foundation.h>

@interface YoutubeURLParser : NSObject

+(BOOL)isValidateYoutubeURL:(NSString * )youtubeURL;

+(NSArray *)parseURL:(NSString *)html ;

@end

