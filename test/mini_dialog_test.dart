import 'package:flutter_test/flutter_test.dart';

void main() {
  test('String', () {
    String a = "你好asb1231好";
    String s = '好';
    String _a = a.toLowerCase();
    // List<int> al = _a.codeUnits;
    String _s = s.toLowerCase();
    // List<int> sl = _s.codeUnits;
    print(_a);
    print(_s);
    int alength = _a.length;
    int slength = _s.length;
    int start = 0;
    for (int i = 0; i < alength; i++) {
      if (_a.codeUnitAt(i) == _s.codeUnitAt(0) &&
          i + slength <= alength &&
          _a.substring(i, slength + i) == _s) {
        print("c=${[start, i - 1]}");
        print("i=${[i, i + slength]}");
        i = i + slength;
        start = i;
      }
    }
  });
}
