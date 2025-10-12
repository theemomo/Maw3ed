import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/route/app_routes.dart';
import 'package:maw3ed/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:maw3ed/features/auth/presentation/widgets/text_field_widget.dart';
import 'package:maw3ed/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              width: double.infinity,
              height: size.height * 0.35,
              child: Padding(
                padding: EdgeInsets.only(bottom: size.width * 0.16),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Icon(
                      Icons.calendar_today_rounded,
                      size: size.width * 0.15,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.28),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.1),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          S.of(context).loginScreenTitle,
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).emailFieldEmptyError;
                            }

                            // Basic email pattern
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(value)) {
                              return S.of(context).emailFieldValidationError;
                            }

                            return null;
                          },
                          fieldController: _emailController,
                          fieldFocusNode: _emailFocusNode,
                          onFieldSubmitted: (value) {
                            _emailFocusNode.unfocus();
                            FocusScope.of(
                              context,
                            ).requestFocus(_passwordFocusNode);
                          },
                          hint: S.of(context).emailFieldHint,
                          label: S.of(context).emailFieldLabel,
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).passwordFieldEmptyError;
                            }
                            if (value.length < 8) {
                              return S.of(context).passwordFieldLengthError;
                            }

                            return null; // valid password
                          },

                          fieldController: _passwordController,
                          fieldFocusNode: _passwordFocusNode,
                          onFieldSubmitted: (value) {
                            _passwordFocusNode.unfocus();
                          },
                          hint: S.of(context).passwordFieldHint,
                          label: S.of(context).passwordFieldLabel,
                        ),
                        SizedBox(height: size.height * 0.03),
                        BlocConsumer<AuthCubit, AuthState>(
                          listenWhen: (previous, current) =>
                              current is AuthFailure ||
                              current is Authenticated,
                          listener: (context, state) {
                            if (state is AuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMessage)),
                              );
                            } else if (state is Authenticated) {
                              print('Authenticated');
                              Navigator.of(context).pushNamed(AppRoutes.homeRoute);
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is AuthLoading ||
                              current is Authenticated,
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  minimumSize: Size(
                                    double.infinity,
                                    size.height * 0.06,
                                  ),
                                ),
                                child: CircularProgressIndicator.adaptive(
                                  valueColor: AlwaysStoppedAnimation(
                                    Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              );
                            } else if (state is Authenticated) {
                              return Column(
                                children: [
                                  Text(
                                    "You are already logged in",
                                    style: Theme.of(context).textTheme.bodyMedium!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      Navigator.of(context).pushNamed(AppRoutes.homeRoute);
                                    },
                                    child: Text(
                                      "go to home screen",
                                      style: Theme.of(context).textTheme.bodyMedium!
                                          .copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            fontWeight: FontWeight.bold
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              );
                            }

                            return ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthCubit>(context).login(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                minimumSize: Size(
                                  double.infinity,
                                  size.height * 0.06,
                                ),
                              ),
                              child: Text(
                                S.of(context).loginScreenTitle,
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                    ),
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              S.of(context).dontHaveAccount,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(AppRoutes.registerRoute);
                              },
                              child: Text(
                                S.of(context).signUp,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
