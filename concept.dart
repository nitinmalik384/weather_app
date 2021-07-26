void main() async {
  task1();
  String a = await task2();
  task3(a);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future task2() async {
  Duration duration = Duration(seconds: 5);
  String result;
  await Future.delayed(duration, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String a) {
  String result = 'task 3 data with $a';
  print(result);
}
