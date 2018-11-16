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

  String sec = '40';
  String min = '10';

  ///Should return normally if min and sec are valid
  test('Should return normally when there are invalid inputs',(){
    expect(() => ProfilesController.findTiming(min, sec), returnsNormally);
  });

  ///Throws error when invalid input
  test('Should throw an error when there are invalid inputs',(){
    expect(() => ProfilesController.findTiming(min, 'aaaa'), throwsException);
  });

  ///Throws error when invalid input
  test('Should throw an error when there are invalid inputs',(){
    expect(() => ProfilesController.findTiming('aaaaa', sec), throwsException);
  });
}

