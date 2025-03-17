class ListOperations {
  List<int> numbers = [10, 20, 30, 40, 50];

  
  void addElement(int num) {
    numbers.add(num);
  }

  
  void removeElement(int num) {
    numbers.remove(num);
  }

 
  int getElement(int index) {
    return numbers[index];
  }

  
  bool containsElement(int num) {
    return numbers.contains(num);
  }

 
  int getLength() {
    return numbers.length;
  }

 
  List<int> reverseList() {
    return numbers.reversed.toList();
  }

  
  void sortList() {
    numbers.sort();
  }


  int sumOfElements() {
    return numbers.reduce((a, b) => a + b);
  }

  
  List<int> getEvenNumbers() {
    return numbers.where((num) => num % 2 == 0).toList();
  }

  
  void printList() {
    print(numbers);
  }

  List<int> multiplyElements(int factor) {
    return numbers.map((num) => num * factor).toList();
}


}

void main() {
  ListOperations listOps = ListOperations();

  listOps.addElement(60);
  listOps.removeElement(20);
  print("Element at index 2: ${listOps.getElement(2)}");
  print("Contains 30? ${listOps.containsElement(30)}");
  print("List length: ${listOps.getLength()}");
  print("Reversed list: ${listOps.reverseList()}");
  
  listOps.sortList();
  print("Sorted list: ${listOps.numbers}");
  
  print("Sum of elements: ${listOps.sumOfElements()}");
  print("Even numbers: ${listOps.getEvenNumbers()}");

  listOps.printList();
}
