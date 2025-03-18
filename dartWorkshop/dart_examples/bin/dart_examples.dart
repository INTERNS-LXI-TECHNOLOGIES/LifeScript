import 'dart:math';

import 'package:dart_examples/dart_examples.dart' as dart_examples;

void main() {
  
  List<int> growableList = [10, 20, 30];
  print(growableList); 

  growableList.add(40);
  growableList.add(50);
  print(growableList); 

  
  growableList.remove(20);
  print(growableList); 

  growableList = growableList.sublist(0, 2);
  print(growableList);


  List<String> myList = ['X', 'Y']; 
  print(myList); 

  
  myList[1] = 'Z'; 
  print(myList); 

 
  myList.add('A');
  print(myList); 

  
  myList.addAll(['B', 'C']);
  print(myList); 

  myList.remove('Z');
  print(myList); 

 
  if (myList.length > 2) {
    myList.removeAt(2);
  }
  print(myList); 

 
  print(myList.length);  


   var aList = ['D', 'E', 'F', 'E', 'G'];

  
  print(aList.indexOf('E'));  
  print(aList.lastIndexOf('E')); 

  aList.remove('E');
  print(aList); 

 
  aList.removeLast();
  print(aList); 

   var bList = ['X', 'Y', 'Z', 'A', 'B'];

 
  bList.replaceRange(0, 2, ['M', 'N']);
  print(bList); 

  
  bList.fillRange(2, 4, 'P');
  print(bList); 

  bList.sort((a, b) => a.compareTo(b));
  print(bList); 


  bList.shuffle(Random());
  print(bList); 

  

}