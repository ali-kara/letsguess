import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:letsguess/app/providers/theme_provider.dart';
import 'package:letsguess/app/providers/audio_provider.dart';
import 'package:letsguess/app/data/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Locale _selectedLocale = const Locale('tr');
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _selectedLocale = context.locale;
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          Text('theme'.tr()),
          const SizedBox(height: 8),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment(
                      value: ThemeMode.light, label: Text('light'.tr())),
                  ButtonSegment(
                      value: ThemeMode.dark, label: Text('dark'.tr())),
                  ButtonSegment(
                      value: ThemeMode.system, label: Text('system'.tr())),
                ],
                selected: <ThemeMode>{themeProvider.themeMode},
                onSelectionChanged: (s) {
                  themeProvider.setThemeMode(s.first);
                },
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'theme_description'.tr(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 32),
          Text('language'.tr()),
          const SizedBox(height: 8),
          DropdownButtonFormField<Locale>(
            value: _selectedLocale,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: [
              DropdownMenuItem(
                value: const Locale('tr'),
                child: Row(
                  children: [
                    const Text('🇹🇷'),
                    const SizedBox(width: 8),
                    Text('turkish'.tr()),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: const Locale('en'),
                child: Row(
                  children: [
                    const Text('🇺🇸'),
                    const SizedBox(width: 8),
                    Text('english'.tr()),
                  ],
                ),
              ),
            ],
            onChanged: (locale) {
              if (locale != null) {
                setState(() {
                  _selectedLocale = locale;
                });
                context.setLocale(locale);
              }
            },
          ),
          const SizedBox(height: 16),
          Text(
            'language_description'.tr(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 32),
          Text('audio'.tr()),
          const SizedBox(height: 8),
          Consumer<AudioProvider>(
            builder: (context, audioProvider, _) {
              return Column(
                children: [
                  SwitchListTile(
                    title: Text('background_music'.tr()),
                    subtitle: Text('background_music_description'.tr()),
                    value: audioProvider.isMusicEnabled,
                    onChanged: (value) {
                      audioProvider.toggleMusic();
                    },
                    secondary: Icon(
                      audioProvider.isMusicEnabled
                          ? Icons.music_note
                          : Icons.music_off,
                      color: audioProvider.isMusicEnabled
                          ? AppColors.accent
                          : Colors.grey,
                    ),
                  ),
                  SwitchListTile(
                    title: Text('sound_effects'.tr()),
                    subtitle: Text('sound_effects_description'.tr()),
                    value: audioProvider.isSoundEnabled,
                    onChanged: (value) {
                      audioProvider.toggleSound();
                    },
                    secondary: Icon(
                      audioProvider.isSoundEnabled
                          ? Icons.volume_up
                          : Icons.volume_off,
                      color: audioProvider.isSoundEnabled
                          ? AppColors.secondary
                          : Colors.grey,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
