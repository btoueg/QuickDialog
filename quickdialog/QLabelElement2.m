//
// Copyright 2011 ESCOZ Inc  - http://escoz.com
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "QLabelElement2.h"
#import "QuickDialog.h"

@implementation QLabelElement2

- (QLabelElement2 *)init {
    self = [super init];
    if (self){
    }
    return self;
}

- (QLabelElement2 *)initWithTitle:(NSString *)title Value:(NSString *)value Placeholder:(NSString *)placeholder {
    self = [self init];
    if (self) {
        _title = title;
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    
    self.controller = controller;
    
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformsdfsdfEntryElement"];
    if (cell==nil){
        cell = [[QTableViewCell alloc] init];
    }
    
    [cell applyAppearanceForElement:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"hello";
    cell.imageView.image = self.image;
//    [cell prepareForElement:self inTableView:tableView];
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    [super selected:tableView controller:controller indexPath:indexPath];
    
}


@end
