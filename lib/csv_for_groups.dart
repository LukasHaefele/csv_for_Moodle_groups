import 'dart:io';

import 'csv_for_courses.dart';

bool dev = false;

void execute() {
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
        .replaceAll('á', 'a')
        .replaceAll('ó', 'o')
        .replaceAll('è', 'e')
        .replaceAll('ä', 'ae')
        .replaceAll('ö', 'oe')
        .replaceAll('ü', 'ue');
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

List<String> relClasses = [
  "5_SUZ_BEC",
  "5a_AHL_AUS",
  "5c_BÜH_ERM",
  "5d_HOC_KNÖ",
  "6a_HON_KRÄ",
  "6b_SEE_LAR",
  "6c_HAI_KUC",
  "6d_PAL_JUN",
  "7a_VAL_BOF",
  "7b_AIS_RIC",
  "7c_BEU_OTT",
  "7d_KRP_SÜR",
  "8a_CHR_GAR",
  "8b_GAU_KÜM",
  "8c_RET",
  "8d_STF_HAF",
  "9a_KUP_SOW",
  "9b_KRU",
  "9c_EWD_HEI",
  "9d_NWT1_LEH_EIL",
  "10a_KOH_SAD",
  "10b_DRÖ_STA",
  "10c_LUK_GTK",
  "J1",
  "J2",
  "VKL1",
  "VKL2",
  "VKL3",
  "VKL4"
  ];
//List<String> relClasses = ["BNT","Ethik","Französisch","Informatik","Medienbildung","Musik","NWT2","sport"];

void relutionDropClasses(){
  for (String dropClass in relClasses){
    print('$dropClass:\n');
    List<Map> students = getStudentsFromCSV(dropClass);
    List<List<String>> posUnames = [];
    for(Map student in students){
      posUnames.add(['${student['Name']}.${student['Vorname']}'.toLowerCase(),'${student['Vorname']}.${student['Name']}'.toLowerCase()]);
    }
    List<String> unames = actualUnames(posUnames);
    print('unames:\n$unames\n');
    print('Enter Name for course $dropClass');
    String courseName = stdin.readLineSync() ?? '';
    if (courseName == '') courseName = dropClass;
    print(courseName);
    String write = 'name;roleName;memberType\n';
    for (String uname in unames){
      write += '"$courseName";"$uname";"STUDENT"\n';
    }
    saveDropClass(courseName, write);
  }
  print('uncaught:\n$uncaught\n');
}

void saveDropClass(String className, String write){
  File('dat/output/$className.csv')..createSync()..writeAsStringSync(write);
}

List<String> uncaught = [];

List<String> actualUnames(List<List<String>> posUnames){
  List<String> unames = [];
  List<Map> students = getStudentsFromCSV('students');
  for(Map user in students){
    //print('${user['Anmeldename']}\n');
    if(posUnames.any((innerList) => innerList.contains(user['Anmeldename']) && posUnames.remove(innerList))){
      unames.add(user['Anmeldename']);
    }
  }
  print('posNames:\n$posUnames\n');
  for (var element in posUnames) {uncaught.add(element[0]);}
  return unames;
}

void fixComma(){
  for(String s in relClasses){
    File f = File('dat/$s.csv');
    List<String> input = f.readAsLinesSync();
    String write = '';
    for(String sin in input){
      write += '${sin
        .replaceAll(',', ';')
        .replaceAll('ä', 'ae')
        .replaceAll('ö', 'oe')
        .replaceAll('ü', 'ue')
        .replaceAll('ß', 'ss')
        .replaceAll('ć', 'c')
        .replaceAll('ž', 'z')
        .replaceAll('ß', 'ss')
        .replaceAll('é', 'e')
        .replaceAll('á', 'a')
        .replaceAll('ó', 'o')
        .replaceAll('è', 'e')}\n';
    }
    f.writeAsStringSync(write);
  }
}