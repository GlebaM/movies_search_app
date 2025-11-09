import 'package:flutter/material.dart';

import '../../../data/models/movie_detail.dart';
import '../../../data/models/movie_rating.dart';

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({super.key, required this.movie});

  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final posterUrl = movie.poster.toLowerCase() == 'n/a' ? null : movie.poster;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (posterUrl != null)
              AspectRatio(
                aspectRatio: 2 / 3,
                child: Image.network(
                  posterUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) => _PosterFallback(theme: theme),
                ),
              )
            else
              _PosterFallback(theme: theme),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movie.title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: <Widget>[
                      _InfoChip(label: movie.year),
                      _InfoChip(label: movie.rated),
                      _InfoChip(label: movie.runtime),
                      _InfoChip(label: movie.genre),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _Section(title: 'Plot', body: movie.plot),
                  _Section(title: 'Director', body: movie.director),
                  _Section(title: 'Writers', body: movie.writer),
                  _Section(title: 'Cast', body: movie.actors),
                  _Section(title: 'Awards', body: movie.awards),
                  _Section(title: 'Language', body: movie.language),
                  _Section(title: 'Country', body: movie.country),
                  const SizedBox(height: 24),
                  if (movie.ratings.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Ratings', style: theme.textTheme.titleLarge),
                        const SizedBox(height: 12),
                        ...movie.ratings.map(
                          (rating) => _RatingTile(rating: rating),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  _HighlightCard(
                    title: 'IMDb Rating',
                    value: movie.imdbRating,
                    subtitle: '${movie.imdbVotes} votes',
                    icon: Icons.star_rate_rounded,
                  ),
                  if (movie.boxOffice.toLowerCase() != 'n/a')
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: _HighlightCard(
                        title: 'Box Office',
                        value: movie.boxOffice,
                        icon: Icons.attach_money,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PosterFallback extends StatelessWidget {
  const _PosterFallback({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.local_movies_outlined,
        size: 96,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(body, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _RatingTile extends StatelessWidget {
  const _RatingTile({required this.rating});

  final MovieRating rating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Text(
          rating.value.split('/').first,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(rating.source, style: theme.textTheme.titleMedium),
      subtitle: Text(rating.value, style: theme.textTheme.bodyMedium),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle,
  });

  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 40, color: theme.colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null) ...<Widget>[
                    const SizedBox(height: 4),
                    Text(subtitle!, style: theme.textTheme.bodyMedium),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
