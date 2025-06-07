import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../data/datasources/remote/api_client.dart';
import '../data/datasources/local/local_storage.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/cashback_repository.dart';
import '../data/providers/auth_provider.dart';
import '../data/providers/wallet_provider.dart';
import '../data/providers/deals_provider.dart';

class DependencyInjection {
  static MultiProvider init() {
    return MultiProvider(
      providers: [
        // Services
        Provider(create: (_) => ApiClient()),
        Provider(create: (_) => LocalStorage()),

        // Repositories
        Provider(
          create: (context) => AuthRepository(
            context.read<ApiClient>(),
            context.read<LocalStorage>(),
          ),
        ),
        Provider(
          create: (context) => CashbackRepository(
            context.read<ApiClient>(),
            context.read<
                ApiClient>(), // Assuming MomoService is implemented in ApiClient
          ),
        ),

        // Providers (State Management)
        ChangeNotifierProxyProvider<AuthRepository, AuthProvider>(
          create: (context) => AuthProvider(context.read<AuthRepository>()),
          update: (context, authRepo, authProvider) =>
              authProvider ?? AuthProvider(authRepo),
        ),
        ChangeNotifierProxyProvider<CashbackRepository, WalletProvider>(
          create: (context) =>
              WalletProvider(context.read<CashbackRepository>()),
          update: (context, cashbackRepo, walletProvider) =>
              walletProvider ?? WalletProvider(cashbackRepo),
        ),
        ChangeNotifierProxyProvider<CashbackRepository, DealsProvider>(
          create: (context) =>
              DealsProvider(context.read<CashbackRepository>()),
          update: (context, cashbackRepo, dealsProvider) =>
              dealsProvider ?? DealsProvider(cashbackRepo),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
