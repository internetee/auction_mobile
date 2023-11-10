import 'package:auction_mobile/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            context.goNamed('/');

          } else if (state.status == AuthStatus.unauthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      obscureText: false,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: () => _onLoginButtonPressed(context),
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    authCubit.signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.labelText, required this.hintText, required this.obscureText, required this.controller});

  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    // User user = context.read<AuthCubit>().state.user!;
    return TextField(
      controller: controller,
      onChanged: (value) => print(value),
      decoration: InputDecoration(labelText: labelText, hintText: hintText),
      obscureText: obscureText,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black));
  }
}
