// ignore_for_file: file_names
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class GetImage {
  ImageSource imageSource;
  Function path;

  GetImage(this.imageSource, {required this.path(String imgPath, String imgName, XFile pickedFile)}) {
    getImage();
  }

  Future getImage() async {
    var pickedFile = await ImagePicker().pickImage(source: imageSource, imageQuality: 100);

    if (pickedFile != null) {
      log('imgFile path: ${pickedFile.path}');
      path(pickedFile.path, pickedFile.name, pickedFile);
    }
  }
}

class GetMultipleImage {
  Function path;

  GetMultipleImage({required this.path(List<XFile> pickedFiles)}) {
    getImage();
  }

  Future getImage() async {
    var pickedFile = await ImagePicker().pickMultiImage(imageQuality: 100);
    path(pickedFile);
  }
}
