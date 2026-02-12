import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../widgets/bla_button.dart';
import '../../../../services/locations_service.dart';
import '../../../theme/theme.dart';
import '../../../../utils/date_time_utils.dart';
import '../../../widgets/display/bla_divider.dart';
import 'form_picker.dart';
import 'location_picker.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void _onDeparturePressed() async {
    final Location? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPicker(
          locations: LocationsService.availableLocations,
          selected: departure,
        ),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void _onArrivalPressed() async {
    final Location? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPicker(
          locations: LocationsService.availableLocations,
          selected: arrival,
        ),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void _onDatePressed() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime(2026),
      lastDate: DateTime(2027),
    );

    if (pickedDate != null) {
      setState(() {
        departureDate = pickedDate;
      });
    }
  }

  void _onSeatsPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Number of passengers', style: BlaTextStyles.heading),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline, size: 32),
                onPressed: requestedSeats > 1
                    ? () {
                        setDialogState(() {
                          setState(() {
                            requestedSeats--;
                          });
                        });
                      }
                    : null,
                color: BlaColors.primary,
              ),
              SizedBox(width: BlaSpacings.l),
              Text(
                '$requestedSeats',
                style: BlaTextStyles.heading,
              ),
              SizedBox(width: BlaSpacings.l),
              IconButton(
                icon: Icon(Icons.add_circle_outline, size: 32),
                onPressed: () {
                  setDialogState(() {
                    setState(() {
                      requestedSeats++;
                    });
                  });
                },
                color: BlaColors.primary,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Done', style: TextStyle(color: BlaColors.primary)),
          ),
        ],
      ),
    );
  }

  /// Swap the departure and arrival locations
  void _onSwapLocation() {
    if (departure != null || arrival != null) {
      setState(() {
        final temp = departure;
        departure = arrival;
        arrival = temp;
      });
    }
  }

  void _onSearchPressed() {
    // Validate form
    if (departure == null || arrival == null) {
      return;
    }

    final ridePref = RidePref(
      departure: departure!,
      arrival: arrival!,
      departureDate: departureDate,
      requestedSeats: requestedSeats,
    );

    Navigator.pop(context, ridePref);
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get date => DateTimeUtils.formatDateTime(departureDate);

  // ----------------------------------
  // Build the widgets
  // ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          formPicker(
            icon: Icons.circle_outlined,
            label: 'Leaving from',
            value: departure?.name,
            onTap: _onDeparturePressed,
            showSwapIcon: true,
            onSwap: _onSwapLocation,
          ),
          BlaDivider(),
          formPicker(
            icon: Icons.circle_outlined,
            label: 'Going to',
            value: arrival?.name,
            onTap: _onArrivalPressed,
            showSwapIcon: false,
            onSwap: _onSwapLocation,
          ),
          BlaDivider(),
          formPicker(
            icon: Icons.calendar_month,
            label: date,
            value: null,
            onTap: _onDatePressed,
          ),
          BlaDivider(),
          formPicker(
            icon: Icons.person_outline,
            label: requestedSeats.toString(),
            value: null,
            onTap: _onSeatsPressed,
          ),
          const SizedBox(height: BlaSpacings.s),
          BlaButton(
            text: 'Search',
            type: BlaButtonType.primary,
            onPressed: _onSearchPressed,
          ),
        ],
      ),
    );
  }
}
