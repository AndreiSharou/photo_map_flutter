import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../session/session_cubit.dart';

class HomeScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Session View'),
            TextButton(
              child: Text('sign out'),
              onPressed: () => BlocProvider.of<SessionCubit>(context).signOut(),
            )
          ],
        ),
      ),
    );
  }
}