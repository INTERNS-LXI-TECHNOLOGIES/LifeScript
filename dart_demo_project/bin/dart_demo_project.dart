
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
}
