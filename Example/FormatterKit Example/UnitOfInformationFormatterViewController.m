// UnitOfInformationFormatterViewController.m
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UnitOfInformationFormatterViewController.h"

#import "TTTUnitOfInformationFormatter.h"

enum {
    SIPrefixByteSectionIndex,
    SIPrefixBitSectionIndex,
    IECPrefixBitSectionIndex,
} UnitOfInformationFormatterViewControllerSectionIndexes;

enum {
    BytesRowIndex,
    KiloBytesRowIndex,
    MegaBytesRowIndex,
    GigaBytesRowIndex,
} UnitOfInformationFormatterViewControllerRowIndexes;

@implementation UnitOfInformationFormatterViewController

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }
    
    self.title = NSLocalizedString(@"Unit of Information Formatter", nil);
    
    return self;
}

+ (NSString *)formatterDescription {
    return NSLocalizedString(@"TTTUnitOfInformationFormatter transforms a number of bits or bytes and into a humanized representation, using either SI decimal or IEC binary unit prefixes.", nil);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case SIPrefixByteSectionIndex:
            return NSLocalizedString(@"SI Prefix Bytes", nil);
        case SIPrefixBitSectionIndex:
            return NSLocalizedString(@"SI Prefix Bits", nil);
        case IECPrefixBitSectionIndex:
            return NSLocalizedString(@"IEC Prefix Bits", nil);
        default:
            return nil;
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {    
    static TTTUnitOfInformationFormatter *_unitOfInformationFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _unitOfInformationFormatter = [[TTTUnitOfInformationFormatter alloc] init];
    });
    
    switch (indexPath.section) {
        case SIPrefixByteSectionIndex:
            [_unitOfInformationFormatter setDisplaysInTermsOfBytes:YES];
            [_unitOfInformationFormatter setUsesIECBinaryPrefixesForCalculation:NO];
            [_unitOfInformationFormatter setUsesIECBinaryPrefixesForDisplay:NO];
            break;
        case SIPrefixBitSectionIndex:
            [_unitOfInformationFormatter setDisplaysInTermsOfBytes:NO];
            [_unitOfInformationFormatter setUsesIECBinaryPrefixesForCalculation:NO];
            [_unitOfInformationFormatter setUsesIECBinaryPrefixesForDisplay:NO];
            break;
        case IECPrefixBitSectionIndex:
            [_unitOfInformationFormatter setDisplaysInTermsOfBytes:NO];
            [_unitOfInformationFormatter setUsesIECBinaryPrefixesForCalculation:YES];
            [_unitOfInformationFormatter setUsesIECBinaryPrefixesForDisplay:YES];
            break;
    }
    
    NSUInteger numberOfBits = 0;
    switch (indexPath.row) {
        case BytesRowIndex:
            numberOfBits = 416;
            break;
        case KiloBytesRowIndex:
            numberOfBits = 8660;
            break;
        case MegaBytesRowIndex:
            numberOfBits = 1605183;
            break;
        case GigaBytesRowIndex:
            numberOfBits = 1896176573;
            break;
    }

    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = [_unitOfInformationFormatter stringFromNumberOfBits:[NSNumber numberWithInteger:numberOfBits]];
}

@end
