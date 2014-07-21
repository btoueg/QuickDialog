//
//  QTakePhotoElement.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 16/07/2014.
//
//

#import "QTakePhotoElement.h"

#define green_color [UIColor colorWithRed:0.373 green:0.878 blue:0.471 alpha:1]
const NSString *kInitTakeTitle = @"Prendre photo";

@implementation QTakePhotoElement

- (QTakePhotoElement *)init
{
    self = [super init];
    if (self) {
        _photoData = [[MEPhotoDataItem alloc] init];
        _photoData.takeTitle = [NSString stringWithFormat:@"%@",kInitTakeTitle];
        self.appearance = [self.appearance copy];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformPhotoElement"];
    if (cell == nil){
        cell = [[QTableViewCell alloc] initWithReuseIdentifier:@"QuickformPhotoElement"];
    }
    [cell applyAppearanceForElement:self];

    cell.textLabel.text = _photoData.isPhotoTaken ? _photoData.previewTitle : _photoData.takeTitle;
    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if (_photoData.isPhotoTaken) {
        //show the photo to the user
        QPhotoViewController *vc = [[QPhotoViewController alloc] initWithPhotoData:_photoData type:PhotoSourceCamera];
        vc.element = self;
        [controller.navigationController pushViewController:vc animated:YES];
    } else {
        //take a new picture
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        [controller presentViewController:picker animated:YES completion:nil];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _photoData.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _photoData.metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
    _photoData.isPhotoTaken = YES;

    [self.appearance setBackgroundColorEnabled:green_color];
    [picker dismissViewControllerAnimated:YES completion:^{
        [[(QuickDialogController *)self.controller quickDialogTableView] reloadCellForElements:self, nil];
    }];
}

@end
