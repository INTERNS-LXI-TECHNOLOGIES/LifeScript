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
print('------------------------------------');








}