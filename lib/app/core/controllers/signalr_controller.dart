import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/config/build_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalR extends BaseController {
  static final SignalR _instance = SignalR._internal();
  static SignalR get instance => _instance;
  SignalR._internal();

  late HubConnection connection;

  final Logger _logger = Logger('SignalR: ');

  final delayTime = 1;
  bool autoReconnect = false;
  bool _onReconnect = false;
  bool _autoReconnect = false;

  Rx<HubConnectionState> hubState = HubConnectionState.Disconnected.obs;
  final String _hubUrl = '${BuildConfig.instance.config.baseUrlOrigin}/chat';

  @override
  void onInit() {
    start();
    super.onInit();
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }

  void start() async {
    if (hubState.value == HubConnectionState.Connected) return;
    _autoReconnect = true;
    _retryUntilSuccessfulConnection();
  }

  void stop() {
    _autoReconnect = false;
    try {
      connection.stop();
    } catch (e) {
      debugPrint('Exception stop SignalR: $e');
    }
  }

  Future<void> _openConnection() async {
    var token = AuthController.instance.token;

    final httpConnectionOptions = HttpConnectionOptions(
        logger: _logger,
        logMessageContent: true,
        accessTokenFactory: () async {
          return token ?? '';
        });

    connection = HubConnectionBuilder()
        .withUrl(
          _hubUrl,
          options: httpConnectionOptions,
        )
        .withAutomaticReconnect(retryDelays: [1000])
        .configureLogging(_logger)
        .build();

    connection.onclose(({error}) {
      debugPrint('Mất kết nối đến server');
      _retryUntilSuccessfulConnection();

      changeState(HubConnectionState.Disconnected);
    });
    connection.onreconnecting(({error}) {
      debugPrint("SignalR: Onreconnecting called");

      changeState(HubConnectionState.Disconnected);

      connection.stop();
      _retryUntilSuccessfulConnection();
    });
    connection.onreconnected(({connectionId}) {
      debugPrint("SignalR: onreconnected called");

      changeState(HubConnectionState.Connected);
    });

    if (connection.state != HubConnectionState.Connected) {
      await connection.start();
      hubState.value = HubConnectionState.Connected;
    }

    _listen();
  }

  void _retryUntilSuccessfulConnection() async {
    if (hubState.value == HubConnectionState.Connected) return;
    if (_onReconnect) return;
    _onReconnect = true;

    while (true) {
      try {
        await _openConnection();

        if (connection.state == HubConnectionState.Connected) {
          debugPrint('SignalR: Kết nối thành công');
          Account? account = AuthController.instance.account;
          if (account != null) {
            connection.invoke('RegisterUser', args: [account.id!, 'SHIPPER']);
          }
          _onReconnect = false;
          return;
        }
      } catch (e) {
        if (!_autoReconnect) return;
        debugPrint('SignalR: Kết nối tới server thất bại');
      }

      await Future.delayed(Duration(seconds: delayTime));
      debugPrint('SignalR: Đang kết nối lại');
    }
  }

  void _listen() {
    connection.on("MessageReceive", _messageReceive);
  }

  void _messageReceive(List<Object?>? parameters) {
    debugPrint("Message asp.net core: ${parameters?[0]}");
  }

  void changeState(HubConnectionState value) {
    hubState.value = value;
  }
}
