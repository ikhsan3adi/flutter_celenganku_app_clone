import 'package:celenganku_app_clone/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<HomeScreenTab> _screens = [
    HomeScreenTab(
      tab: const Tab(text: 'Berlangsung'),
      screen: const OnGoingPage(),
      onTap: (BuildContext context) {
        context.read<OnGoingBloc>().add(FetchWishEvent());
      },
    ),
    HomeScreenTab(
      tab: const Tab(text: 'Tercapai'),
      screen: const AchievedPage(),
      onTap: (BuildContext context) {
        context.read<AchievedBloc>().add(FetchAchievedWishEvent());
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _screens.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.textTheme.bodyLarge!.color,
        title: const Text("Celenganku", style: TextStyle(fontWeight: FontWeight.normal)),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => _showChangeThemeDialog(),
            ),
            icon: const Icon(Icons.brightness_medium),
          ),
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(
                onTap: () {},
                child: const Text("Beri Nilai Aplikasi"),
              )
            ],
          )
        ],
        bottom: TabBar(
          labelColor: theme.colorScheme.primary,
          indicatorColor: theme.colorScheme.primary,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 48),
          indicatorWeight: 3,
          controller: _tabController,
          onTap: (value) {
            _screens[value].onTap.call(context);
          },
          tabs: _screens.map((e) => e.tab).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _screens.map((e) => e.screen).toList(),
      ),
    );
  }

  Widget _showChangeThemeDialog() {
    ThemeData theme = Theme.of(context);
    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text("Pilih Tema", style: TextStyle(fontSize: 24)),
            ),
            BlocBuilder<AppThemeCubit, AppThemeState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile(
                      value: ThemeMode.system,
                      groupValue: state.themeMode,
                      onChanged: (value) => Future(() => context.read<AppThemeCubit>().themeChanged(value!)).then((_) => Navigator.pop(context)),
                      title: const Text("Default"),
                    ),
                    RadioListTile(
                      value: ThemeMode.light,
                      groupValue: state.themeMode,
                      onChanged: (value) => Future(() => context.read<AppThemeCubit>().themeChanged(value!)).then((_) => Navigator.pop(context)),
                      title: const Text("Terang"),
                    ),
                    RadioListTile(
                      value: ThemeMode.dark,
                      groupValue: state.themeMode,
                      onChanged: (value) => Future(() => context.read<AppThemeCubit>().themeChanged(value!)).then((_) => Navigator.pop(context)),
                      title: const Text("Gelap"),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
