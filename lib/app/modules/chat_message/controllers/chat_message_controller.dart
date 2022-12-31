import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as Types;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatMessageController extends GetxController {
  final _user = const Types.User(
      id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
      firstName: 'Tan',
      lastName: 'Nguyen',
      imageUrl:
          'https://blog.readyplayer.me/content/images/2022/10/rainer.jpeg');
  final _userChat = const Types.User(
      id: '82091008-a484-4a89-ae75-a22bf8d6f3ad',
      firstName: 'Tan',
      lastName: 'Nguyen',
      imageUrl:
          'https://blog.readyplayer.me/content/images/2022/10/rainer.jpeg');
  final RxList<Types.Message> messages = RxList<Types.Message>([]);
  int _page = 0;

  Types.User get user => _user;

  @override
  void onInit() {
    super.onInit();
  }

  void _addMessage(Types.Message message) {
    messages.insert(0, message);
  }

  void handleSendPressed(Types.PartialText message) {
    debugPrint('Message : ${message.text}');
    final textMessage = Types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = Types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void handleMessageTap(BuildContext _, Types.Message message) async {
    debugPrint('Handle message tab');
  }

  void handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = Types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  Future<void> handleEndReached() async {
    debugPrint('Handle end reached, Page: $_page');
    final uri = Uri.parse(
      'https://api.instantwebtools.net/v1/passenger?page=$_page&size=20',
    );
    final response = await http.get(uri);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;
    final messagesApi = data
        .map(
          (e) => Types.TextMessage(
            author: _user,
            id: e['_id'] as String,
            text: e['name'] as String,
          ),
        )
        .toList();
    messages.addAll(messagesApi);
    _page = _page + 1;
  }
}
