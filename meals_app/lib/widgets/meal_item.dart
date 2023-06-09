import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });
  final Meal meal;
  final void Function( Meal meal) onSelectMeal;
  String get complexityTest {
    return meal.complexity.name[0]
            .toUpperCase() + // The name is a string containing the source identifier used to declare the enum value.
        // meal.complexity.name refers to the name property of the complexity property.
        meal.complexity.name.substring(
            1); // we have appended string to get first letter as capital
  }

  String get affordabilityTest {
    return meal.affordability.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      // / clipBehavior is necessary because, without it, the InkWell's animation
      // will extend b/eyond the rounded edges of the [Card]
      // stack ki bboundary rounde3d nnahin hain aur agar clip behaviour use kar rahen toh stack ke children
      // ka border rounded rectangle ho jaa rahan jo above mentioned hain
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
// FadeInImage When displaying images using the default Image widget, you might notice they simply pop onto the screen as they’re loaded. This might feel visually jarring to your users.
// Instead, wouldn’t it be nice to display a placeholder at first, and images would fade in as they’re loaded? Use the FadeInImage widget for exactly this purpose.
// FadeInImage works with images of any type: in-memory, local assets, or images from the internet.

//The MemoryImage class in Flutter is a class that represents an image loaded from bytes in memory.
//It allows you to display an image in Flutter that is loaded from a Uint8List or List<int> containing the raw bytes of the image.

            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    // In Flutter, the softWrap property is used in the Text widget to control whether
                    // the text should wrap to the next line when it reaches the edge of its container.
                    //It determines whether the text should break and create a new line or overflow beyond the container's boundaries.
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow
                          .ellipsis, // Very long text ko ... kar dega after 2 lines
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min'),
                        const SizedBox(width: 12),
                        MealItemTrait(icon: Icons.work, label: complexityTest),
                        const SizedBox(width: 12),
                        MealItemTrait(
                            icon: Icons.attach_money, label: affordabilityTest),
                      ],
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
