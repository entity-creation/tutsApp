class Dept {
  final List<String> dept;

  const Dept({required this.dept});

  static Dept fromJson(Map<String, dynamic> json) => Dept(
        dept: json['departments'],
      );
}

class Courses {
  final List<String> courses;

  const Courses({required this.courses});

  static Courses fromJson(Map<String, dynamic> json) =>
      Courses(courses: json['courses']);
}
