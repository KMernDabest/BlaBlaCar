import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../theme/theme.dart';
import './location_tile.dart';

class LocationPicker extends StatefulWidget {
  
  final List<Location> locations;
  final Location? selected;
  final void Function(Location)? onLocationSelected;

  const LocationPicker({
    super.key,
    required this.locations,
    this.selected,
    this.onLocationSelected,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  
  late List<Location> filteredLocations;
  
  String search = '';

  @override
  void initState() {
    super.initState();
    filteredLocations = widget.locations;
  }

  void _onSearchChanged(String locationSearched) {
    setState(() {
      search = locationSearched;
      filteredLocations = widget.locations
          .where(
            (l) =>
                l.name.toLowerCase().contains(locationSearched.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: BlaColors.greyLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: BlaSpacings.s),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search location...',
                    border: InputBorder.none,
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: filteredLocations.length,
        itemBuilder: (context, index) {
          final location = filteredLocations[index];
          return LocationTile(
            location: location,
            onTap: () {
              widget.onLocationSelected?.call(location);
              Navigator.pop(context, location);
            },
          );
        },
      ),
    );
  }
}