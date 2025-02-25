import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Make navigation bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  // Enable edge-to-edge display
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const GUIDemoApp());
}

class GUIDemoApp extends StatefulWidget {
  const GUIDemoApp({super.key});

  @override
  _GUIDemoAppState createState() => _GUIDemoAppState();
}

class _GUIDemoAppState extends State<GUIDemoApp> {
  String selectedFont = 'Poppins';
  bool isDarkMode = false;
  bool useAlternateColorScheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(isDarkMode, useAlternateColorScheme),
      home: HomeScreen(
        selectedFont: selectedFont,
        isDarkMode: isDarkMode,
        useAlternateColorScheme: useAlternateColorScheme,
        onFontChanged: (newFont) {
          setState(() => selectedFont = newFont);
        },
        onThemeChanged: (darkMode) {
          setState(() => isDarkMode = darkMode);
        },
        onColorSchemeChanged: () {
          setState(() => useAlternateColorScheme = !useAlternateColorScheme);
        },
      ),
    );
  }

  ThemeData _buildTheme(bool darkMode, bool useAlternateColorScheme) {
    // Default color scheme
    Color primaryPink = const Color(0xFFFF2165); // Extracted pink
    Color secondaryPink =
        const Color.fromARGB(255, 255, 31, 128); // Slightly darker pink

    // Alternate color scheme
    Color alternatePrimary = const Color.fromARGB(255, 104, 76, 175); // Green
    Color alternateSecondary =
        const Color.fromARGB(255, 74, 153, 195); // Light green

    ColorScheme defaultColorScheme = darkMode
        ? ColorScheme.dark(
            primary: primaryPink,
            secondary: secondaryPink,
            surface: Colors.grey[900]!,
          )
        : ColorScheme.light(
            primary: primaryPink,
            secondary: secondaryPink,
            surface: Colors.white,
          );

    ColorScheme alternateColorScheme = darkMode
        ? ColorScheme.dark(
            primary: alternatePrimary,
            secondary: alternateSecondary,
            surface: Colors.grey[900]!,
          )
        : ColorScheme.light(
            primary: alternatePrimary,
            secondary: alternateSecondary,
            surface: Colors.grey[100]!,
          );

    return ThemeData(
      colorScheme:
          useAlternateColorScheme ? alternateColorScheme : defaultColorScheme,
      brightness: darkMode ? Brightness.dark : Brightness.light,
      textTheme: GoogleFonts.getTextTheme(
        selectedFont,
        darkMode ? Typography.whiteMountainView : Typography.blackMountainView,
      ),
      cardColor: darkMode ? Colors.grey[800] : Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String selectedFont;
  final bool isDarkMode;
  final bool useAlternateColorScheme;
  final Function(String) onFontChanged;
  final Function(bool) onThemeChanged;
  final VoidCallback onColorSchemeChanged;

  const HomeScreen({
    super.key,
    required this.selectedFont,
    required this.isDarkMode,
    required this.useAlternateColorScheme,
    required this.onFontChanged,
    required this.onThemeChanged,
    required this.onColorSchemeChanged,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  int selectedRadio = 1;
  String enteredName = "Enter Name"; // Default button text

  void _showInputDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Enter Your Name"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: "Type your name here"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              String name = nameController.text.trim();
              if (name.isNotEmpty) {
                setState(() {
                  enteredName = "Hi, $name!"; // Update button text
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Hello, $name!")),
                );
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme),
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            _buildCard(
              title: "Font Selection",
              theme: theme,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFontRadioButton('Poppins', theme),
                  _buildFontRadioButton('Josefin Sans', theme),
                  _buildFontRadioButton('Space Grotesk', theme),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: "Buttons",
              theme: theme,
              child: Column(
                children: [
                  _styledButton("Show Snackbar", theme.colorScheme.primary, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Hello! This is a Snackbar."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  _styledOutlinedButton(
                    enteredName,
                    theme.colorScheme.secondary,
                    () {
                      _showInputDialog(context); // Open input dialog
                    },
                  ),
                  const SizedBox(height: 8),
                  _styledTextButton(
                    "Change Color Scheme",
                    theme.colorScheme.primary,
                    widget.onColorSchemeChanged,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: "Theme Mode",
              theme: theme,
              child: Row(
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
            const SizedBox(height: 16),
            _buildCard(
              title: "Date Picker",
              theme: theme,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd').format(selectedDate),
                    style: theme.textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today,
                        color: theme.colorScheme.primary),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              title: "Time Picker",
              theme: theme,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedTime.format(context),
                    style: theme.textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: Icon(Icons.access_time,
                        color: theme.colorScheme.primary),
                    onPressed: () => _selectTime(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFontRadioButton(String fontName, ThemeData theme) {
    return Row(
      children: [
        Radio<String>(
          value: fontName,
          groupValue: widget.selectedFont,
          activeColor: theme.colorScheme.primary,
          onChanged: (String? newValue) {
            if (newValue != null) {
              widget.onFontChanged(newValue);
            }
          },
        ),
        Text(
          fontName,
          style: GoogleFonts.getFont(
            fontName,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: widget.selectedFont == fontName
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
        if (widget.selectedFont == fontName)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "(Current)",
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 12,
              ),
            ),
          ),
      ],
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
        style: theme.textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
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
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
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
        child: Text(text, style: const TextStyle(color: Colors.white)),
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
}
