import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_huto_test/core/constants/size.dart';
import 'package:recipe_huto_test/features/recipes/domain/entities/recipe_entity.dart';
import 'package:recipe_huto_test/features/recipes/presentation/pages/recipe_detail_page.dart';

import 'package:recipe_huto_test/l10n/app_localizations.dart';

class RecipeCard extends StatelessWidget {
  final RecipeEntity recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(recipe: recipe),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // this is here so we can have rounded corners on the image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: recipe.strMealThumb ?? '',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                //fallback widget in case image fails to load
                errorWidget: (context, url, error) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.restaurant,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            //recipe information section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //recipe title
                  Text(
                    recipe.strMeal,
                    style: Theme.of(context).textTheme.titleLarge,
                    // this handles overflow for long ass titles
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const VerticalSpacing(8),
                  //conditional category display
                  if (recipe.strCategory != null)
                    Chip(
                      label: Text(recipe.strCategory!),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  //conditional origin area display
                  if (recipe.strArea != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        l10n.originFrom(recipe.strArea ?? ""),
                        style: Theme.of(context).textTheme.bodyMedium,
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
