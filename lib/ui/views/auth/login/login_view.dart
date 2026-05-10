import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_farm/resources/resources.dart';
import 'package:ui_farm/ui/ui.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BasePageState<LoginView, LoginBloc> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                          controller: _emailController,
                          hintText: S.current.email,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => bloc.add(LoginEmailTextFieldChanged(email: value)),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<LoginBloc, LoginState>(
                          buildWhen: (previous, current) {
                            return previous.isPasswordVisible != current.isPasswordVisible;
                          },
                          builder: (context, state) => AuthTextFieldWidget(
                            controller: _passwordController,
                            hintText: S.current.password,
                            obscureText: !state.isPasswordVisible,
                            suffixIcon: GestureDetector(
                              onTap: () => bloc.add(const LoginPasswordVisibilityPressed()),
                              child: Icon(
                                state.isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.brown.withValues(alpha: 0.5),
                                size: 20,
                              ),
                            ),
                            onChanged: (value) =>
                                bloc.add(LoginPasswordTextFieldChanged(password: value)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        BlocBuilder<LoginBloc, LoginState>(
                          buildWhen: (p, c) => p.errorMessage != c.errorMessage,
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
                        BlocConsumer<LoginBloc, LoginState>(
                          listenWhen: (previous, current) {
                            return previous.isLoginSuccess != current.isLoginSuccess;
                          },
                          listener: (context, state) {
                            if (state.isLoginSuccess) {
                              context.replaceRoute(const MainRoute());
                            }
                          },
                          buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                          builder: (context, state) => ElevatedButton(
                            onPressed: state.isLoading
                                ? null
                                : () => bloc.add(const LoginButtonPressed()),
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
                                    S.current.signIn,
                                    style: const TextStyle(color: Colors.brown),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () => context.pushRoute(const RegisterRoute()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundPrimary,
                            fixedSize: const Size(280, 32),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            S.current.signUp,
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
