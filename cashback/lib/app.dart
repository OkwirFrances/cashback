import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/app_routes.dart';
import 'config/app_theme.dart';
import 'core/models/user_model.dart';
import 'data/datasources/remote/api_client.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'features/auth/logic/auth_controller.dart';

class CashbackApp extends StatelessWidget {
  const CashbackApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ApiClient()),
        Provider(
          create: (context) => AuthRepositoryImpl(
            apiClient: context.read<ApiClient>(),
          ),
        ),
        ChangeNotifierProxyProvider<AuthRepository, AuthController>(
          create: (context) => AuthController(
            authRepository: context.read<AuthRepository>(),
          ),
          update: (context, authRepo, authController) =>
              authController ?? AuthController(authRepository: authRepo),
        ),
        StreamProvider<UserModel?>(
          create: (context) => context.read<AuthController>().userStream,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Cashback Rewards',
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.getRoutes(context),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
