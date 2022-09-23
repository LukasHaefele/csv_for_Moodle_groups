import 'dart:io';

bool dev = false;

void execute() {
  List l = [];
  File f = File('dat/input.txt');
  List<String> ls = f.readAsLinesSync();
  String groupName = '';
  String write = 'username,cohort1\n';
  int count = 0;
  int countf = 0;
  for (String s in ls) {
    s = s
        .toLowerCase()
        .replaceAll('ã¤', 'ae')
        .replaceAll('ã¼', 'ue')
        .replaceAll('ã¶', 'oe')
        .replaceAll('ã–', 'oe')
        .replaceAll('ãÿ', 'ss')
        .replaceAll('ć', 'c')
        .replaceAll('ž', 'z')
        .replaceAll('ß', 'ss')
        .replaceAll('é', 'e')
        .replaceAll('ä', 'ae')
        .replaceAll('ö', 'oe')
        .replaceAll('ü', 'ue')
        .replaceAll('á', 'a')
        .replaceAll('ó', 'o')
        .replaceAll('è', 'e');
    if (s[0] == 'g') {
      //if (dev) print(s);
      if (groupName != '') {
        erred.add('Count for $groupName: $count');
      }
      count = 0;
      groupName = '${s.substring(2)}\n';
      if (dev) print(groupName);
    } else {
      List<String> ils = s.split(', ');
      List<String> ln = ils[0]
          .replaceAll('von ', '')
          .replaceAll(RegExp(r'[0-9]'), '')
          .split(RegExp(r'[ ,-]'))
        ..removeAt(0)
        ..addAll(['', '']);
      List<String> fn = ils[1].split(RegExp(r'[ ,-]'))..addAll(['', '']);
      String uname = makeUserName(fn, ln, groupName);
      if (dev) print(uname);
      if (uname != '') {
        write += '$uname$groupName';
      } else {
        count++;
        countf++;
      }
      //print(write);
    }
  }
  erred
    ..add('Count for $groupName: $count')
    ..add('Total Count: $countf out of ${ls.length}');
  print(write);
  File output = File('dat/output.csv')..createSync();
  output.writeAsStringSync(write);
  File err = File('dat/erred.txt')..createSync();
  err.writeAsStringSync(parseErr());
}

String makeUserName(
    List<String> firstname, List<String> lastname, String groupName) {
  /*String r = '$firstname.$lastname'
      .toLowerCase()
      .replaceAll('ä', 'ae')
      .replaceAll('ö', 'oe')
      .replaceAll('ü', 'ue');
  if (!allUsers.contains(r)) {
    r = '$lastname.$firstname'
        .toLowerCase()
        .replaceAll('ä', 'ae')
        .replaceAll('ö', 'oe')
        .replaceAll('ü', 'ue');
    if (!allUsers.contains(r)) {
      erred.add('$r,${groupName.substring(6, groupName.length - 1)}');
      return '';
    }
  }*/
  String r = pos[0](firstname, lastname);
  //r = r.substring(0, min(r.length, 19));
  int iterations = 1;
  while (!allUsers.contains(r) && iterations < pos.length) {
    r = pos[iterations](firstname, lastname);
    //r = r.substring(0, min(r.length, 19));
    iterations++;
    if (iterations == pos.length) {
      erred.add('$r; ${groupName.substring(6, groupName.length - 1)}');
      return '';
    }
  }

  return '$r,';
}

typedef UnameFunction = String Function(List<String> f, List<String> l);
List<UnameFunction> pos = [
  ((f, l) => '${f[0]}.${l[0]}'),
  ((f, l) => '${l[0]}.${f[0]}'),
  ((f, l) => '${f[0]}-${f[1]}.${l[0]}'),
  ((f, l) => '${f[0]}.${l[0]}-${l[1]}'),
  ((f, l) => '${l[0]}.${f[0]}-${f[1]}'),
  ((f, l) => '${l[0]}-${l[1]}.${f[0]}-${f[1]}'),
  ((f, l) => '${f[0]}-${f[1]}.${l[0]}-${l[1]}'),
  ((f, l) => remLast('${f[0]}.${l[0]}')),
  ((f, l) => remLast('${l[0]}.${f[0]}')),
  ((f, l) => remLast('${f[0]}-${f[1]}.${l[0]}')),
  ((f, l) => remLast('${f[0]}.${l[0]}-${l[1]}')),
  ((f, l) => remLast('${l[0]}.${f[0]}-${f[1]}')),
  ((f, l) => remLast('${l[0]}-${l[1]}.${f[0]}-${f[1]}')),
  ((f, l) => remLast('${f[0]}-${f[1]}.${l[0]}-${l[1]}')),
  /*
  ((f, l) => '${f[0]}.${l[0]}'.substring(0, min(20, (l[0] + f[0]).length + 1))),
  ((f, l) => '${l[0]}.${f[0]}'.substring(0, min(20, (l[0] + f[0]).length + 1))),
  ((f, l) => '${f[0]}-${f[1]}.${l[0]}'
      .substring(0, min(19, (l[0] + f[0] + f[1]).length + 2))),
  ((f, l) => '${f[0]}.${l[0]}-${l[1]}'
      .substring(0, min(19, (l[0] + l[1] + f[0]).length + 2))),
  ((f, l) => '${l[0]}.${f[0]}-${f[1]}'
      .substring(0, min(19, (l[0] + f[0] + f[1]).length + 2))),
  ((f, l) => '${l[0]}-${l[1]}.${f[0]}-${f[1]}'
      .substring(0, min(19, (l[0] + l[1] + f[0] + f[1]).length + 3))),
  ((f, l) => '${f[0]}-${f[1]}.${l[0]}-${l[1]}'
      .substring(0, min(19, (l[0] + l[1] + f[0] + f[1]).length + 3))),*/
  ((f, l) => '$f.${l}2'),
  ((f, l) => '$l.${f}2'),
  ((f, l) => '${f[0]}-${f[1]}.${l[0]}2'),
  ((f, l) => '${f[0]}.${l[0]}-${l[1]}2'),
  ((f, l) => '${l[0]}.${f[0]}-${f[1]}2'),
  ((f, l) => '${l[0]}-${f[1]}.${f[0]}-${f[1]}2'),
  ((f, l) => '${l[0]}${l[1]}${l[2]}.${f[0]}${f[1]}${f[2]}'),
  ((f, l) => '${f[0]}${f[1]}${f[2]}.${l[0]}${l[1]}${l[2]}'),
  ((f, l) => '${f[0]}.${l[0]}')
];

List<String> getAllUsers() {
  List<String> r = [];
  File user = File('dat/user.csv');
  List<String> ls = user.readAsLinesSync()..removeAt(0);
  for (String s in ls) {
    r.add(s.split(',')[1]);
  }
  print(r);

  return r;
}

String remLast(String s) {
  return s.substring(0, s.length - 1);
}

List<String> erred = [];

List<String> allUsers = getAllUsers();

String parseErr() {
  String r = '';
  for (String s in erred) {
    r += '$s\n';
  }
  print(r);
  return r;
}
