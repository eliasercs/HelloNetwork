import 'dart:async';

class StreamSocket {
  final _activeUsers = StreamController<dynamic>.broadcast();
  final _socketResponse = StreamController<dynamic>.broadcast();
  final _chatStream = StreamController<List<Map<String, dynamic>>>.broadcast();
  final List<Map<String, dynamic>> _chats = [];

  void addResponse(dynamic data) {
    //_chats.add(data);
    //_chatStream.sink.add(_chats);
    _socketResponse.sink.add(data);
  }

  void updateActiveUsers(data) {
    _activeUsers.sink.add(data["data"]);
    //print(_activeUsers.stream.toList());
  }

  Stream<dynamic> get getActiveUsers => _activeUsers.stream;

  Stream<dynamic> get getResponse => _socketResponse.stream;
  Stream<List<Map<String, dynamic>>> get getChats => _chatStream.stream;

  void dispose() {
    _activeUsers.close();
    _socketResponse.close();
    _chatStream.close();
  }
}
