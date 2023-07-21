import 'dart:io';

void startCourseInterface() {
  List<String> writestring = ['shortname,fullname,idnumber,category_path'];
  for (List course in courses) {
    for (String grade in classes) {
      for (String cl in sub) {
        String fullname = 'SJ 23-24 $grade$cl ${course[1]} ';
        print('kzl für $fullname: ');
        String kzl = stdin.readLineSync() ?? '';
        if (kzl == '') {
          continue;
        } else {
          fullname = fullname + kzl;

          String shortname =
              fullname.replaceAll(course[1], course[0]).replaceAll(' ', '_');
          writestring.add(
              '$shortname,$fullname,$shortname,Unterricht / SJ 2023-2024 / Klassen $grade / Klasse $grade$cl');
        }
      }
    }
  }
  File f = File('kurse.csv')..createSync();
  f.writeAsStringSync(writestring.join('\n'));
}

void koppelCourseInterface() {
  List<String> writestring = ['shortname,fullname,idnumber,category_path'];
  for (List course in koppel) {
    for (String grade in classes) {
      for (int i = 1; i <= 4; i++) {
        String fullname = 'SJ 23-24 ${course[1]}$i $grade ';
        print('kzl für $fullname: ');
        String kzl = stdin.readLineSync() ?? '';
        if (kzl == '') {
          continue;
        } else {
          fullname = fullname + kzl;

          String shortname =
              fullname.replaceAll(course[1], course[0]).replaceAll(' ', '_');
          writestring.add(
              '$shortname,$fullname,$shortname,Unterricht / SJ 2023-2024 / Klassen $grade');
        }
      }
    }
  }
  File f = File('kurseKoppel.csv')..createSync();
  f.writeAsStringSync(writestring.join('\n'));
}

void coursesJ1() {
  List<String> writestring = ['shortname,fullname,idnumber,category_path'];
  String grade = 'A25 J1';
  for (List<String> course in courses..addAll(koppel)) {
    for (int i = 1; i <= 4; i++) {
      String cl = i.toString();
      String fullname = '$grade ${course[1]}$cl ';
      print('kzl für $fullname: ');
      String kzl = stdin.readLineSync() ?? '';
      if (kzl != '') {
        fullname = fullname + kzl;

        String shortname =
            fullname.replaceAll(course[1], course[0]).replaceAll(' ', '_');
        writestring.add(
            '$shortname,$fullname,$shortname,Unterricht / SJ 2023-2024 / SJ23-24 KS 1');
      }

      fullname = '$grade ${course[1].toLowerCase()}$cl ';
      print('kzl für $fullname: ');
      kzl = stdin.readLineSync() ?? '';
      if (kzl != '') {
        fullname = fullname + kzl;

        String shortname = fullname
            .replaceAll(course[1].toLowerCase(), course[0].toLowerCase())
            .replaceAll(' ', '_');
        writestring.add(
            '$shortname,$fullname,$shortname,Unterricht / SJ 2023-2024 / SJ23-24 KS 1');
      }
    }
  }
  File f = File('kurseJ1.csv')..createSync();
  f.writeAsStringSync(writestring.join('\n'));
}

List<String> sub = ['a', 'b', 'c', 'd'];
List<String> classes = ['5', '6', '7', '8', '9', '10'];
List courses = [
  ['KLS', 'KLS'],
  ['D', 'Deutsch'],
  ['E', 'Englisch'],
  ['M', 'Mathematik'],
  ['G', 'Geschichte'],
  ['GEO', 'Geographie'],
  ['GK', 'GK'],
  ['WBS', 'WBS'],
  ['P', 'Physik'],
  ['C', 'Chemie'],
  ['B', 'Biologie'],
  ['BNTP', 'BNT-P'],
  ['BK', 'BK']
];

List koppel = [
  ['NwT', 'NwT'],
  ['Mu', 'Musik'],
  ['I', 'italienisch'],
  ['Inf', 'Informatik'],
  ['F', 'Französisch'],
  ['L', 'Latein'],
  ['Eth', 'Ethik'],
  ['rev', 'religion ev'],
  ['rek', 'religion rk']
];

void fixID() {
  File f = File('kurseJ1.csv');
  List<String> ls = f.readAsLinesSync();
  List<String> writeString = ['shortname,fullname,idnumber,category_path'];
  for (String s in ls) {
    List l = s.split(',');
    if (l[0] == 'shortname') {
    } else {
      writeString.add(
          '${l[0]},${l[1]},${l[2]},Unterricht / SJ 2023-2024 / Kursstufe 1');
    }
  }
  f.writeAsStringSync(writeString.join('\n'));
}
