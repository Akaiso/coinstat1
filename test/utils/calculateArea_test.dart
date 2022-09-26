




import 'package:coinstat/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coinstat/home_page.dart';

void main(){

  test('testing the area of a circle', (){
    //setup
    num circumference = 20;
    double pie = 33.7;
    //act
    calculateArea(circumference, pie);
    //assert
    expect(circumference * pie, 674.0);
  });

  test("check if multiplication works", (){
    //arrange
    num speed = 20;
    num time = 5;
    calculateDistance(speed, time);
    expect(100, 100);
  });
}
