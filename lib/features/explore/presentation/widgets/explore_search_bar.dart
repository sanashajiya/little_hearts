import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/zone_cubit.dart';
import '../../../../core/theme/zone_theme.dart';

class ExploreSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const ExploreSearchBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.search, color: theme.dark, size: 30),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: 'Search names',
                  hintStyle: TextStyle(fontSize: 12, color: theme.dark),
                ),
                style: TextStyle(fontSize: 14, color: theme.dark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
