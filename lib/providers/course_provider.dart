import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/course.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<List<Course>> course(CourseRef ref) async {
  final response = await supabase.from('courses').select();
  final List<Course> courses = [];
  for (var element in response) {
    courses.add(Course.fromJson(element));
  }
  return courses;
}


