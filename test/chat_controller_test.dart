import 'package:test/test.dart';
import 'package:ipptbuddy/pages/chat_controller.dart';


///Unit testing of chat_controller class (whitebox testing)
void main(){

  String id = 'abc123';
  String peerId = '321cba';
  ChatController cc = new ChatController();

  ///Testing generation of correct group chat ID
  test('The group chat ID generated should be \'321cba-abc123\'', (){
    expect(cc.getGroupChatID(id, peerId), '321cba-abc123');
  });

  ///Testing when the params are reversed
  test('The group chat ID generated should be \'321cba-abc123\'', (){
    expect(cc.getGroupChatID(peerId, id), '321cba-abc123');
  });

  ///Testing when the params are invalid
  test('A null input should return a null', () {
    expect(cc.getGroupChatID(null, peerId), null);
  });

  ///Testing when the params are invalid
  test('A null input should return a null', () {
    expect(cc.getGroupChatID(id, null), null);
  });

  ///Testing if false is returned when listMessage is null
  test('Should return false if listMessage is null.',(){
    expect(cc.isLastMessageLeft(1, null, id), false);
  });

  ///Testing if false is returned when listMessage is null
  test('Should return false if listMessage is null.',(){
    expect(cc.isLastMessageRight(1, null, id), false);
  });



}