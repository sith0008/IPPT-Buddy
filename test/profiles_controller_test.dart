import 'package:test/test.dart';
import 'package:ipptbuddy/controllers/profiles_controller.dart';

void main(){

  ///Testing if false is returned when any input is null
  test('Should return false if any input is null', (){
    expect(ProfilesController.fieldFilled(null, '12', '30', 'Silver', '40', '40', '26 3 2018'), false);
  });

  ///Testing if false is returned when any input is null
  test('Should return false if any input is null', (){
    expect(ProfilesController.fieldFilled('Peter', null, '30', 'Silver', '40', '40', '26 3 2018'), false);
  });

  ///Testing if false is returned when any input is null
  test('Should return false if any input is null', (){
    expect(ProfilesController.fieldFilled('Peter', '12', null, 'Silver', '40', '40', '26 3 2018'), false);
  });

  ///Testing if false is returned when any input is null
  test('Should return false if any input is null', (){
    expect(ProfilesController.fieldFilled('Peter', '12', '30', null, '40', '40', '26 3 2018'), false);
  });

  ///Testing if false is returned when any input is null
  test('Should return false if any input is null', (){
    expect(ProfilesController.fieldFilled('Peter', '12', '30', 'Silver', null, '40', '26 3 2018'), false);
  });

  ///Testing if false is returned when any input is null
  test('Should return false if any input is null', (){
    expect(ProfilesController.fieldFilled('Peter', '12', '30', 'Silver', '40', null, '26 3 2018'), false);
  });

  ///Testing if false is returned when any input is null
  test('Should return false if any input is null', (){
    expect(ProfilesController.fieldFilled('Peter', '12', '30', 'Silver', '40', '40', null), false);
  });

  ///Testing if true is returned when none of the inputs are null
  test('Should return true when no inputs is null', (){
    expect(ProfilesController.fieldFilled('Peter', '12', '30', 'Silver', '40', '40', '26 3 2018'), true);
  });

  ///Testing edge cases of user input for min & sec
  test('Should return false when input >= 60 or < 0', (){
    expect(ProfilesController.validSecMin('60'), false);
  });

  ///Testing edge cases of user input for min & sec
  test('Should return false when input >= 60 or < 0', (){
    expect(ProfilesController.validSecMin('-1'), false);
  });

  ///Testing edge cases of user input for min & sec
  test('Should return true when input < 60 or >= 0', (){
    expect(ProfilesController.validSecMin('0'), true);
  });

  ///Testing edge cases of user input for min & sec
  test('Should return false when input >= 60 or < 0', (){
    expect(ProfilesController.validSecMin('60'), false);
  });

  ///Testing edge cases of user input for min & sec
  test('Should return true when input < 60 or >= 0', (){
    expect(ProfilesController.validSecMin('59'), true);
  });

  ///Testing edge cases of user input for min & sec
  test('Should return true when input < 60 or >= 0', (){
    expect(ProfilesController.validSecMin('1'), true);
  });

  String sec = '30';
  String min = '13';
  ///Ensure that the timing generated is correct: 60*min + sec
  test('Should return correct timing according to 60*min + sec', (){
    expect(ProfilesController.findTiming(min, sec), '810');
  });

  ///Throws error when invalid input
  test('Should throw an error when there are invalid inputs',(){
    expect(() => ProfilesController.findTiming(min, 'aa'), throwsException);
  });

  ///Throws error when invalid input
  test('Should throw an error when there are invalid inputs',(){
    expect(() => ProfilesController.findTiming('aa', sec), throwsException);
  });

  ///Throws error when invalid input
  test('Should return normally when there are invalid inputs',(){
    expect(() => ProfilesController.findTiming(min, sec), returnsNormally);
  });


}

