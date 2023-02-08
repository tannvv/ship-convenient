import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/enum/payment_method.dart';
import 'package:convenient_way/app/core/model/payment_result.dart';
import 'package:convenient_way/app/core/utils/motion_toast_service.dart';
import 'package:convenient_way/app/data/repository/transaction_req.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class VnpayController extends BaseController {
  late final WebViewController _controller;
  var initialUrl = '';
  var firstLoad = true.obs;

  WebViewController get webViewController => _controller;
  final TransactionReq _transRepo = Get.find(tag: (TransactionReq).toString());
  @override
  void onInit() {
    initialUrl += Get.arguments['initialUrl'];
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              stopLoading();
            }
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(
                '''Page resource error:\n code: ${error.errorCode}\ndescription: 
                ${error.description}\nerrorType: ${error.errorType}\nisForMainFrame: ${error.isForMainFrame}''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(
                'https://ship-convenient.azurewebsites.net/api/v1.0/vnpay/payment-result')) {
              debugPrint('blocking navigation to ${request.url}');
              paymentReturn(request.url);
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          MotionToastService.showInfo(message.message);
        },
      )
      ..loadRequest(Uri.parse(initialUrl));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    _controller = controller;

    super.onInit();
  }

  Future<void> paymentReturn(String url) async {
    Uri uri = Uri.parse(url);

    PaymentResult paymentResult = PaymentResult.fromString(
      uid: uri.queryParameters['transactionId'],
      status: uri.queryParameters['status'],
      amount: int.parse(uri.queryParameters['amount'] ?? '0'),
      createdDate: uri.queryParameters['createDate'],
      source: PaymentMethod.vnpay,
    );

    Get.offAllNamed(
      Routes.PAYMENT_STATUS,
      arguments: {
        'paymentResult': paymentResult,
      },
    );
  }

  void stopLoading() {
    firstLoad.value = false;
  }
}
