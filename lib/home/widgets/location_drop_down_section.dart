import 'package:flutter/material.dart';

class LocationDropDownSection extends StatelessWidget {
  const LocationDropDownSection({
    Key? key,
    required void Function() onTap,
  })  : _onTap = onTap,
        super(key: key);

  final void Function() _onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: _onTap,
        child: SizedBox(
          width: screenWidth / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Delivering to',
                style: theme.textTheme.caption,
              ),
              const SizedBox(height: 2),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Current Location',
                      style: theme.textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // const Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 20,
                    color: Colors.red.shade700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
