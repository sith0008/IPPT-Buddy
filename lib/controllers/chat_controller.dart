import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///Controller class which holds all functions to chat UI and messenger_home UI
class ChatController {
  /// Returns group chat id of the user and the peer
  static String getGroupChatID(String id, String peerId) {
    String groupChatId;

    //Returns null if id OR peerId is null
    if (id == null || peerId == null) {
      return null;
    }

    //Using hashCode to ensure that the groupChatId will be the same regardless of the sequence of
    //id and peerId
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }
    return groupChatId;
  }

  ///Generate new chat message in firebase
  static DocumentReference createChatMessageFirebase(String groupChatId) {
    return Firestore.instance
        .collection('chatMessages')
        .document(groupChatId)
        .collection(groupChatId)
        .document(DateTime.now().millisecondsSinceEpoch.toString());
  }

  ///Generate new group chat message in firebase
  static void createGroupChatMessageFirebase(
      String txt, String groupName, String userName, String photoURL) {
    DocumentReference documentReference = Firestore.instance
        .collection('groupChats')
        .document(groupName)
        .collection('messages')
        .document(DateTime.now().millisecondsSinceEpoch.toString());
    Map<String, String> profilesData = <String, String>{
      "displayName": userName,
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "photoURL": photoURL,
      "content": txt,
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString()
    };
    documentReference.setData(profilesData, merge: true).whenComplete(() {
      print("message added");
    }).catchError((e) => print(e));
  }

  ///Upload all details of message to chat message
  static void addMessageDetails(DocumentReference documentReference, String id,
      String peerId, String content, int type) {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        {
          'idFrom': id,
          'idTo': peerId,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'content': content,
          'type': type
        },
      );
    });
  }

  ///Check if last message is sent by peer
  ///Returns boolean true/false
  static bool isLastMessageLeft(int index, var listMessage, String id) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  ///Checks if last message is sent by user
  static bool isLastMessageRight(int index, var listMessage, String id) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  ///Get the latest 20 messages from firestore
  static Stream<QuerySnapshot> getChatMessageSnapshot(groupChatId) {
    return Firestore.instance
        .collection('chatMessages')
        .document(groupChatId)
        .collection(groupChatId)
        .orderBy('timestamp', descending: true)
        .limit(20)
        .snapshots();
  }

  ///Get list of chatusers user is linked to
  ///Shows chat user which the users added in matchMe
  static Stream<QuerySnapshot> getChatuserList(String id) {
    return Firestore.instance
        .collection('users')
        .document(id)
        .collection('chatUsers')
        .snapshots();
  }

  ///Get group chat messages from firestore
  static Stream<QuerySnapshot> getGroupChatMessages(String groupName) {
    return Firestore.instance
        .collection('groupChats')
        .document(groupName)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(20)
        .snapshots();
  }

  static List<DocumentSnapshot> databaseDocuments;

  ///Get all users
  static readAllUsers(String id) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .getDocuments();
    databaseDocuments = result.documents;
  }

  static String getName(String id) {
    readAllUsers(id);
    return databaseDocuments[0]['name'];
  }

  static String getImage(String id) {
    readAllUsers(id);
    return databaseDocuments[0]['imageURL'];
  }

  ///Get image asset
  static getImageAsset(String imageAsset, double width, double height) {
    return new Image.asset(
      imageAsset,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
