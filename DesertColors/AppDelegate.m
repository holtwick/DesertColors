//
//  AppDelegate.m
//  DesertColors
//
//  Created by Dirk Holtwick on 25.09.18.
//  Copyright © 2018 Dirk Holtwick. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSArray *colorNames = @[ @"systemBlueColor",
                             @"systemBrownColor",
                             @"systemGrayColor",
                             @"systemGreenColor",
                             @"systemOrangeColor",
                             @"systemPinkColor",
                             @"systemPurpleColor",
                             @"systemRedColor",
                             @"systemYellowColor",
                             @"clearColor",
                             @"blackColor",
                             @"blueColor",
                             @"brownColor",
                             @"cyanColor",
                             @"darkGrayColor",
                             @"grayColor",
                             @"greenColor",
                             @"lightGrayColor",
                             @"magentaColor",
                             @"orangeColor",
                             @"purpleColor",
                             @"redColor",
                             @"whiteColor",
                             @"yellowColor",
                             
                             //
                             
                             @"labelColor",
                             @"secondaryLabelColor",
                             @"tertiaryLabelColor",
                             @"quaternaryLabelColor",
                             @"textColor",
                             @"placeholderTextColor",
                             @"selectedTextColor",
                             @"textBackgroundColor",
                             @"selectedTextBackgroundColor",
                             @"keyboardFocusIndicatorColor",
                             @"unemphasizedSelectedTextColor",
                             @"unemphasizedSelectedTextBackgroundColor",
                             @"linkColor",
                             @"separatorColor",
                             @"selectedContentBackgroundColor",
                             @"unemphasizedSelectedContentBackgroundColor",
                             @"selectedMenuItemTextColor",
                             @"gridColor",
                             @"headerTextColor",
                             // @"alternatingContentBackgroundColors",
                             @"controlAccentColor",
                             @"controlColor",
                             @"controlBackgroundColor",
                             @"controlTextColor",
                             @"disabledControlTextColor",
                             @"selectedControlColor",
                             @"selectedControlTextColor",
                             @"alternateSelectedControlTextColor",
                             @"scrubberTexturedBackgroundColor",
                             @"windowBackgroundColor",
                             @"windowFrameTextColor",
                             @"underPageBackgroundColor",
                             @"findHighlightColor",
                             @"highlightColor",
                             @"shadowColor",
                             //                             @"alternateSelectedControlColorDeprecated",
                             //                             @"controlAlternatingRowBackgroundColorsDeprecated",
                             //                             @"controlHighlightColorDeprecated",
                             //                             @"controlLightHighlightColorDeprecated",
                             //                             @"controlShadowColorDeprecated",
                             //                             @"controlDarkShadowColorDeprecated",
                             //                             @"headerColorDeprecated",
                             //                             @"knobColorDeprecated",
                             //                             @"selectedKnobColorDeprecated",
                             //                             @"scrollBarColorDeprecated",
                             //                             @"secondarySelectedControlColorDeprecated",
                             //                             @"selectedMenuItemColorDeprecated",
                             //                             @"windowFrameColorDeprecated",
                             ];


    NSAppearanceName appearanceName = [NSApp.effectiveAppearance bestMatchFromAppearancesWithNames:@[NSAppearanceNameAqua, NSAppearanceNameDarkAqua]];
    BOOL isDark = [appearanceName isEqualToString:NSAppearanceNameDarkAqua];

    NSMutableArray *cssLines = [NSMutableArray array];
    NSMutableArray *lessLines = [NSMutableArray array];
    NSMutableArray *jsLines = [NSMutableArray array];
    for (NSString *name in colorNames) {
        NSColor *color = [NSColor performSelector:NSSelectorFromString(name)];
        if (color) {
            NSLog(@"Color %@: %@", name, color);
            color = [color colorUsingColorSpace:[NSColorSpace sRGBColorSpace]];
            NSString *rgba = [NSString stringWithFormat:@"rgba(%.0f, %.0f, %.0f, %.3f)",
                              round(255 * color.redComponent),
                              round(255 * color.greenComponent),
                              round(255 * color.blueComponent),
                              color.alphaComponent];
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z]" options:0 error:nil];

            NSMutableString *cssname = [NSMutableString stringWithString:name];
            [regex replaceMatchesInString:cssname
                                  options:0
                                    range:NSMakeRange(0, name.length)
                             withTemplate:@"-$0"];
            [cssLines addObject:[NSString stringWithFormat:@"  --%@: %@;", cssname.lowercaseString, rgba]];

            id lessName = [NSString stringWithFormat:@"%@%@", [name substringToIndex:1].capitalizedString, [name substringFromIndex:1]];
            [lessLines addObject:[NSString stringWithFormat:@"  @%@%@: %@;", isDark ? @"dark" : @"light", lessName, rgba]];

            [jsLines addObject:[NSString stringWithFormat:@"  %@: '%@',", name, rgba]];
        }
        else {
            NSLog(@"Unknown color: %@", name);
        }
    }
    NSLog(@"CSS:\n%@", [cssLines componentsJoinedByString:@"\n"]);
    NSLog(@"LESS:\n%@", [lessLines componentsJoinedByString:@"\n"]);
    NSLog(@"JS:\n%@", [jsLines componentsJoinedByString:@"\n"]);
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



@end
