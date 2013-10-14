//
//  TTTLocalization.h
//  
//
//  Created by Alexandre Aybes on 10/14/13.
//
//

#ifndef _TTTLocalization_h
#define _TTTLocalization_h

#define TTTFormatterKitResourceBundleInBundle(bundle) [NSBundle bundleWithURL:[bundle URLForResource:@"FormatterKitResources" withExtension:@"bundle"]]
#define TTTResourceBundle TTTFormatterKitResourceBundleInBundle([NSBundle bundleForClass:[self class]])

#define TTTLocalizedString(key, comment) NSLocalizedStringFromTableInBundle(key, @"FormatterKit", TTTResourceBundle, comment)
#define TTTLocalizedStringInBundle(key, bundle, comment) NSLocalizedStringFromTableInBundle(key, @"FormatterKit", bundle, comment)
#define TTTLocalizedStringWithDefaultValue(key, comment, val) NSLocalizedStringWithDefaultValue(key, @"FormatterKit", TTTResourceBundle, val, comment)

#endif
