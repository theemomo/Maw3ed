import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/route/app_routes.dart';
import 'package:maw3ed/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:maw3ed/features/auth/presentation/widgets/text_field_widget.dart';
import 'package:maw3ed/generated/l10n.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

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
                padding: EdgeInsets.only(bottom: size.width * 0.35),
                child: Center(
                  child: Text(
                    S.of(context).registerScreenTitle,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.18),
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
                        // Name Field
                        TextFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).nameFieldEmptyError;
                            }

                            // Allow only letters and spaces (no numbers or special chars)
                            final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
                            if (!nameRegex.hasMatch(value)) {
                              return S.of(context).nameFieldOnlyLettersError;
                            }

                            // minimum length
                            if (value.trim().length < 3) {
                              return S.of(context).nameFieldMinLengthError;
                            }
                            return null;
                          },
                          fieldController: _nameController,
                          fieldFocusNode: _nameFocusNode,
                          onFieldSubmitted: (value) {
                            _nameFocusNode.unfocus();
                            FocusScope.of(
                              context,
                            ).requestFocus(_emailFocusNode);
                          },
                          hint: S.of(context).nameFieldHint,
                          label: S.of(context).nameFieldLabel,
                        ),
                        SizedBox(height: size.height * 0.03),

                        // Email Field
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

                        // Password Field
                        TextFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).passwordFieldEmptyError;
                            }
                            if (value.length < 8) {
                              return S.of(context).passwordFieldLengthError;
                            }

                            // Check for at least one uppercase letter
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return S.of(context).passwordFieldUppercaseError;
                            }

                            // Check for at least one lowercase letter
                            if (!RegExp(r'[a-z]').hasMatch(value)) {
                              return S.of(context).passwordFieldLowercaseError;
                            }

                            // Check for at least one digit
                            if (!RegExp(r'[0-9]').hasMatch(value)) {
                              return S.of(context).passwordFieldDigitError;
                            }

                            // Check for at least one special character
                            if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                              return S
                                  .of(context)
                                  .passwordFieldSpecialCharError;
                            }

                            return null; // valid password
                          },

                          fieldController: _passwordController,
                          fieldFocusNode: _passwordFocusNode,
                          onFieldSubmitted: (value) {
                            _passwordFocusNode.unfocus();
                            FocusScope.of(
                              context,
                            ).requestFocus(_confirmPasswordFocusNode);
                          },
                          hint: S.of(context).passwordFieldHint,
                          label: S.of(context).passwordFieldLabel,
                        ),
                        SizedBox(height: size.height * 0.03),

                        // Confirm Password Field
                        TextFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).passwordFieldEmptyError;
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }

                            return null; // valid password
                          },

                          fieldController: _confirmPasswordController,
                          fieldFocusNode: _confirmPasswordFocusNode,
                          onFieldSubmitted: (value) {
                            _confirmPasswordFocusNode.unfocus();
                          },
                          hint: S.of(context).confirmPasswordFieldHint,
                          label: S.of(context).confirmPasswordFieldLabel,
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
                              print('Account Created');
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.loginRoute);
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is AuthLoading ,
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
                            }
                            return ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthCubit>(context).register(
                                    _nameController.text,
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
                                S.of(context).registerScreenTitle,
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
                              S.of(context).alreadyHaveAccount,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                S.of(context).signIn,
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
