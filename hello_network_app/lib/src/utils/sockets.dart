import 'dart:async';

class StreamSocket {
  final _socketResponse = StreamController<Map<String, dynamic>>.broadcast();
  final _chatStream = StreamController<List<Map<String, dynamic>>>.broadcast();
  final List<Map<String, dynamic>> _chats = [];

  void addResponse(Map<String, dynamic> data) {
    print(data);
    _chats.add(data);
    _chatStream.sink.add(_chats);
    _socketResponse.sink.add(data);
  }

  Stream<Map<String, dynamic>> get getResponse => _socketResponse.stream;
  Stream<List<Map<String, dynamic>>> get getChats => _chatStream.stream;

  void dispose() {
    _socketResponse.close();
    _chatStream.close();
  }
}
