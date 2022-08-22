import 'package:aptcoder/bloc/authentication/authentication_bloc.dart';
import 'package:aptcoder/bloc/profile/profile_bloc.dart';
import 'package:aptcoder/bloc/student/student_bloc.dart';
import 'package:aptcoder/model/student.dart';
import 'package:aptcoder/service/constants.dart';
import 'package:aptcoder/views/widgets/profile_edit_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<ProfileBloc, ProfileStateWithStudent>(
      builder: (context, state) {
        if (state is UpdateProfileProgress) {
          return Scaffold(body: LoadingWidget());
        }
        final student = (state).student;
        return Scaffold(
          appBar: AppBar(
            title: Text("Your Profile", style: Theme.of(context).textTheme.headlineMedium),
            centerTitle: true,
            leading: const BackButton(
              color: Colors.black,
            ),
            actions: [
              IconButton(
                  onPressed: () => context.read<AuthenticationBloc>().add(LogoutEvent()),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ))
            ],
            elevation: 0,
            backgroundColor: secondaryColor,
            automaticallyImplyLeading: true,
          ),
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.15,
                      decoration: const BoxDecoration(
                          color: secondaryColor, borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
                    ),
                    Positioned(
                      left: width * 0.05,
                      top: height * 0.027,
                      child: Container(
                        width: width * 0.4,
                        height: height * 0.18,
                        color:Colors.transparent,
                        child:  ClipOval(
                            child: Image.network(
                              student.profilePic ?? defaultProfilePicUrl,
                              fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.23,
                      width: width,
                      decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 12,
                          bottom: 12,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(student.name, style: Theme.of(context).textTheme.titleMedium),
                            student.institute != null
                                ? Text(
                                    student.institute!,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ProfileEditPrompt(
                                        student: student,
                                        inputType: TextInputType.name,
                                        controller: TextEditingController(),
                                        constraints: BoxConstraints(maxWidth: width * 0.25),
                                        label: "institution",
                                        title: student.institute,
                                        onEditConfirm: (p0) {
                                          context.read<ProfileBloc>().add(UpdateProfile(student, institute: p0));
                                        },
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: width * 0.05 * 6,
                      top: height * 0.027 * 6,
                      child: IconButton(
                        onPressed: () {
                          print('hello');
                          context.read<ProfileBloc>().add(ProfilePicUpload(student));
                        },
                        icon: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.all(width * 0.05 * 0.1 * 0.1),
                              color: primaryColor,
                              child: const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    children: [
                      ProfileEditTile(
                          inputType: TextInputType.name,
                          student: student,
                          title: student.name,
                          label: "name",
                          onEditConfirm: (v) {
                            context.read<ProfileBloc>().add(UpdateProfile(student, name: v));
                          }),
                      ProfileEditTile(
                          inputType: TextInputType.name,
                          student: student,
                          title: student.institute,
                          label: "institute",
                          onEditConfirm: (v) {
                            context.read<ProfileBloc>().add(UpdateProfile(student, institute: v));
                          }),
                      ProfileEditTile(
                          inputType: TextInputType.name,
                          student: student,
                          title: student.course,
                          label: "course",
                          onEditConfirm: (v) {
                            context.read<ProfileBloc>().add(UpdateProfile(student, course: v));
                          }),
                      ProfileEditTile(
                          inputType: TextInputType.number,
                          student: student,
                          title: student.rollNo?.toString(),
                          label: "roll no",
                          onEditConfirm: (v) {
                            context.read<ProfileBloc>().add(UpdateProfile(student, rollNo: int.parse(v)));
                          }),
                      ProfileEditTile(
                          inputType: TextInputType.number,
                          student: student,
                          title: student.sem?.toString(),
                          label: "semester",
                          onEditConfirm: (v) {
                            context.read<ProfileBloc>().add(UpdateProfile(student, sem: int.parse(v)));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
