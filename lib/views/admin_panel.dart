import 'package:aptcoder/bloc/admin/admin_bloc.dart';
import 'package:aptcoder/bloc/authentication/authentication_bloc.dart';
import 'package:aptcoder/bloc/course_create/course_create_bloc.dart';
import 'package:aptcoder/bloc/courses/courses_bloc.dart';
import 'package:aptcoder/model/course.dart';
import 'package:aptcoder/service/constants.dart';
import 'package:aptcoder/views/widgets/appbar_admin.dart';
import 'package:aptcoder/views/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/error.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CoursesBloc()..add(LoadCoursesEvent()),
        ),
        BlocProvider(
          create: (context) => CourseCreateBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AdminAppBar(height * 0.2),
        body: BlocConsumer<CourseCreateBloc, CourseCreateState>(
          listener: (context, state) {
            if (state is CoursesCreateSuccessState) {
              showDialog(
                  context: context,
                  builder: ((context) => ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Dialog(
                          child: InfoDisplay(width: width * 0.7, height: height * 0.5, "Successfully added course")))));
              context.read<CoursesBloc>().add(LoadCoursesEvent());
            }
          },
          builder: (context, state) {
            if (state is CreateCourseInProgress) {
              return const Scaffold(
                body: LoadingWidget(),
              );
            }
            return BlocBuilder<AdminBloc, AdminState>(
              builder: ((context, state) {
                if (state is AdminInitial) {
                  return const LoadingWidget();
                }
                if (state is NewAdminCreatingState) {
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
                if (state is AdminLoadedState) {
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              final bloc = context.read<CourseCreateBloc>()..add(ResetCourseCreateDialog());
                              final nameController = TextEditingController();
                              await showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return Dialog(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        decoration: const BoxDecoration(),
                                        height: height * 0.5,
                                        width: width * 0.4,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              "Enter course details",
                                              style: Theme.of(context).textTheme.headlineMedium,
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            BlocProvider<CourseCreateBloc>.value(
                                              value: bloc,
                                              child: BlocConsumer<CourseCreateBloc, CourseCreateState>(
                                                listener: ((context, state) {
                                                  if (state is CoursesCreateSuccessState) {
                                                    Navigator.of(context).pop();
                                                  }
                                                  if (state is CreateCourseInProgress) {
                                                    Navigator.of(context).pop();
                                                  }
                                                  if (state is CoursesCreateFailureState) {
                                                    Navigator.of(context).pop();

                                                    showDialog(
                                                        context: context,
                                                        builder: ((context) => ClipRRect(
                                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                            child: Dialog(
                                                                child: ErrorDisplay(
                                                                    width: width * 0.7,
                                                                    height: height * 0.5,
                                                                    state.error)))));
                                                  }
                                                }),
                                                builder: (context, state) {
                                                  if (state is CourseCreateInitial) {
                                                    return Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black),
                                                                borderRadius: const BorderRadius.horizontal(
                                                                    right: Radius.circular(6),
                                                                    left: Radius.circular(6))),
                                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                                            height: height * 0.07,
                                                            child: TextFormField(
                                                                controller: nameController,
                                                                decoration: const InputDecoration(
                                                                    label: Text("name"), border: InputBorder.none))),
                                                        SizedBox(height: height * 0.02),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.black),
                                                              borderRadius: const BorderRadius.horizontal(
                                                                  right: Radius.circular(6), left: Radius.circular(6))),
                                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                                          height: height * 0.055,
                                                          child: DropdownButtonFormField<CourseType>(
                                                              value: state.type,
                                                              hint: const Text("Type"),
                                                              items: CourseType.values
                                                                  .map<DropdownMenuItem<CourseType>>(
                                                                      (e) => DropdownMenuItem(
                                                                            value: e,
                                                                            child: Text(e.name),
                                                                          ))
                                                                  .toList(),
                                                              onChanged: (value) => {
                                                                    if (value != null)
                                                                      context
                                                                          .read<CourseCreateBloc>()
                                                                          .add(TypeChangeEvent(value))
                                                                  }),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.1,
                                                          child: FittedBox(
                                                              child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: width * 0.1,
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                    context
                                                                        .read<CourseCreateBloc>()
                                                                        .add(ImageLoadEvent());
                                                                  },
                                                                  child: ClipOval(
                                                                      child: state.image != null
                                                                          ? Image.memory(
                                                                              state.image!,
                                                                              fit: BoxFit.fill,
                                                                            )
                                                                          : const Icon(Icons.image)),
                                                                ),
                                                              ),
                                                              IconButton(
                                                                  onPressed: () {
                                                                    context
                                                                        .read<CourseCreateBloc>()
                                                                        .add(ResourceLoadEvent());
                                                                  },
                                                                  icon: Icon(
                                                                    Icons.attach_file,
                                                                    color: state.resource != null
                                                                        ? primaryColor
                                                                        : Colors.black,
                                                                  )),
                                                            ],
                                                          )),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.1,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: ButtonStyle(
                                                                  shape: MaterialStateProperty.all(
                                                                      RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(20.0))),
                                                                  foregroundColor:
                                                                      MaterialStateProperty.all(Colors.black),
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(secondaryColor),
                                                                ),
                                                                child: const Text("Cancel"),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  context
                                                                      .read<CourseCreateBloc>()
                                                                      .add(CreateCourseEventRequested(
                                                                        nameController.text,
                                                                        state.type,
                                                                        state.resource,
                                                                        state.image,
                                                                        state.filename,
                                                                        state.imageName,
                                                                      ));
                                                                },
                                                                style: ButtonStyle(
                                                                  shape: MaterialStateProperty.all(
                                                                      RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(20.0))),
                                                                  foregroundColor:
                                                                      MaterialStateProperty.all(Colors.black),
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(secondaryColor),
                                                                ),
                                                                child: const Text("Create"),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  } else {
                                                    return const SizedBox.shrink();
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }));
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                              foregroundColor: MaterialStateProperty.all(Colors.black),
                              backgroundColor: MaterialStateProperty.all(secondaryColor),
                            ),
                            child: const Text("Create New"),
                          ),
                        ),
                        BlocBuilder<CoursesBloc, CoursesState>(
                          builder: (context, state) {
                            if (state is CoursesInitial) {
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
                            }
                            if (state is CoursesLoadedState) {
                              if (state.courses.isNotEmpty) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(
                                        "All courses",
                                        style: Theme.of(context).textTheme.headlineMedium,
                                      ),
                                      SizedBox(
                                        height: height * 0.015,
                                      ),
                                      ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.courses.length,
                                          itemBuilder: ((context, index) {
                                            final course = state.courses[index];

                                            return Container(
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
                                            );
                                          }))
                                    ]));
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "All courses",
                                        style: Theme.of(context).textTheme.headlineMedium,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.015,
                                    ),
                                    Center(
                                        child: InfoDisplay(
                                      "Add some courses",
                                      width: width * 0.7,
                                      height: height * 0.3,
                                    )),
                                  ],
                                ); /*  */
                              }
                            }
                            if (state is CoursesLoadingErrorState) {
                              return ErrorDisplay(state.error);
                            } else {
                              return const ErrorDisplay("Unexpected Error");
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
                if (state is AdminErrorState) {
                  return ErrorDisplay(state.error);
                } else {
                  return const ErrorDisplay("Unexpected Error");
                }
              }),
            );
          },
        ),
      ),
    );
  }
}
