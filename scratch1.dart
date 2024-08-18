// late int i;
//
// void main() {
//   for (i = 99; i > 1; i--) {
//     print('$i bottles of beer on the wall, $i bottles of beer.\n'
//         'Take one down and pass it around, ${i - 1} bottles of beer on the wall.\n');
//   }
//   print('$i bottles of beer on the wall, $i bottles of beer.\n'
//       'Take one down and pass it around, no bottles of beer on the wall.\n');
// }
//

List<int> winningNumbers = [12, 6, 34, 22, 41, 9];

void main() {
  List<int> ticket1 = [45, 2, 9, 18, 12, 33];
  List<int> ticket2 = [41, 17, 26, 32, 7, 35];

  checkNumbers(ticket2);
}

void checkNumbers(List<int> myNumbers) {
  int numberOfMatchingNumbers = 0;
  for (int myNumber in myNumbers) {
    for (int winningNumber in winningNumbers) {
      if (myNumber == winningNumber) {
        numberOfMatchingNumbers++;
      }
    }
  }
  print('You have $numberOfMatchingNumbers matching numbers.');
}
