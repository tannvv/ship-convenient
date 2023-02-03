import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:get/get.dart';

class FeedbackForDeliverController extends BaseController {
  String? customerTripId;
  String? driverId;
  Rx<String?> photoUrl = ''.obs;
  Rx<String?> gender = ''.obs;
  bool backToHome = false;

  @override
  Future<void> onInit() async {
    var data = Get.arguments as Map<String, dynamic>;

    // if (data.containsKey('customerTripId')) {
    //   customerTripId = data['customerTripId'];
    // }
    // if (data.containsKey('driverId')) {
    //   driverId = data['driverId'];
    // }
    // if (data.containsKey('photoUrl')) {
    //   photoUrl.value = data['photoUrl'];
    // }
    // if (data.containsKey('gender')) {
    //   gender.value = data['gender'];
    // }
    // if (data.containsKey('backToHome')) {
    //   backToHome = data['backToHome'];
    // }

    super.onInit();
  }

  Rx<int> feedBackPoint = 0.obs;

  void changePoint(int point) {
    feedBackPoint.value = point;
  }

  Rx<String> feedBackEmotion = ''.obs;
  Rx<String> feedBackMessage = ''.obs;

  void changeFeedBackEmotion(String value) {
    feedBackEmotion.value = value;
  }

  void changeFeedBackMessage(String value) {
    feedBackMessage.value = value;
  }

  void submit() async {
    String content = '';
    if (feedBackEmotion.value.isNotEmpty && feedBackMessage.value.isNotEmpty) {
      content = '${feedBackEmotion.value}, ${feedBackMessage.value}';
    } else {
      content = '${feedBackEmotion.value}${feedBackMessage.value}';
    }
  }
}
