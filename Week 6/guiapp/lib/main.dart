import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(GUIDemoApp());
}

class GUIDemoApp extends StatefulWidget {
  @override
  _GUIDemoAppState createState() => _GUIDemoAppState();
}

class _GUIDemoAppState extends State<GUIDemoApp> {
  String selectedFont = 'Poppins';
  bool isDarkMode = false; // Add dark mode state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(isDarkMode), // Pass dark mode flag to theme builder
      home: HomeScreen(
        selectedFont: selectedFont,
        isDarkMode: isDarkMode, // Pass dark mode state
        onFontChanged: (newFont) {
          setState(() => selectedFont = newFont);
        },
        onThemeChanged: (darkMode) {
          // Add theme change callback
          setState(() => isDarkMode = darkMode);
        },
      ),
    );
  }

  ThemeData _buildTheme(bool darkMode) {
    // Define color scheme based on mode
    ColorScheme colorScheme = darkMode
        ? ColorScheme.dark(
            primary: Colors.tealAccent,
            secondary: Colors.indigoAccent,
            background: Colors.grey[850]!,
            surface: Colors.grey[900]!,
          )
        : ColorScheme.fromSeed(
            seedColor: Colors.teal,
            primary: Colors.teal,
            secondary: Colors.indigoAccent,
            background: Colors.grey[100]!,
          );

    return ThemeData(
      colorScheme: colorScheme,
      brightness: darkMode ? Brightness.dark : Brightness.light,
      textTheme: GoogleFonts.getTextTheme(
          selectedFont,
          darkMode
              ? Typography.whiteMountainView
              : Typography.blackMountainView),
      cardColor: darkMode ? Colors.grey[800] : Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String selectedFont;
  final bool isDarkMode;
  final Function(String) onFontChanged;
  final Function(bool) onThemeChanged;

  const HomeScreen({
    Key? key,
    required this.selectedFont,
    required this.isDarkMode,
    required this.onFontChanged,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  int selectedRadio = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme),
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            _buildCard(
              title: "Buttons",
              theme: theme,
              child: Column(
                children: [
                  _styledButton("Elevated", theme.colorScheme.primary, () {}),
                  SizedBox(height: 8),
                  _styledOutlinedButton(
                      "Outlined", theme.colorScheme.secondary, () {}),
                  SizedBox(height: 8),
                  _styledTextButton("Text", theme.colorScheme.primary, () {}),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildCard(
              title: "Radio Buttons",
              theme: theme,
              child: Column(
                children: [
                  _styledRadioButton(1, "Option 1"),
                  _styledRadioButton(2, "Option 2"),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildCard(
              title: "Theme Mode",
              theme: theme,
              child: Row(
                // Use Row instead of Column to keep elements on same line
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.isDarkMode ? "Dark Mode" : "Light Mode",
                    style: theme.textTheme.titleMedium,
                  ),
                  Switch.adaptive(
                    value: widget.isDarkMode,
                    activeColor: theme.colorScheme.primary,
                    onChanged: (val) => widget.onThemeChanged(val),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildCard(
              title: "Date Picker",
              theme: theme,
              child: _styledTextButton(
                "Select Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}",
                theme.colorScheme.secondary,
                () => _selectDate(context),
              ),
            ),
            SizedBox(height: 16),
            _buildCard(
              title: "Time Picker",
              theme: theme,
              child: _styledTextButton(
                "Selected Time: ${selectedTime.format(context)}",
                theme.colorScheme.primary,
                () => _selectTime(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Text(
        'Flutter GUI Demo',
        style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
      ),
      actions: [
        DropdownButton<String>(
          value: widget.selectedFont,
          icon: const Icon(Icons.font_download, color: Colors.white),
          dropdownColor: theme.colorScheme.primary.withOpacity(0.9),
          style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
          onChanged: (newValue) => widget.onFontChanged(newValue!),
          items: ['Poppins', 'Lato', 'Roboto']
              .map((font) => DropdownMenuItem(value: font, child: Text(font)))
              .toList(),
        ),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null) setState(() => selectedTime = picked);
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Widget _buildCard({
    required String title,
    required ThemeData theme,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _styledButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _styledOutlinedButton(
      String text, Color borderColor, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor, width: 2),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: borderColor)),
      ),
    );
  }

  Widget _styledTextButton(
      String text, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(foregroundColor: textColor),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }

  Widget _styledRadioButton(int value, String text) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: selectedRadio,
          activeColor: Colors.teal,
          onChanged: (val) => setState(() => selectedRadio = val!),
        ),
        Text(text),
      ],
    );
  }
}
