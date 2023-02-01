import 'package:ceos/core/services/subcollection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../services/api.dart';

class ChatViewModel {
  Api api = Api('chats');

  List<Chat> chats = [];
  Stream<QuerySnapshot> getChats(userId) {
    return SubApi("chats", "userChat", userId).streamDocuments();
  }

  Stream<DocumentSnapshot> getChatById(id, userId) {
    return SubApi("chats", "userChat", userId).streamDocumentById(id);
  }

  Future<bool> checkIfChatted(id, userId) async {
    var doc = await SubApi("chats", "userChat", userId).getDocumentById(id);
    return doc.exists;
  }

  sendMessage(Message text, chatId, userId, proId) async {
    var request =
        await SubApi("chats", "userChat", userId).getDocumentById(chatId);
    List? messages = request['messages'];
    messages?.add(text.toJson());
    SubApi("chats", "userChat", userId)
        .updateDocument("messages", messages, userId + proId)
        .then((value) {
      SubApi("chats", "userChat", proId)
          .updateDocument("messages", messages, proId + userId);
    });
  }

  beginChat(Chat data, userId, proId) {
    SubApi("chats", "userChat", proId)
        .setData(data.toJson(), proId + userId)
        .then((_) {
      SubApi("chats", "userChat", userId)
          .setData(data.toJson(), userId + proId);
    });
  }
}
