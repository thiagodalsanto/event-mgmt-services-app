import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class LocationSearchBar extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final List<String> locationSuggestions;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final Function(String) onSuggestionSelected;

  const LocationSearchBar({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.onFieldSubmitted,
    required this.locationSuggestions,
    required this.onSuggestionSelected,
    this.onChanged,
  });

  @override
  LocationSearchBarState createState() => LocationSearchBarState();
}

class LocationSearchBarState extends State<LocationSearchBar> {
  bool _showClearButton = false;
  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateClearButton);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateClearButton);
    super.dispose();
  }

  void _updateClearButton() {
    setState(() {
      _showClearButton = widget.controller.text.isNotEmpty;
      _filterSuggestions(widget.controller.text);
    });
  }

  void _filterSuggestions(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredSuggestions = [];
      });
      return;
    }

    setState(() {
      _filteredSuggestions = widget.locationSuggestions
          .where((location) => location.toLowerCase().contains(query.toLowerCase()))
          .take(5)
          .toList();
    });
  }

  void _clearSearch() {
    widget.controller.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      _filteredSuggestions = [];
      _showClearButton = false;
    });
  }

  void _selectSuggestion(String location) {
    widget.controller.text = location;
    widget.onSuggestionSelected(location);
    setState(() {
      _filteredSuggestions = [];
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            CustomTextField(
              onFieldSubmitted: widget.onFieldSubmitted,
              focusNode: widget.focusNode,
              controller: widget.controller,
              label: 'Buscar eventos por localização...',
              icon: Icons.location_on,
              isPassword: false,
              borderRadius: _filteredSuggestions.isNotEmpty
                  ? BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )
                  : BorderRadius.circular(25),
              onChanged: (value) {
                widget.onChanged?.call(value);
                _filterSuggestions(value);
              },
            ),
            if (_showClearButton)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: _clearSearch,
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ),
          ],
        ),
        if (_filteredSuggestions.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: _filteredSuggestions
                  .map(
                    (location) => ListTile(
                      title: Text(
                        location,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () => _selectSuggestion(location),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
