import 'package:csv_for_groups/csv_for_courses.dart';
import 'package:csv_for_groups/csv_for_groups.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments[0] == 'g') {
    execute();
  } else if (arguments[0] == 'c') {
    if (arguments[1] == 'c') {
      startCourseInterface();
    } else if (arguments[1] == 'k') {
      koppelCourseInterface();
    }
  } else if (arguments[0] == 'f') {
    fixID();
  } else if (arguments[0] == 'j') {
    coursesJ1();
  }
  /*
  switch (arguments[0]) {
    case 'c':
      execute();
      break;

    default:
      print('unhandeled arguments');
  }
  */
}
