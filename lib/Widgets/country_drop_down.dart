import 'package:flutter/material.dart';

class CountryDropDown extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final String initialCountry; // Add initialCountry

  const CountryDropDown({
    super.key,
    required this.onCountryChanged,
    required this.initialCountry, // Add initialCountry to constructor
  });

  @override
  _CountryDropDownState createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  String? selectedCountry;

  final List<Map<String, String>> countries = [
    {'name': 'Egypt', 'flag': '🇪🇬'},
    {'name': 'USA', 'flag': '🇺🇸'},
    {'name': 'UK', 'flag': '🇬🇧'},
    {'name': 'Saudi Arabia', 'flag': '🇸🇦'},
    {'name': 'Emirates', 'flag': '🇦🇪'},
    {'name': 'Qatar', 'flag': '🇶🇦'},
    {'name': 'France', 'flag': '🇫🇷'},
    {'name': 'Germany', 'flag': '🇩🇪'},
    {'name': 'Canada', 'flag': '🇨🇦'},
    {'name': 'Australia', 'flag': '🇦🇺'},
    {'name': 'India', 'flag': '🇮🇳'},
    {'name': 'Japan', 'flag': '🇯🇵'},
    {'name': 'South Korea', 'flag': '🇰🇷'},
    {'name': 'Brazil', 'flag': '🇧🇷'},
    {'name': 'Mexico', 'flag': '🇲🇽'},
    {'name': 'Italy', 'flag': '🇮🇹'},
    {'name': 'Spain', 'flag': '🇪🇸'},
    {'name': 'Russia', 'flag': '🇷🇺'},
    {'name': 'China', 'flag': '🇨🇳'},
    {'name': 'Turkey', 'flag': '🇹🇷'},
  ];

  @override
  void initState() {
    super.initState();
    selectedCountry = widget.initialCountry;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: selectedCountry,
        onChanged: (value) {
          setState(() {
            selectedCountry = value;
            widget.onCountryChanged(value!);
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Country is required';
          }
          return null;
        },
        decoration: const InputDecoration(labelText: 'Country'),
        items: countries.map((country) {
          return DropdownMenuItem<String>(
            value: country['name'],
            child: Row(
              children: [
                Text(
                  country['flag']!,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 10),
                Text(country['name']!),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
