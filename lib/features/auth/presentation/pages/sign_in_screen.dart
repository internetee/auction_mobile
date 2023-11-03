import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../cubit/auth/auth_cubit.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const CustomTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  obscureText: false,
                ),
                const CustomTextField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () => {},
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.labelText, required this.hintText, required this.obscureText});

  final String labelText;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    // User user = context.read<AuthCubit>().state.user!;
    return TextField(
        onChanged: (value) => print(value),
        decoration: InputDecoration(labelText: labelText, hintText: hintText),
        obscureText: obscureText,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black));
  }
}
