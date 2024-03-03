
# Quizzzz App
  
This app is used for checking your knowledge on some topics. When clicking one of the topic, you will have to answer the questions of that topic. Click the 'Next Question' button to move to the next question.

You can choose the Generic Pratice to practice the weakness topic of your knowledge.

3 key challenges faced during the project

 - Using state management.
 - Using dependency injection to allow testability.
 - Writing widget unit tests.
 
3 key learning moments from working on the project
 - Finding proper ways to write unit tests for widgets.
 - Learning new state management.
 - Using mockito and SharedPreferences.setMockInitialValues.

For the test coverage, due to some auto generated files, the following commands need to be run:
flutter test --coverage
lcov --remove coverage/lcov.info 'lib/**/*.g.dart' 'lib/**/*.freezed.dart' -o coverage/lcov.info
open coverage/html/index.html  

To run the project, first run:
flutter pub get
flutter pub run build_runner build

List of dependencies and their versions:
    dependencies:
      flutter:
        sdk: flutter
      flutter_riverpod: ^2.4.9
      riverpod_annotation: ^2.3.3
      go_router: ^13.2.0
      http: ^1.2.0
      shared_preferences: ^2.2.1
      sqflite: ^2.3.0
      get_it: ^7.6.7
      dio: ^5.4.0
      retrofit: ^4.0.3
      provider: ^6.0.0
      flutter_bloc: ^8.1.3
      freezed_annotation: ^2.4.1
      loading_indicator: ^3.1.1
      mockito: ^5.4.4
    
    dev_dependencies:
      flutter_test:
        sdk: flutter
      flutter_lints: ^2.0.0
      riverpod_generator: ^2.3.9
      build_runner: ^2.4.8
      custom_lint: ^0.5.8
      riverpod_lint: ^2.3.7
      retrofit_generator: ^8.0.6
      freezed: ^2.4.6 here
