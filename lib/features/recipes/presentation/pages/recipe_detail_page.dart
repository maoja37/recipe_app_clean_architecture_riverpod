// lib/features/recipes/presentation/pages/recipe_detail_page.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_huto_test/core/constants/size.dart';
import 'package:recipe_huto_test/features/recipes/domain/entities/recipe_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailPage extends StatelessWidget {
  final RecipeEntity recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe.strMeal,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    //this is here because the text is white and sometimes its not visible on some images
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              background: CachedNetworkImage(
                imageUrl: recipe.strMealThumb ?? '',
                fit: BoxFit.cover,
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.restaurant,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                BuildInfoSection(recipe: recipe),
                const VerticalSpacing(24),
                BuildIngredientsSection(recipe: recipe),
                const VerticalSpacing(24),
                BuildInstructionsSection(recipe: recipe),
                const VerticalSpacing(24),
                BuildLinksSection(recipe: recipe),
                const VerticalSpacing(100), // Bottom padding
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildInfoSection extends StatelessWidget {
  final RecipeEntity recipe;
  const BuildInfoSection({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.strCategory != null) ...[
              BuildInfoRow(label: 'Category', value: recipe.strCategory!),
              const VerticalSpacing(8),
            ],
            if (recipe.strArea != null) ...[
              BuildInfoRow(label: 'Origin', value: recipe.strArea!),
              const VerticalSpacing(8),
            ],
            if (recipe.strTags != null && recipe.strTags!.isNotEmpty) ...[
              Text(
                'Tags',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const VerticalSpacing(4),
              Wrap(
                spacing: 8,
                children:
                    recipe.strTags!
                        .split(',')
                        .map(
                          (tag) => Chip(
                            label: Text(tag.trim()),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                        .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class BuildInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const BuildInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}

class BuildIngredientsSection extends StatelessWidget {
  final RecipeEntity recipe;
  const BuildIngredientsSection({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingredients',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const VerticalSpacing(16),
            ...List.generate(
              recipe.ingredients.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const HorizontalSpacing(12),
                    Expanded(
                      child: Text(
                        '${index < recipe.measures.length && recipe.measures[index].isNotEmpty ? '${recipe.measures[index]} ' : ''}${recipe.ingredients[index]}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildInstructionsSection extends StatelessWidget {
  final RecipeEntity recipe;
  const BuildInstructionsSection({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    if (recipe.strInstructions == null || recipe.strInstructions!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instructions',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const VerticalSpacing(16),
            Text(
              recipe.strInstructions!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildLinksSection extends StatelessWidget {
  final RecipeEntity recipe;
  const BuildLinksSection({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final hasYoutube =
        recipe.strYoutube != null && recipe.strYoutube!.isNotEmpty;
    final hasSource = recipe.strSource != null && recipe.strSource!.isNotEmpty;

    if (!hasYoutube && !hasSource) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Links',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const VerticalSpacing(16),
            if (hasYoutube) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _launchUrl(recipe.strYoutube!),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Watch on YouTube'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const VerticalSpacing(8),
            ],
            if (hasSource)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _launchUrl(recipe.strSource!),
                  icon: const Icon(Icons.link),
                  label: const Text('View Source'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
