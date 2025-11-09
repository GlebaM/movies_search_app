import 'package:flutter/material.dart';

class MovieSearchEmpty extends StatelessWidget {
  const MovieSearchEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.search_off, size: 64, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text('No movies found', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Try a different title or check your spelling.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
