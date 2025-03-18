
// ignore_for_file: unused_element

void main(List<String> arguments) {

  List<int> numbers = [1, 2, 3, 4, 5];

  void addNumber(int num) => numbers.add(num);
  addNumber(6);
  print(numbers);

  void addMoreNumbers(List<int>  num) => numbers.addAll(num);
  addMoreNumbers([7 , 8 , 9]);
  print(numbers);

  insertValue(int index , int value) => numbers.insert(index, value);
  insertValue(0, 0);
  print(numbers);

  insertMultipleValues(int index , List<int> values) => numbers.insertAll(index, values);
  insertMultipleValues(10, [10 , 11 , 12]);
  print(numbers);

  removeNumber(int num) => numbers.remove(num);
  removeNumber(12);
  print(numbers);

  removeNumberAtIndex(int index) => numbers.removeAt(index);
  removeNumberAtIndex(11);
  print(numbers);

  removeLastNum() => numbers.removeLast();
  removeLastNum();
  print(numbers);

  removeOdd() => numbers.removeWhere((e) => e % 2 != 0);
  removeOdd();
  print(numbers);

  retainsEven() => numbers.retainWhere((e) => e % 2 == 0);
  retainsEven();
  print(numbers);

  removeValues() => numbers.clear();
  removeValues();
  print(numbers);


  List<String> values = ['apple' , 'orange' , 'banana' , 'grapes' , 'mango']; 

  findIndex(String value) => values.indexOf('banana');
  print(findIndex('banana'));

  /*findLastIndex( value) => values.lastIndexOf(value);
  print(findLastIndex('grapes'));*/

  containsValue(String value) => values.contains(value);
  print(containsValue('banana'));


  List<String> fixedList = List<String>.filled(3,'apple');
  print(fixedList);
  fixedList[0] = 'banana';
  print(fixedList);
   print(fixedList.length);

  List<String> fruits = ['apple' , 'orange' , 'banana' , 'grapes' , 'mango'];
  fruits.replaceRange(0, 2 , ['kiwi' , 'papaya', 'watermelon']);
  print(fruits);

  fruits.sort();
  print(fruits);

  fruits.shuffle();
  print(fruits);

  for(var fruit in fruits){
    print(fruit);
  }

  bool isVowel(String char) => 'aeiou'.contains(char);
  print(isVowel('a'));

  List<String> vowels = ['n' , 'p' , 'i' , 'm' , 'm'];

 final vowel = vowels.singleWhere(isVowel , orElse: () => 'No vowels found');
 print(vowel);


 List<int> number = [1 , 2, 3, 4, 5];
 number.where((e) => e.isOdd).forEach((e) =>print(e));

 for(var nums in number.toList()){   // empty list 
  number.remove(nums); 
 }

 print(number);

 List<String> names = ['anila','sruthi','sreeja','farsha','jenifer'];
 print(names.last);
 print(names.first);
 print(names.removeLast());
 print(names.removeAt(0));
 names.removeRange(0,2);

 print(names);

 names.addAll( ['amy', 'jack' ,'james','aby']);
 print(names);

 names.removeWhere((e) => e.startsWith('j')) ;
 print(names);

 
 print(names.contains('amy'));

print(names.elementAt(0)) ;

print(names.elementAtOrNull(3));

print(names.indexOf('amy' , 0)); // index startswith

print(names.indexWhere((e) => e.length >= 4 , 0));


print(names.lastIndexOf('amy' , 2));

print(names.lastIndexWhere((e) => e.endsWith('a') , 0));

print(names.firstWhere((e) => e.startsWith('a'), orElse: () => 'not found' ));

print(names.lastWhere((e) => e.length==3 , orElse: ()=> 'can not found'));


names.forEach((e) => print('hello $e'));

List<int> nums = [1,2,3,4,5];

Iterable<int> num = nums.map((e) => e*10);
print(num.toList());

Iterable<int> a = num.where((e) => e <= 20);
print(a);

List<dynamic> b = ['apple' , 2 , 'apple' , 'orange' , 4] ;
Iterable<String> c = b.whereType<String>();
print(c);

List<List<int>> nestedList = [[1,2,3], [5,6] , [9,8]];

Iterable<int> expandIt() => nestedList.expand((e)=>e);
print(expandIt());

List<String> words = ['Hello iam Butterfly','How are you','How old are you'];
Iterable<String> word =  words.expand((e) => e.split(''));
print(word);




}
