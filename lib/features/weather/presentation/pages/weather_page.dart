import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/empty_state.dart';
import 'package:weather_app/features/weather/presentation/widgets/recent_searches.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_card.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_shimmer.dart';

import '../provider/weather_provider.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74ebd5), Color(0xFFACB6E5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<WeatherProvider>().refreshWeather();
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        _topBar(provider, context),
                        _searchBar(context, provider),
                        if (provider.recentSearches.isNotEmpty)
                          Row(children: [recentSearches(context)])
                        else
                          const SizedBox(),

                        SizedBox(height: 16),

                        if (provider.weather == null && !provider.isLoading)
                          EmptyState()
                        else if (provider.isLoading)
                          const WeatherShimmer()
                        else
                          weatherCard(provider),

                        if (provider.isFromCache)
                          Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 10),
                            color: Colors.orange.shade100,

                            child: const Text(
                              "Showing cached data (offline or API failed)",
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _topBar(WeatherProvider provider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Weather App",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                provider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: provider.toggleTheme,
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar(BuildContext context, WeatherProvider provider) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: TextField(
        controller: provider.searchController,
        textInputAction: TextInputAction.search,
        onSubmitted: (city) async {
          final value = city.trim();

          if (value.isNotEmpty) {
            await provider.searchWeather(value);

            if (context.mounted && provider.error != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(provider.error!)));
            }
          }
        },
        decoration: InputDecoration(
          hintText: "Search city...",
          prefixIcon: const Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
