import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/button_bloc/button_cubit.dart';
import 'package:nepa_bid/domain/auth/usecases/logged_out.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../auth/pages/auth_imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ButtonCubit(),
      child: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonLoaded) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChooseAuthPage()));
          }
        },
        child: Scaffold(
          body: Center(child: Builder(builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  context.read<ButtonCubit>().execute(
                        usecase: sl<LoggedOut>(),
                      );
                },
                child: const Text('Logout'));
          })),
        ),
      ),
    );
  }
}
