import 'package:web_2/core/config/const.dart';

import '../component/widget/searchable_dropdown/src/material/typeahead_field.dart';

class SearchableDropdownTypeAhead extends StatefulWidget {
  @override
  _SearchableDropdownTypeAheadState createState() =>
      _SearchableDropdownTypeAheadState();
}

class _SearchableDropdownTypeAheadState
    extends State<SearchableDropdownTypeAhead> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode focus_node = FocusNode();
  // Sample list of countries with id and name
  final List<Country> countries = [
    Country(id: '1', name: 'Brazil'),
    Country(id: '2', name: 'France'),
    Country(id: '3', name: 'Germany'),
    Country(id: '4', name: 'Italy'),
    Country(id: '5', name: 'United States'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TypeAheadField<Country>(
              controller: _controller,
              suggestionsCallback: (search) => _getSuggestions(search),
              builder: (context, controller, focusNode) {
                return CustomTextBox(
                  controller: controller,
                  focusNode: focusNode,
                );
              },
              decorationBuilder: (context, child) => Material(
                type: MaterialType.card,
                elevation: 4,
                borderRadius: BorderRadius.circular(2),
                child: child,
              ),
              itemBuilder: (context, c) {
                return Row(
                  children: [
                    Text(c.id),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(child: Text(c.name))
                  ],
                );
              },
              onSelected: (city) {
                print(city.name);
                _controller.text = city.name;
                // Navigator.of(context).push<void>(
                //   MaterialPageRoute(
                //     builder: (context) => CityPage(city: city),
                //   ),
                // );
              },
            ),
            Text("data"),
            CustomTextBox(controller: TextEditingController())
          ],
        ),
      ),
    );
  }

  void handleKeyPress_search(RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      final currentIndex = 5;
      final nextIndex = currentIndex + 1;

      // if (nextIndex < list_item_temp.length) {
      //   selectedIndex.value = nextIndex.toString();
      //   selectedItem.value = list_item_temp[nextIndex];
      // }
      focus_node.requestFocus();
      return;
    }
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      // final currentIndex = int.tryParse(selectedIndex.value) ?? 1;
      //final nextIndex = currentIndex - 1;

      // if (nextIndex < list_item_temp.length && nextIndex != -1) {
      //   selectedIndex.value = nextIndex.toString();
      //   selectedItem.value = list_item_temp[nextIndex];
      // }
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      // final currentPosition = txt_search_name.selection.baseOffset;
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   txt_search_name.selection = TextSelection.fromPosition(
      //     TextPosition(offset: currentPosition),
      //   );
      // });
      return;
    }
  }

  // Function to get filtered suggestions
  List<Country> _getSuggestions(String query) {
    return countries
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

@immutable
class Country {
  final String id;
  final String name;

  Country({required this.id, required this.name});

  @override
  String toString() => name; // This is displayed in the suggestions
}
