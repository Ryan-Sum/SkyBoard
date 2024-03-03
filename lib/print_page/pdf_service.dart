// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

import 'package:sky_board/main.dart';
import 'package:sky_board/models/act_score.dart';
import 'package:sky_board/models/community_service.dart';
import 'package:sky_board/models/course.dart';
import 'package:sky_board/models/custom_item.dart';
import 'package:sky_board/models/sat_score.dart';
import 'package:sky_board/models/student.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

class PdfService {
  Future<Uint8List> createResume(
      Student student,
      List<Course> courses,
      List<ACTScore> act,
      List<SATScore> sat,
      List<CommunityService> service,
      List<CustomItem> items,
      double totalService,
      double gpa) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
          build: (pw.Context context) => [
                pw.Partition(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Text("${student.firstName} ${student.lastName}",
                              textScaleFactor: 2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontWeight: pw.FontWeight.bold)),
                          pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 10)),
                          pw.Text(
                              'Steinbrenner HS | C/O ${student.graduationYear.year.toString()} | ${supabase.auth.currentUser!.email}',
                              textScaleFactor: 1.2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                          pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 20)),
                          pw.Text(student.personalSummary,
                              style: pw.Theme.of(context).defaultTextStyle),
                        ],
                      ),
                      courses.isEmpty
                          ? pw.Container()
                          : pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                  _Category(
                                      title:
                                          'Course Summary (Unweighted GPA: $gpa)'),
                                  pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Expanded(
                                          flex: 1,
                                          child: pw.Builder(builder: (context) {
                                            List<pw.Widget> courseWidgets = [];
                                            for (var i = 0;
                                                i <
                                                    (courses.length / 2)
                                                        .round();
                                                i++) {
                                              courseWidgets.add(_CourseBlock(
                                                  title: courses[i].courseName,
                                                  course: courses[i]));
                                            }
                                            return pw.Column(
                                                children: courseWidgets);
                                          }),
                                        ),
                                        pw.Expanded(
                                          flex: 1,
                                          child: pw.Builder(builder: (context) {
                                            List<pw.Widget> courseWidgets = [];
                                            for (var i = (courses.length / 2)
                                                    .round();
                                                i < courses.length;
                                                i++) {
                                              courseWidgets.add(_CourseBlock(
                                                  title: courses[i].courseName,
                                                  course: courses[i]));
                                            }
                                            return pw.Column(
                                                children: courseWidgets);
                                          }),
                                        ),
                                        pw.Padding(padding: pw.EdgeInsets.zero)
                                      ]),
                                ]),
                      sat.isEmpty
                          ? pw.Container()
                          : pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                  _Category(title: "SAT Scores"),
                                  pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Expanded(
                                          flex: 1,
                                          child: pw.Builder(builder: (context) {
                                            List<pw.Widget> satWidgets = [];
                                            for (var i = 0;
                                                i < (sat.length / 2).round();
                                                i++) {
                                              satWidgets.add(_SATBlock(
                                                  title:
                                                      "${DateFormat('MMMM yyyy').format(sat[i].dateTaken)} SAT",
                                                  score: sat[i]));
                                            }
                                            return pw.Column(
                                                children: satWidgets);
                                          }),
                                        ),
                                        pw.Expanded(
                                          flex: 1,
                                          child: pw.Builder(builder: (context) {
                                            List<pw.Widget> satWidgets = [];
                                            for (var i =
                                                    (sat.length / 2).round();
                                                i < sat.length;
                                                i++) {
                                              satWidgets.add(_SATBlock(
                                                  title:
                                                      "${DateFormat('MMMM yyyy').format(sat[i].dateTaken)} SAT",
                                                  score: sat[i]));
                                            }
                                            return pw.Column(
                                                children: satWidgets);
                                          }),
                                        ),
                                        pw.Padding(padding: pw.EdgeInsets.zero)
                                      ]),
                                ]),
                      act.isEmpty
                          ? pw.Container()
                          : pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                  _Category(title: "ACT Scores"),
                                  pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Expanded(
                                          flex: 1,
                                          child: pw.Builder(builder: (context) {
                                            List<pw.Widget> actWidgets = [];
                                            for (var i = 0;
                                                i < act.length;
                                                i++) {
                                              actWidgets.add(_ACTBlock(
                                                  title:
                                                      "${DateFormat('MMMM yyyy').format(act[i].dateTaken)} ACT",
                                                  score: act[i]));
                                            }
                                            return pw.Column(
                                                children: actWidgets);
                                          }),
                                        ),
                                      ]),
                                ]),
                      service.isEmpty
                          ? pw.Container()
                          : pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                  _Category(title: "Community Service"),
                                  pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Expanded(
                                          flex: 1,
                                          child: pw.Builder(builder: (context) {
                                            List<pw.Widget> serviceWidgets = [];
                                            for (var i = 0;
                                                i < service.length;
                                                i++) {
                                              serviceWidgets.add(_ServiceBlock(
                                                  title:
                                                      "${DateFormat('M/d/y').format(service[i].date)} @ ${service[i].organizationName}",
                                                  service: service[i]));
                                            }
                                            return pw.Column(
                                                children: serviceWidgets);
                                          }),
                                        ),
                                      ]),
                                ]),
                      pw.Builder(builder: (context) {
                        List<pw.Widget> customItemWidgets = [];
                        for (var i = 0; i < items.length; i++) {
                          customItemWidgets
                              .add(_CustomItemBlock(item: items[i]));
                        }
                        return pw.Column(children: customItemWidgets);
                      })
                    ],
                  ),
                ),
              ]),
    );
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getApplicationDocumentsDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    OpenFile.open(file.path);
  }
}

