import 'package:aahwanam/blocs/Subcategory/subcategory%20event.dart';
import 'package:aahwanam/blocs/Subcategory/subcategory%20state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/Subcategory/subcategory bloc.dart';
import '../../widgets/Subcategory/service_card_details.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_top_bar.dart';

class EventDetailsScreen extends StatefulWidget {
  final String serviceId;
  final bool showIncludedPackages;

  const EventDetailsScreen({
    Key? key,
    required this.serviceId,
    this.showIncludedPackages = false,
  }) : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late int _currentQuantity;

  @override
  void initState() {
    super.initState();
    _currentQuantity = 1;
  }

  void _updatePackageQuantity(int newQuantity) {
    setState(() {
      _currentQuantity = newQuantity;
      if (_currentQuantity < 0) {
        _currentQuantity = 0;
      }
    });

    if (_currentQuantity == 0) {
      print('Quantity reached 0, navigating back to previous screen.');
      Navigator.pop(context);
    }
    print('PackageDetails quantity updated to: $_currentQuantity');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubcategoryBloc()..add(LoadEventDetails(widget.serviceId)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomTopBar(
          onBack: () => Navigator.pop(context),
          onSearchChanged: (value) {
            print("Search typed: $value");
          },
          onCalendarTap: () {
            print("Calendar tapped");
          },
          onCartTap: () {
            print("Cart tapped");
          },
          onFavoriteTap: () {
            print("Favorite tapped");
          },
        ),
        body: BlocBuilder<SubcategoryBloc, SubcategoryState>(
          builder: (context, state) {
            if (state.eventDetails.isNotEmpty) {
              final eventPackageDetails = state.eventDetails.first;
              return PackageDetails(
                eventpackagedetails: eventPackageDetails,
                showIncludedPackages: widget.showIncludedPackages,
                quantity: _currentQuantity,
                onQuantityChanged: _updatePackageQuantity,
              );
            } else if (state.status == SubcategoryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == SubcategoryStatus.failure) {
              return Center(
                child: Text(
                  'Failed to load event details. Please try again.',
                  style: TextFontStyle.textFontStyle(
                      14, const Color(0xFF575959), FontWeight.w600),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'No event details found.',
                  style: TextFontStyle.textFontStyle(
                      14, const Color(0xFF575959), FontWeight.w600),
                ),
              );
            }
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    print('Checking out with quantity: $_currentQuantity');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF233B32),
                    side: const BorderSide(color: Color(0xFF233B32)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Check Out',
                    style: TextFontStyle.textFontStyle(
                        14, const Color(0xFF233B32), FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    print('Adding other services. Current quantity: $_currentQuantity');
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF233B32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Add other services',
                    style: TextFontStyle.textFontStyle(
                        14, Colors.white, FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
