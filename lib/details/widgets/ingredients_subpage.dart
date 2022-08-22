import 'package:flutter/material.dart';
import 'package:recipe_app/details/widgets/widgets.dart';
import 'package:recipe_app/models/models.dart';

class IngredientsSubpage extends StatefulWidget {
  const IngredientsSubpage({
    Key? key,
    required this.meal,
    required this.numberOfServings,
    required void Function() onPressedIncrement,
    required void Function() onPressedDecrement,
  })  : _onPressedIncrement = onPressedIncrement,
        _onPressedDecrement = onPressedDecrement,
        super(key: key);

  final Food meal;
  final int numberOfServings;
  final void Function() _onPressedIncrement;
  final void Function() _onPressedDecrement;

  @override
  _IngredientsSubpageState createState() => _IngredientsSubpageState();
}

class _IngredientsSubpageState extends State<IngredientsSubpage>
    with AutomaticKeepAliveClientMixin<IngredientsSubpage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: _buildBody(context),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Ingredients for',
                    style: theme.textTheme.bodyText2!.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.numberOfServings} ' +
                        (widget.numberOfServings > 1 ? 'servings' : 'serving'),
                    style: theme.textTheme.bodyText2!.copyWith(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  onTap: widget._onPressedDecrement,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${widget.numberOfServings}',
                style: theme.textTheme.bodyText2!.copyWith(
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  onTap: widget._onPressedIncrement,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          IngredientItem(
            ingredient: widget.meal.strIngredient1,
            measurement: widget.meal.strMeasure1,
          ),
          const SizedBox(height: 16),
          IngredientItem(
            ingredient: widget.meal.strIngredient2,
            measurement: widget.meal.strMeasure2,
          ),
          const SizedBox(height: 16),
          IngredientItem(
            ingredient: widget.meal.strIngredient3,
            measurement: widget.meal.strMeasure3,
          ),
          const SizedBox(height: 16),
          IngredientItem(
            ingredient: widget.meal.strIngredient4,
            measurement: widget.meal.strMeasure4,
          ),
          const SizedBox(height: 16),
          IngredientItem(
            ingredient: widget.meal.strIngredient5,
            measurement: widget.meal.strMeasure5,
          ),
          const SizedBox(height: 16),
          IngredientItem(
            ingredient: widget.meal.strIngredient6,
            measurement: widget.meal.strMeasure6,
          ),
        ],
      ),
    );
  }
}
