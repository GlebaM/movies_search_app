import 'package:flutter/material.dart';

import '../../../data/models/movie_summary.dart';

class MovieSearchList extends StatelessWidget {
  const MovieSearchList({
    super.key,
    required this.results,
    required this.onMovieTap,
  });

  final List<MovieSummary> results;
  final void Function(MovieSummary movie) onMovieTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final movie = results[index];
        return _MovieCard(movie: movie, onTap: () => onMovieTap(movie));
      },
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({required this.movie, required this.onTap});

  final MovieSummary movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final posterUrl = movie.poster.toLowerCase() == 'n/a' ? null : movie.poster;

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: posterUrl != null
                    ? Image.network(
                        posterUrl,
                        width: 72,
                        height: 108,
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) =>
                            _PosterPlaceholder(theme),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            width: 72,
                            height: 108,
                            child: Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      )
                    : _PosterPlaceholder(theme),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      movie.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(movie.year, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(movie.type.toUpperCase()),
                      backgroundColor: theme.colorScheme.tertiaryContainer,
                      labelStyle: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onTertiaryContainer,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _PosterPlaceholder extends StatelessWidget {
  const _PosterPlaceholder(this.theme);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 108,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      child: Icon(
        Icons.local_movies_outlined,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
