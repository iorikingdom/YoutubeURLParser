#import "YoutubeURLParser.h"

@interface YoutubeURLParser () {
}

@end

@implementation YoutubeURLParser

#define YOUTUBE_PATTERN @"(https?://)?(www\\.)?(youtu\\.be/|youtube\\.com)?(/|/embed/|/v/|/watch\\?v=|/watch\\?.+&v=)([\\w_-]{11})(&.+)?"

+(NSRegularExpression *)regex {
    
    static NSRegularExpression * regex = nil;
    
    regex =     [NSRegularExpression regularExpressionWithPattern:YOUTUBE_PATTERN
                                                          options:NSRegularExpressionCaseInsensitive
                                                            error:nil];
    return regex;
}

+(BOOL) isValidateYoutubeURL:(NSString * )youtubeURL {
    NSInteger cnt = [[YoutubeURLParser regex] numberOfMatchesInString:youtubeURL
                                                              options:0
                                                                range:NSMakeRange(0, [youtubeURL length])];
    
    return cnt > 0 ? YES : NO;
}

typedef void (^matching_block_t)  (NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop);

+(NSArray *) parseURL:(NSString *)url {
    NSMutableArray * youtubeURLArray = [[NSMutableArray alloc] init];
    
    matching_block_t parseTask = ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange matchRange = [result range];
        NSRange youtubeKey = [result rangeAtIndex:5]; //the youtube key
        NSString * strKey = [url substringWithRange:youtubeKey] ;
        
        [youtubeURLArray addObject:strKey];
    };
    
    [[YoutubeURLParser regex] enumerateMatchesInString:url
                                            options:0
                                              range:NSMakeRange(0,[url length])
                                         usingBlock:parseTask ];
    
    return youtubeURLArray;
}

@end


