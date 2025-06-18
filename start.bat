@echo off
echo ========================================
echo   Gestion Sinistres - Flutter App
echo ========================================
echo.

echo [1/4] Nettoyage du projet...
flutter clean

echo.
echo [2/4] Installation des dépendances...
flutter pub get

echo.
echo [3/4] Génération du code...
flutter packages pub run build_runner build --delete-conflicting-outputs

echo.
echo [4/4] Lancement de l'application...
echo.
echo L'application va se lancer dans quelques secondes...
echo Appuyez sur Ctrl+C pour arrêter l'application
echo.
flutter run

pause 