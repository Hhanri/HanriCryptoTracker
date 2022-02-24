import 'package:crypto_tracker/pages/browse_page.dart';
import 'package:crypto_tracker/porviders/providers.dart';
import 'package:crypto_tracker/porviders/search_notifier.dart';
import 'package:crypto_tracker/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget{
  final bool isHome;
  const AppBarWidget({
    Key? key,
    required this.isHome
  }) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final SearchModel searching = ref.watch(searchIdProvider);
        return AppBar(
          automaticallyImplyLeading: false,
          leading: isHome ? null : const AppBarGoBackIconButton(),
          title: searching.isSearching
            ? TextField(
                focusNode: focusNode,
                enableSuggestions: false,
                maxLines: 1,
                autocorrect: false,
                onChanged: (value) {
                  ref.watch(searchIdProvider.notifier).searchId(value);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: TitleStrings.searchId,
                ),
              )
            : isHome
              ? const Text(SystemStrings.appTitle)
              : const Text(SystemStrings.browseTitle),
            elevation: 0,
            actions: [
            IconButton(
              onPressed: () {
                ref.watch(searchIdProvider.notifier).openSearchBar();
                if (searching.isSearching) {
                  focusNode.unfocus();
                } else {
                  focusNode.requestFocus();
                }
              },
              icon: searching.isSearching
                ? const Icon(Icons.clear)
                : const Icon(Icons.search)
            ),
            AppBarAddButtonWidget(
              isVisible: isHome
                ? searching.isSearching
                  ? false
                  : true
                : false
            )
          ],
        );
      }
    );
  }
}

class AppBarGoBackIconButton extends StatelessWidget {
  const AppBarGoBackIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final SearchModel searching = ref.watch(searchIdProvider);
        return IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (searching.isSearching) {
              ref.watch(searchIdProvider.notifier).openSearchBar();
            }
            Navigator.of(context).pop();
          },
        );
      }
    );
  }
}


class AppBarAddButtonWidget extends StatelessWidget {
  final bool isVisible;
  const AppBarAddButtonWidget({
    Key? key,
    required this.isVisible
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const BrowseScreen())
          );
        },
        icon: const Icon(Icons.add)
      ),
    );
  }
}
