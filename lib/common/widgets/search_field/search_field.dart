import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.isLoading,
    required void Function(String) onChanged,
  })  : _onChanged = onChanged,
        super(key: key);

  final bool isLoading;

  final void Function(String) _onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(32),
      clipBehavior: Clip.antiAlias,
      child: TextField(
        style: theme.textTheme.bodyText2,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(horizontal: 40),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade800,
            size: 32,
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Search food',
          hintStyle: theme.textTheme.bodyText2!.copyWith(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        autocorrect: false,
        onChanged: _onChanged,
      ),
    );
  }
}
