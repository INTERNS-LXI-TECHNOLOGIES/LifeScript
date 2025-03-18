import 'dart:collection';

void main(){

//fixed-length list.
final fixedLengthListt = List<int>.filled(5,0);
print(fixedLengthListt);

fixedLengthListt[0]=55;
print(fixedLengthListt);
//fixedLengthListt.setAll(0,[5,4]);
fixedLengthListt.setAll(1,[5,4]);
print(fixedLengthListt);

//below throws exception
// fixedLengthListt.length=0;
// fixedLengthListt.add(20);
print('------------------------------------');

final growableListt= <String>['A','Z','P','Q'];

growableListt[0]='R';
print(growableListt);
growableListt.add('W');
print(growableListt);
growableListt.addAll({'T','Y'});
print(growableListt);
print('------------------------------------');

final aIndex= growableListt.indexOf('W');
print (aIndex);//the result is -1 if the indexof value is not in the List
final BIndex = growableListt.lastIndexOf('R');
print (BIndex);
print('------------------------------------');

growableListt.remove('R');
print(growableListt);
growableListt.removeAt(0);
print(growableListt);
growableListt.removeLast();
print(growableListt);
growableListt.removeRange(1, 3);
print(growableListt);
growableListt.removeWhere((r)=>r.length==2);
print(growableListt);
print('------------------------------------');

growableListt.insert(2, 'insert');
print(growableListt);
growableListt.insertAll(0, {'InsertAll1','InsertAll2'});
print(growableListt);
print('------------------------------------');

growableListt.replaceRange(0, 3, {'Replaced1','Replaced2'});
print(growableListt);
growableListt.fillRange(3, 4, 'Filled');
print(growableListt);
growableListt.setRange(0, 2, {'Set1','Set2','Set3'},1);// the 1 is the skip argument that will skip the 1st possition of the {'Set1','Set2','Set3'}
print(growableListt);
print('------------------------------------');

growableListt.sort();
print(growableListt);
growableListt.sort((a,b)=> b.compareTo(a));//decending order
print(growableListt);
print('------------------------------------');

growableListt.shuffle();
print(growableListt);
print('------------------------------------');

final numbers = <int>[1, 2, 3, 4, 5, 6, 7];
var result = numbers.firstWhere((f)=> f>3);//the 3 is in the list where its first number of the list is 1 which is the firstwhere 
print(result);

print('------------------Constructors------------------');

final share = List.filled(4, []);
share[0].add(50);
print(share);
print('------------------------------------');

final unique = List.generate(5,(_)=>[]);
unique[0].add(100);
print(unique);
print('------------------------------------');

final digits = <int>[1, 2, 3];
final listOf = List<num>.of(digits);
print(listOf);
print('------------------------------------');

final values = <int>[1, 2, 3, 4, 5, 6, 7];
final unmodifiable= List.unmodifiable(values);
print(unmodifiable);
// unmodifiable[1]=10;
// //print(unmodifiable);

print('------------------Methods------------------');

final mNumber = <int> [1,2,3,4,5,6,7,8,9,10];
mNumber.add(11);
print(mNumber);

mNumber.addAll({12,13});
print(mNumber);
print('------------------------------------');

var value1 =mNumber.any((any)=> any>5);
print(value1);
var value2= mNumber.any((any)=>any>50);
print(value2);
print('------------------------------------');

var alphabets = <String>['A','B','C','D','E'];
var mapResult = alphabets.asMap();
print(mapResult);
print('------------------------------------');

final cNumbers = <int>[1, 2, 3];
cNumbers.clear();
print(cNumbers.length);
print(cNumbers);
print('------------------------------------');

final gasPlanets = <int, String>{1: 'Jupiter', 2: 'Saturn'};
var containsResult1= gasPlanets.containsKey(5);
var containsResult2= gasPlanets.containsValue('Jupiter');
print(containsResult1);
print(containsResult2);
print('------------------------------------');

final elementNumbers = <int>[1, 2, 3, 5, 6, 7];
final elementAt1 = elementNumbers.elementAt(5);
final elementAt2 = elementNumbers.elementAtOrNull(4);
final elementAt3 = elementNumbers.elementAtOrNull(8);
print(elementAt1);
print(elementAt2);
print(elementAt3);
print('------------------------------------');

final everyNum = <int,String>{1:'A',2:'B',3:'C'};
final everyResult1 = everyNum.keys.every((k)=> k<5);// Checks whether all keys are smaller than 5.
final everyResult2 = everyNum.keys.every((k)=> k>7);// Checks whether all keys are greater than 7.
print(everyResult1);
print(everyResult2);
print('------------------------------------');

final foldNumbers= <int> [1,2,3,4];
var folresult= foldNumbers.fold(0,(a,b)=> a+b);
print(folresult); 
final f2numbers = <double>[10, 2, 5, 0.5];
final fresult = f2numbers.fold<double>(
    15, (p, e) => p + e);
print(fresult); 
print('------------------------------------');




}