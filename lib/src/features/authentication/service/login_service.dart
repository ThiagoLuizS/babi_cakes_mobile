import '../../core/models/user/photo_google_sign.dart';

class LoginService {

  static getAndSetPhotoSign(PhotoGoogleSign photoGoogleSign, String photo, String email) async {
    if(photoGoogleSign.email != email) {
      PhotoGoogleSign.clear();
    }

    photoGoogleSign = PhotoGoogleSign(photo: photo, email: email);
    photoGoogleSign.save();
  }

  static clearPhotoSign(PhotoGoogleSign photoGoogleSign, String email) {
    if(photoGoogleSign.email != email) {
      PhotoGoogleSign.clear();
    }
  }

}