class _CourseBlock extends pw.StatelessWidget {
  _CourseBlock({
    required this.title,
    required this.course,
  });

  final String title;
  final Course course;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 6,
                  height: 6,
                  margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                  decoration: const pw.BoxDecoration(
                    color: green,
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Text(title,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
                pw.Spacer(),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text(
                      "Final Grade: ${course.finalGrade.name.toUpperCase()} | Course Level: ${course.courseType!.name.length < 4 ? course.courseType!.name.toUpperCase() : "${course.courseType!.name[0].toUpperCase()}${course.courseType!.name.substring(1)}"}")
                ]),
          ),
        ]);
  }
}

class _SATBlock extends pw.StatelessWidget {
  _SATBlock({
    required this.title,
    required this.score,
  });

  final String title;

  final SATScore score;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 6,
                  height: 6,
                  margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                  decoration: const pw.BoxDecoration(
                    color: green,
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Text(title,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
                pw.Spacer(),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text(
                      "Score: ${score.math + score.english} | English: ${score.english} | Math: ${score.math}")
                ]),
          ),
        ]);
  }
}

class _ACTBlock extends pw.StatelessWidget {
  _ACTBlock({
    required this.title,
    required this.score,
  });

  final String title;

  final ACTScore score;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 6,
                  height: 6,
                  margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                  decoration: const pw.BoxDecoration(
                    color: green,
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Text(title,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
                pw.Spacer(),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text(
                      "Composite: ${((score.math + score.english + score.reading + score.science) / 4).round()} | English: ${score.english} | Math: ${score.math} | Reading: ${score.reading} | Science: ${score.science}")
                ]),
          ),
        ]);
  }
}

class _ServiceBlock extends pw.StatelessWidget {
  _ServiceBlock({
    required this.title,
    required this.service,
  });

  final String title;

  final CommunityService service;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 6,
                  height: 6,
                  margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                  decoration: const pw.BoxDecoration(
                    color: green,
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Text(title,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
                pw.Spacer(),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[pw.Text(service.description)]),
          ),
        ]);
  }
}

class _CustomItemBlock extends pw.StatelessWidget {
  _CustomItemBlock({
    required this.item,
  });

  final CustomItem item;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 6,
                  height: 6,
                  margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                  decoration: const pw.BoxDecoration(
                    color: green,
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Text(item.title,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
                pw.Spacer(),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[pw.Text(item.description)]),
          ),
        ]);
  }
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: lightGreen,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}
