import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'helpers/primary_swatch.dart';
import 'other/custom_scroll_behavior.dart';
import 'other/firebase_options.dart';
import 'routing/custom_route_information_parser.dart';
import 'routing/custom_router_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Nightlife());
}

class Nightlife extends StatelessWidget {
  const Nightlife({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CustomRouteInformationParser>(
          create: (context) => CustomRouteInformationParser(),
        ),
        ListenableProvider<CustomRouterDelegate>(
          create: (context) => CustomRouterDelegate(),
        ),
        ChangeNotifierProvider<ClubList>(create: (context) => ClubList()),
        Provider<AuthService>(
          create: (context) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider<User?>(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: Builder(builder: (context) {
        return FutureBuilder(
            future: context.read<ClubList>().setup(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator(color: primaryColor));
              return MaterialApp.router(
                scrollBehavior: CustomScrollBehavior(),
                title: 'Nightlife Zagreb',
                debugShowCheckedModeBanner: false,
                routeInformationParser: context.read<CustomRouteInformationParser>(),
                routerDelegate: context.read<CustomRouterDelegate>(),
                backButtonDispatcher: RootBackButtonDispatcher(),
                theme: ThemeData(
                  fontFamily: 'Roboto',
                  primarySwatch: primarySwatch,
                  //brightness: Brightness.dark,
                ),
              );
            });
      }),
    );
  }
}
