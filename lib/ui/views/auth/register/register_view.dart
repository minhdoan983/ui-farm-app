import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_farm/resources/resources.dart';
import 'package:ui_farm/ui/ui.dart';

@RoutePage()
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends BasePageState<RegisterView, RegisterBloc> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    bloc.add(const RegisterViewInitiated());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Assets.images.thankYou.image(),
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Assets.images.logoPng.image(width: 100),
                        const SizedBox(height: 32),
                        AuthTextFieldWidget(
                          controller: _nameController,
                          hintText: S.current.username,
                          onChanged: (username) {
                            return bloc.add(RegisterNameTextFieldChanged(name: username));
                          },
                        ),
                        const SizedBox(height: 16),
                        AuthTextFieldWidget(
                          controller: _phoneController,
                          hintText: S.current.phoneNumber,
                          keyboardType: TextInputType.phone,
                          onChanged: (phoneNumber) {
                            return bloc.add(RegisterPhoneTextFieldChanged(phone: phoneNumber));
                          },
                        ),
                        const SizedBox(height: 16),
                        AuthTextFieldWidget(
                          controller: _emailController,
                          hintText: S.current.email,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (email) {
                            return bloc.add(RegisterEmailTextFieldChanged(email: email));
                          },
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<RegisterBloc, RegisterState>(
                          buildWhen: (previous, current) =>
                              previous.isPasswordVisible != current.isPasswordVisible,
                          builder: (context, state) => Column(
                            children: [
                              AuthTextFieldWidget(
                                controller: _passwordController,
                                hintText: S.current.password,
                                obscureText: !state.isPasswordVisible,
                                suffixIcon: GestureDetector(
                                  onTap: () => bloc.add(const RegisterPasswordVisibilityPressed()),
                                  child: Icon(
                                    state.isPasswordVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.brown.withValues(alpha: 0.5),
                                    size: 20,
                                  ),
                                ),
                                onChanged: (password) {
                                  return bloc.add(
                                    RegisterPasswordTextFieldChanged(password: password),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              AuthTextFieldWidget(
                                controller: _confirmPasswordController,
                                hintText: S.current.confirmPassword,
                                obscureText: !state.isPasswordVisible,
                                suffixIcon: GestureDetector(
                                  onTap: () => bloc.add(const RegisterPasswordVisibilityPressed()),
                                  child: Icon(
                                    state.isPasswordVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.brown.withValues(alpha: 0.5),
                                    size: 20,
                                  ),
                                ),
                                onChanged: (confirmPassword) {
                                  return bloc.add(
                                    RegisterConfirmPasswordTextFieldChanged(
                                      confirmPassword: confirmPassword,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        BlocBuilder<RegisterBloc, RegisterState>(
                          buildWhen: (previous, current) {
                            return previous.errorMessage != current.errorMessage;
                          },
                          builder: (context, state) {
                            if (state.errorMessage.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                state.errorMessage,
                                style: const TextStyle(color: Colors.red, fontSize: 13),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                        BlocConsumer<RegisterBloc, RegisterState>(
                          listenWhen: (previous, current) {
                            return previous.isRegisterSuccess != current.isRegisterSuccess;
                          },
                          listener: (context, state) {
                            if (state.isRegisterSuccess) {
                              context.replaceRoute(const MainRoute());
                            }
                          },
                          buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                          builder: (context, state) => ElevatedButton(
                            onPressed: state.isLoading
                                ? null
                                : () => bloc.add(const RegisterButtonPressed()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: backgroundPrimary,
                              fixedSize: const Size(280, 32),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: state.isLoading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.brown,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    S.current.signUp,
                                    style: const TextStyle(color: Colors.brown),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () => context.pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundPrimary,
                            fixedSize: const Size(280, 32),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            S.current.signIn,
                            style: const TextStyle(color: Colors.brown),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(S.current.footer),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
