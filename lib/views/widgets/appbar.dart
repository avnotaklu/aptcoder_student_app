import 'package:aptcoder/bloc/profile/profile_bloc.dart';
import 'package:aptcoder/bloc/student/student_bloc.dart';
import 'package:aptcoder/service/constants.dart';
import 'package:aptcoder/views/user_profile.dart';
import 'package:aptcoder/views/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MyAppBar extends StatelessWidget implements PreferredSize {
  final double _height;
  MyAppBar(
    this._height, {
    Key? key,
  }) : super(key: key);
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: primaryColor,
            centerTitle: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            )),
            title: BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                if (state is StudentLoadedState) {
                  return RichText(
                      text: TextSpan(children: [
                    TextSpan(text: "Your Dashboard", style: Theme.of(context).textTheme.headlineMedium),
                  ]));
                  // return Text(
                  //   "Welcome ${state.student.name}",
                  //   style: Theme.of(context).textTheme.titleSmall,
                  // );
                } else {
                  return BaseShimmerBox(
                    width: width * 0.6,
                    height: preferredSize.height * 0.15,
                    color: Colors.grey.shade700,
                  );
                }
              },
            ),
            leadingWidth: width * 0.18,
            leading: Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(20), left: Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ClipOval(
                  child: BlocBuilder<StudentBloc, StudentState>(
                    builder: (context, state) {
                      if (state is StudentLoadedState) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((newContext) => BlocProvider<ProfileBloc>(
                                          create: (newContext) => ProfileBloc(state.student, context.read<StudentBloc>()),
                                          child: const UserProfile(),
                                        ))));
                          },
                          child: Image.network(
                            (state).student.profilePic ?? defaultProfilePicUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return BaseShimmerBox(
                          color: Colors.grey.shade700,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: preferredSize.height * 0.12),
          BlocBuilder<StudentBloc, StudentState>(
            builder: (context, state) {
              if (state is StudentLoadedState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: width * 0.4),
                        child: Text(state.student.name,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white))),
                    SizedBox(
                      width: width * 0.07,
                    ),
                    Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: width * 0.4),
                          child: Text("Viewed Courses",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                        ),
                        SizedBox(
                          height: _height * 0.04,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: width * 0.4),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.read_more,
                                  color: Colors.white,
                                ),
                              ),
                              Text(state.student.lastViewedCourses.length.toString(),
                                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseShimmerBox(
                          width: width * 0.35,
                          height: preferredSize.height * 0.1,
                        ),
                        SizedBox(
                          height: preferredSize.height * 0.02,
                        ),
                        BaseShimmerBox(
                          width: width * 0.35,
                          height: preferredSize.height * 0.10,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseShimmerBox(
                          width: width * 0.25,
                          height: preferredSize.height * 0.1,
                        ),
                        SizedBox(
                          height: preferredSize.height * 0.02,
                        ),
                        BaseShimmerBox(
                          width: width * 0.25,
                          height: preferredSize.height * 0.10,
                        ),
                      ],
                    ),
                  ]),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget get child {
    return AppBar(
      backgroundColor: Colors.white,
      title: SizedBox(
        child: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            if (state is StudentLoadedState) {
              return Image.network(
                (state).student.profilePic ?? defaultProfilePicUrl,
                fit: BoxFit.fill,
              );
            } else {
              return const BaseShimmerBox();
            }
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_height);
}
