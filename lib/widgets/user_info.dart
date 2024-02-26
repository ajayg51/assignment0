
import 'package:assignment0/blocs/login_bloc/login_bloc.dart';
import 'package:assignment0/blocs/login_bloc/login_event.dart';
import 'package:assignment0/blocs/login_bloc/login_state.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/utils/route_path.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildLoggedInUserInfo extends StatefulWidget {
  const BuildLoggedInUserInfo({super.key});

  @override
  State<BuildLoggedInUserInfo> createState() => _BuildLoggedInUserInfoState();
}

class _BuildLoggedInUserInfoState extends State<BuildLoggedInUserInfo> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(const UserLoginStartupEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (ctx, state) {
        if (state is UserLoggedOutState &&
            FirebaseAuth.instance.currentUser == null) {
          context.router.pushNamed(RouteEnums.login.getPath);
        }
      },
      builder: (ctx, state) {
        if (state is UserLoggedInStartupState) {
          final list = state.list;
          if (list.isNotEmpty) {
            final userInfo = list[0];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all()),
                    child: ClipOval(
                      child: Image.network(
                        userInfo.photoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Text(
                            "NA",
                            style: Theme.of(context).textTheme.titleSmall,
                          );
                        },
                      ).padAll(value: 6),
                    ),
                  ),
                  12.horizontalSpace,
                  Text(
                    "Hello ${userInfo.displayName}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ).padSymmetric(
                horizontalPad: 12,
                verticalPad: 6,
              ),
            ).padSymmetric(horizontalPad: 12);
          }
        }
        return Text(
          "user info not found",
          style: Theme.of(context).textTheme.titleMedium,
        );
      },
    );
  }
}