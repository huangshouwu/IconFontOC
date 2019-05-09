//
//  SGTIconFontManager.h
//  SGT
//
//  Created by huang shervin on 2019/5/8.
//  Copyright © 2019年 huang shervin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGTIconFontManager : NSObject

+ (void)configIconFont;
+ (NSString*)fontName;
+ (UIImage*)iconFontName:(NSString*)name size:(NSUInteger)size color:(UIColor*)color;
+ (NSString*)iconFontName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
