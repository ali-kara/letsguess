import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HighScoresScreen extends StatelessWidget {
  const HighScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('high_scores'.tr()),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        separatorBuilder: (context, __) => Divider(
          height: 1,
          color: Theme.of(context).dividerColor.withOpacity(0.2),
        ),
        itemBuilder: (context, index) {
          final rank = index + 1;
          return ListTile(
            leading: CircleAvatar(child: Text('$rank')),
            title: Text('Oyuncu $rank'),
            trailing: Text('${(1000 - index * 23)}'),
          );
        },
      ),
    );
  }
}
