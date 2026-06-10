import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/data/datasource/weather_local_datasource.dart';
import 'package:weather_app/features/weather/data/datasource/weather_remote_datasource.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_usecase.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('weather_box');
  final box = Hive.box('weather_box');

  final repository = WeatherRepositoryImpl(
    remote: WeatherRemoteDataSource(),
    local: WeatherLocalDataSource(box),
  );

  final getWeatherUseCase = GetWeatherUseCase(repository);

  final localDataSource = WeatherLocalDataSource(box);

  runApp(
    MyApp(
      getWeatherUseCase: getWeatherUseCase,
      localDataSource: localDataSource,
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetWeatherUseCase getWeatherUseCase;
  final WeatherLocalDataSource localDataSource;

  const MyApp({
    super.key,
    required this.getWeatherUseCase,
    required this.localDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = WeatherProvider(getWeatherUseCase, localDataSource);

        provider.loadRecentSearches();

        return provider;
      },

      child: Consumer<WeatherProvider>(
        builder: (context, provider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),

            darkTheme: ThemeData(
              brightness: Brightness.dark,
              textTheme: GoogleFonts.montserratTextTheme(
                ThemeData.dark().textTheme,
              ),
            ),

            themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

            home: const WeatherPage(),
          );
        },
      ),
    );
  }
}
