import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MotionToastService {
  static void showSuccess(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: AppColors.softGreen,
        textColor: AppColors.white,
        fontSize: 16);
  }

  static void showError(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: AppColors.softRed,
        textColor: AppColors.white,
        fontSize: 16);
  }
}
