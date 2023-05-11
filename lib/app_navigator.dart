
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_map_flutter/auth/auth_cubit.dart';
import 'package:photo_map_flutter/homeScreen/home_screen.dart';
import 'package:photo_map_flutter/session/session_cubit.dart';
import 'package:photo_map_flutter/session/session_state.dart';

import 'auth/auth_repository.dart';
import 'auth/login/login_view.dart';
import 'loading_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show loading screen
          if (state is UnknownSessionState) const MaterialPage(child: LoadingView()),

          // Show auth flow
          if (state is Unauthenticated)
            MaterialPage(
              child: RepositoryProvider(

                create: (context) => AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: LoginView(),
              ),
            ),

          // Show home screen
          if (state is Authenticated) MaterialPage(child: HomeScreenView())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}