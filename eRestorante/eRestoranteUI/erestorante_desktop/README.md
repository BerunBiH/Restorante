# erestorante_desktop

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

To generate auto mapping of code run:
dart run build_runner build


To add a specific migration in dotnet:
1. Run this command:
    Add-Migration AddNewPropertyToYourEntity -StartupProject eRestoranteAPI -Project eRestorante.Services
2. Delete the previous entries in the migration folder (just in case)
3. Run this command:
    Update-Database AddNewPropertyToYourEntity -StartupProject eRestoranteAPI -Project eRestorante.Services