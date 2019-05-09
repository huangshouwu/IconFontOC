//
//  SGTIconFontManager.m
//  SGT
//
//  Created by huang shervin on 2019/5/8.
//  Copyright © 2019年 huang shervin. All rights reserved.
//

#import "SGTIconFontManager.h"
#import "TBCityIconFont.h"
#import "TFHpple.h"

static SGTIconFontManager *_manager = nil;

@interface SGTIconFontManager ()

@property (nonatomic,strong)NSDictionary* iconFontDictionary;

@end

@implementation SGTIconFontManager

+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[SGTIconFontManager alloc] init];
    });
    return _manager;
}

+ (void)configIconFont{
    [TBCityIconFont setFontName:[SGTIconFontManager fontName]];
}

+ (NSString*)fontName{
    return @"iconfont";
}

+ (UIImage*)iconFontName:(NSString*)name size:(NSUInteger)size color:(UIColor*)color{
    return [UIImage iconWithInfo:TBCityIconInfoMake([self iconFontName:name], size, color)];
}

+ (NSString*)iconFontName:(NSString*)name{
    NSDictionary* dic = [[SGTIconFontManager manager] iconFontDictionary];
    if (dic != nil && dic.count > 0){
        return [dic objectForKey:name];
    }else {
        return @"";
    }
    return @"";
}

/** iconfont下载地址：https://www.iconfont.cn/collections/index?spm=a313x.7781069.1998910419.3 */
- (NSDictionary*)iconFontDictionary{
    if (!_iconFontDictionary) {
        _iconFontDictionary = [SGTIconFontManager iconFontDictionaryWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo_index" ofType:@"html"]]];
    }
    return _iconFontDictionary;
}

+ (NSDictionary*)iconFontDictionaryWithURL:(NSURL*)fileUrl {
    NSMutableDictionary* resultDic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSData* htmlData = [NSData dataWithContentsOfURL:fileUrl];
    if (htmlData) {
        TFHpple* htmlParser = [TFHpple hppleWithXMLData:htmlData];
        NSArray* result = [htmlParser searchWithXPathQuery:@"//div[@class='content unicode']"];
        
        if (result != nil && result.count > 0) {
            for (TFHppleElement* item in result){
                NSArray* subArray = [item childrenWithClassName:@"icon_lists dib-box"];
                if (subArray != nil && subArray.count > 0){
                    subArray = [subArray.firstObject childrenWithClassName:@"dib"];
                    for (TFHppleElement* subItem in subArray) {
                        NSArray* names = [subItem childrenWithClassName:@"name"];
                        NSArray* codes = [subItem childrenWithClassName:@"code-name"];
                        if (names != nil && codes != nil) {
                            NSString* name = [[[names objectAtIndex:0] firstChild] content];
                            NSString* code = [[[codes objectAtIndex:0] firstChild] content];
                            [resultDic setObject:[self UXxxxFrom:code] forKey:name];
                        }
                    }
                }
            }
        }
    }
    return resultDic;
}

/**
 将16进制数
 在线编码解码网址：http://bianma.55cha.com
 在线进制转换网址：http://tool.oschina.net/hexconvert/
 */
+ (NSString*)UXxxxFrom:(NSString*)xxx{
    if ([xxx containsString:@"#x"]) {
        NSString* tempXXX = [xxx stringByReplacingOccurrencesOfString:@"#x" withString:@""];
        tempXXX = [tempXXX stringByReplacingOccurrencesOfString:@";" withString:@""];
        
        long s_10 = strtoul(tempXXX.UTF8String, 0, 16);//16进制转10进制
        NSString* new_s = [self stringForIcon:(UTF32Char)s_10];
        
        return new_s;
    }else {
        return xxx;
    }
}

////////////////////////////////////////////////////////////////////////////////////////
//此处参考 http://www.it1352.com/853009.html
+(NSString *)stringForIcon:(UTF32Char)char32{
    if ((char32 & 0xFFFF0000) != 0){
        return [self stringFromUTF32Char:char32];
    }else
    return [self stringFromUTF16Char:(UTF16Char)(char32&0xFFFF)];
}

+(NSString *)stringFromUTF32Char:(UTF32Char)char32{
    char32 -= 0x10000;
    unichar highSurrogate = (unichar)(char32 >> 10); // leave the top 10 bits
    highSurrogate += 0xD800;
    unichar lowSurrogate = char32 & 0x3FF; // leave the low 10 bits
    lowSurrogate += 0xDC00;
    return [NSString stringWithCharacters:(unichar[]){highSurrogate, lowSurrogate} length:2];
}

+(NSString *)stringFromUTF16Char:(UTF16Char)char16{
    return [NSString stringWithCharacters:(unichar[]){char16} length:1];
}
////////////////////////////////////////////////////////////////////////////////////////

@end
