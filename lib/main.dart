import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlife/helpers/club_list.dart';
import 'package:nightlife/helpers/theme_data.dart';
import 'package:nightlife/language.dart';
import 'package:nightlife/other/custom_scroll_behavior.dart';
import 'package:nightlife/other/firebase_options.dart';
import 'package:nightlife/routing/custom_route_information_parser.dart';
import 'package:nightlife/routing/custom_router_delegate.dart';
import 'package:nightlife/widgets/gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

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
        ChangeNotifierProvider<CustomRouterDelegate>(create: (context) => CustomRouterDelegate()),
        ChangeNotifierProvider<ClubList>(create: (context) => ClubList()),
        ChangeNotifierProvider<Language>(create: (context) => Language()),
        /*Provider<AuthService>(create: (context) => AuthService()),
          StreamProvider<Person?>(
            create: (context) => context.read<AuthService>().authStateChanges,
            initialData: null,
          ),*/
      ],
      child: Builder(builder: (context) {
        return FutureBuilder(
            future: Future.wait([
              context.read<ClubList>().setup(),
              GoogleFonts.pendingFonts([
                GoogleFonts.baloo2(),
                GoogleFonts.gochiHand(),
              ]),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return MaterialApp(
                  title: 'Nightlife Zagreb - Find the best clubs in Zagreb',
                  theme: themeData,
                  home: const Scaffold(body: GradientBackground(child: Center(child: CircularProgressIndicator()))),
                ); //! ovo je jako hacky, treba smisliti bolje rjesenje 
              return MaterialApp.router(
                scrollBehavior: CustomScrollBehavior().copyWith(scrollbars: false),
                title: 'Nightlife Zagreb - Find the best clubs in Zagreb',
                debugShowCheckedModeBanner: false,
                routeInformationParser: CustomRouteInformationParser(),
                routerDelegate: context.read<CustomRouterDelegate>(),
                backButtonDispatcher: RootBackButtonDispatcher(),
                theme: themeData,
              );
            });
      }),
    );
  }
}
