import 'package:flutter/material.dart';
import 'package:recipe_app/common/widgets/widgets.dart';
import 'package:recipe_app/home/home.dart';

import 'widgets/widgets.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final _expandedHeight = 20.0;

  void Function() _onTapMenuOption(
    BuildContext context, {
    required String menuOption,
  }) {
    return () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              menuOption: menuOption,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _expandedHeight + kToolbarHeight,
        elevation: 0.0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              Text(
                'Menu',
                style: theme.textTheme.bodyText2!.copyWith(
                  fontSize: 24,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.shopping_cart,
                color: Colors.black,
                size: 24,
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: SearchField(
              isLoading: false,
              onChanged: (String string) {},
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          Stack(
            children: <Widget>[
              Container(
                height: screenHeight - 300,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 32),
                    MenuOptionItem(
                      title: 'Food',
                      imageUrl: 'https://picsum.photos/id/870/200/300',
                      totalItems: 120,
                      onTap: _onTapMenuOption(context, menuOption: 'Food'),
                    ),
                    const SizedBox(height: 16),
                    MenuOptionItem(
                      title: 'Beverages',
                      imageUrl: 'https://picsum.photos/200/300',
                      totalItems: 220,
                      onTap: _onTapMenuOption(context, menuOption: 'Beverages'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
