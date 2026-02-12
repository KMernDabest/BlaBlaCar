import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/bla_button.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class BlaButtonTestScreen extends StatelessWidget {
  const BlaButtonTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_buildBackground(), _buildForeground(context)]);
  }

  Widget _buildForeground(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Text(
              "BlaButton Test Screen",
              style: BlaTextStyles.heading.copyWith(color: Colors.white),
            ),
          ),
          SizedBox(height: 100),

          Container(
            margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(BlaSpacings.l),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSectionTitle('PRIMARY BUTTONS'),
                  SizedBox(height: BlaSpacings.m),

                  BlaButton(
                    text: 'Request to Book',
                    type: BlaButtonType.primary,
                    onPressed: () => _showSnackBar(context, 'Primary button pressed'),
                  ),
                  SizedBox(height: BlaSpacings.s),

                  BlaButton(
                    text: 'Search Rides',
                    type: BlaButtonType.primary,
                    icon: Icons.search,
                    onPressed: () => _showSnackBar(context, 'Primary with icon'),
                  ),
                  SizedBox(height: BlaSpacings.s),

                  BlaButton(
                    text: 'Request to Book (Disabled)',
                    type: BlaButtonType.primary,
                    onPressed: null,
                  ),

                  SizedBox(height: BlaSpacings.xl),

                  _buildSectionTitle('SECONDARY BUTTONS'),
                  SizedBox(height: BlaSpacings.m),

                  BlaButton(
                    text: 'Contact Validator',
                    type: BlaButtonType.secondary,
                    onPressed: () => _showSnackBar(context, 'Secondary button pressed'),
                  ),
                  SizedBox(height: BlaSpacings.s),

                  BlaButton(
                    text: 'Send Message',
                    type: BlaButtonType.secondary,
                    icon: Icons.message,
                    onPressed: () => _showSnackBar(context, 'Secondary with icon'),
                  ),
                  SizedBox(height: BlaSpacings.s),

                  // Secondary button - disabled
                  BlaButton(
                    text: 'Contact Validator (Disabled)',
                    type: BlaButtonType.secondary,
                    onPressed: null,
                  ),

                  SizedBox(height: BlaSpacings.l),
                ],
              ),
            ),
          ),
          SizedBox(height: BlaSpacings.xxl),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: BlaTextStyles.label.copyWith(
        fontWeight: FontWeight.w600,
        color: BlaColors.neutralLight,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: BlaColors.neutralDark,
      ),
    );
  }
}

