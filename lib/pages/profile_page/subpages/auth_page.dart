import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlife/model/person.dart';
import 'package:nightlife/pages/profile_page/input_field.dart';
import 'package:nightlife/pages/profile_page/profile_action_button.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:nightlife/services/auth_service.dart';
import 'package:nightlife/widgets/custom_material_page.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key,
    required this.isLogin,
    required this.title,
    required this.message,
    required this.swapQuestion,
    required this.swapAction,
  });

  final bool isLogin;
  final String title;
  final String message;
  final String swapQuestion;
  final String swapAction;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = context.read<AuthService>();
    CustomRouterDelegate router = context.read<CustomRouterDelegate>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => router.goBack(),
          splashRadius: 0.1,
        ),
        titleSpacing: 0,
        title: Text(widget.title),
      ),
      body: GradientBackground(
        child: StreamBuilder<Person?>(
            stream: auth.authStateChanges,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) => router.goToProfile());
                return const SizedBox.shrink();
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      widget.message,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    const SizedBox(height: 80),
                    SizedBox(
                      width: 320,
                      child: Column(
                        children: [
                          if (!widget.isLogin) ...[
                            InputField(
                              controller: _name,
                              labelText: 'Name',
                              icon: const Icon(Icons.person),
                            ),
                            const SizedBox(height: 20),
                          ],
                          InputField(
                            controller: _email,
                            labelText: 'Email',
                            icon: const Icon(Icons.email),
                          ),
                          const SizedBox(height: 20),
                          InputField(
                            controller: _password,
                            labelText: 'Password',
                            icon: const Icon(Icons.lock),
                            obscureText: true,
                          ),
                          if (widget.isLogin)
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text("Forgot your password?"),
                              ),
                            )
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Column(
                      children: [
                        ProfileActionButton(
                          width: 310,
                          action: () => widget.isLogin
                              ? auth.signIn(email: _email.text, password: _password.text)
                              : auth.signUp(email: _email.text, password: _password.text, name: _name.text),
                          label: Text(widget.title.toUpperCase()),
                        ),
                        const SizedBox(height: 20),
                        ProfileActionButton(
                          width: 310,
                          action: () => auth.signInWithGoogle(),
                          backgroundColor: Colors.white,
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    TextButton(
                      onPressed: () => widget.isLogin ? router.goToSignup() : router.goToLogin(),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: widget.swapQuestion),
                            TextSpan(
                              text: widget.swapAction,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
