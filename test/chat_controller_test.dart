import 'package:test/test.dart';
import 'package:ipptbuddy/controllers/chat_controller.dart';


///Unit testing of chat_controller class (whitebox testing)
void main(){

  String id = 'abc123';
  String peerId = '321cba';

  ///Testing generation of correct group chat ID
  test('The group chat ID generated should be \'321cba-abc123\'', (){
    expect(ChatController.getGroupChatID(id, peerId), '321cba-abc123');
  });

  ///Testing when the params are reversed
  test('The group chat ID generated should be \'321cba-abc123\'', (){
    expect(ChatController.getGroupChatID(peerId, id), '321cba-abc123');
  });

  ///Testing when the params are invalid
  test('A null input should return a null', () {
    expect(ChatController.getGroupChatID(null, peerId), null);
  });

  ///Testing when the params are invalid
  test('A null input should return a null', () {
    expect(ChatController.getGroupChatID(id, null), null);
  });

  ///Testing if false is returned when listMessage is null
  test('Should return false if listMessage is null.',(){
    expect(ChatController.isLastMessageLeft(1, null, id), false);
  });

  ///Testing if false is returned when listMessage is null
  test('Should return false if listMessage is null.',(){
    expect(ChatController.isLastMessageRight(1, null, id), false);
  });



}