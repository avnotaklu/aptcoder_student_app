import 'package:aptcoder/bloc/authentication/authentication_bloc.dart';
import 'package:aptcoder/bloc/courses/courses_bloc.dart';
import 'package:aptcoder/bloc/student/student_bloc.dart';
import 'package:aptcoder/service/constants.dart';
import 'package:aptcoder/service/picker_service.dart';
import 'package:aptcoder/views/widgets/appbar.dart';
import 'package:aptcoder/views/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'widgets/skeleton.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar(height * 0.2),
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: ((context, state) {
          if (state is StudentErrorState) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => ErrorDisplay(state.error))));
          }
        }),
        builder: ((context, state) {
          if (state is StudentInitial) {
            return const LoadingWidget();
          }
          if (state is NewStudentCreatingState) {
            return Column(
              children: [
                Text(
                  "Creating your profile",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const LoadingWidget()
              ],
            );
          }
          if (state is StudentLoadedState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    height: height * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Activity",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        if (state.student.lastViewedCourses.isNotEmpty)
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.student.lastViewedCourses.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  final course = state.viewedCourses[index];

                                  return GestureDetector(
                                    onTap: () async {
                                      context.read<StudentBloc>().add(StudentViewCourse(state.student, course));
                                      await FileService.openfile(
                                          url: course.resourceUrl, filename: course.resourceName);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Container(
                                          padding: const EdgeInsets.only(left: 12),
                                          width: width * 0.3,
                                          child: Text("Read on",
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context).textTheme.labelLarge),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(left: 10),
                                          width: width * 0.4,
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: height * 0.06,
                                            ),
                                            child: Text(
                                                DateFormat("MM-dd HH:mm").format(state.student.lastViewedCourses
                                                    .firstWhere((element) => element.resource == course.id)
                                                    .time
                                                    .toDate()),
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context).textTheme.labelSmall),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Container(
                                            // ignore: prefer_const_constructors
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(course.imageUrl), fit: BoxFit.fill),
                                            ),
                                            width: width * 0.37,
                                            height: height * 0.2,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: width * 0.5,
                                            maxHeight: height * 0.06,
                                          ),
                                          child: Text(course.name, style: Theme.of(context).textTheme.titleMedium),
                                        ),
                                      ]),
                                    ),
                                  );
                                })),
                          )
                        else
                          Center(child: Text("No activity so far", style: Theme.of(context).textTheme.headlineMedium))
                      ],
                    ),
                  ),
                  BlocProvider<CoursesBloc>(
                    create: (context) => CoursesBloc()..add(LoadCoursesEvent()),
                    child: BlocConsumer<CoursesBloc, CoursesState>(
                      listener: (context, state) {
                        if (state is CoursesLoadingErrorState) {
                          showDialog(
                              context: context,
                              builder: ((context) => ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: Dialog(
                                      child: ErrorDisplay(
                                          width: width * 0.7, height: height * 0.5, "Failure loading courses")))));
                        }
                      },
                      builder: (context, courseState) {
                        if (courseState is CoursesInitial) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BaseShimmerBox(
                                width: width * 0.6,
                                height: height * 0.02,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BaseShimmerBox(
                                          width: width * 0.33,
                                          height: height * 0.12,
                                        ),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BaseShimmerBox(
                                              width: width * 0.4,
                                              height: height * 0.03,
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            BaseShimmerBox(
                                              width: width * 0.2,
                                              height: height * 0.03,
                                            ),
                                            SizedBox(
                                              height: height * 0.005,
                                            ),
                                            BaseShimmerBox(
                                              width: width * 0.5,
                                              height: height * 0.03,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ],
                          );
                        } else if (courseState is CoursesLoadedState) {
                          if (courseState.courses.isNotEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Discover More",
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  SizedBox(
                                    height: height * 0.015,
                                  ),
                                  ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: courseState.courses.length,
                                      itemBuilder: ((context, index) {
                                        final course = courseState.courses[index];

                                        return GestureDetector(
                                          onTap: () {
                                            context.read<StudentBloc>().add(StudentViewCourse(state.student, course));
                                            FileService.openfile(
                                                url: course.resourceUrl, filename: course.resourceName);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(bottom: 8),
                                            height: height * 0.12,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(30),
                                                  child: Container(
                                                    width: width * 0.25,
                                                    height: height * 0.12,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill, image: NetworkImage(course.imageUrl))),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.03,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                        maxWidth: width * 0.5,
                                                        maxHeight: height * 0.06,
                                                      ),
                                                      child: Text(course.name,
                                                          style: Theme.of(context).textTheme.titleMedium!),
                                                    ),
                                                    ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                        maxWidth: width * 0.5,
                                                        maxHeight: height * 0.06,
                                                      ),
                                                      child: Text(
                                                        course.type.name,
                                                        style: Theme.of(context).textTheme.labelSmall!,
                                                      ),
                                                    ),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      })),
                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Discover More",
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  SizedBox(
                                    height: height * 0.015,
                                  ),
                                  InfoDisplay(
                                    "No courses has been added by admin",
                                    height: height * 0.3,
                                    width: width * 0.7,
                                  ),
                                ],
                              ),
                            );
                          }
                        } else if (courseState is CoursesLoadingErrorState) {
                          return Center(
                              child: ErrorDisplay(
                            "Error Loading Courses",
                            width: width,
                            height: height * 0.8,
                          ));
                        } else {
                          throw Exception();
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
