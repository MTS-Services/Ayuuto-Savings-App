# ayuuto_savings_app
<p align="center">
  <img src="https://img.shields.io/github/stars/SinaSys/flutter_japanese_restaurant_app">
  <img src="https://img.shields.io/github/forks/SinaSys/flutter_japanese_restaurant_app">
  <img src="https://img.shields.io/github/actions/workflow/status/SinaSys/flutter_japanese_restaurant_app/main.yml?label=CI&logo=github">
  <img src="https://img.shields.io/github/v/release/SinaSys/flutter_japanese_restaurant_app?label=Release&logo=semantic-release">
  <img src="https://img.shields.io/github/last-commit/SinaSys/flutter_japanese_restaurant_app?label=Last%20commit">

## Screenshots (Light mode)

Login screen                    |   SignUp Screen          |  Admin HomeScreen |  User Management
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![Media](https://github.com/user-attachments/assets/d743d6d6-5e4f-4d86-a3ec-ae74081ec9af)|![Media (1)](https://github.com/user-attachments/assets/55b6e4d8-f810-436a-b306-7fe9227c85f8)|![Media (2)](https://github.com/user-attachments/assets/6576e4d8-81cb-477a-9ca4-690d00b9ad10)|![Media (3)](https://github.com/user-attachments/assets/0154ce73-4d98-4feb-83d0-295f0be2438d)



## Screenshots (Light mode)

Create group        |   Group DetailsScreen           |  Payment Management     |  Profile Screen
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![Media (4)](https://github.com/user-attachments/assets/d17f107a-5987-47f5-a9f0-a2fe6d83d186)|![Media (6)](https://github.com/user-attachments/assets/aa4b2a24-f7d7-46eb-b82f-49d96570af6f)|![Media (7)](https://github.com/user-attachments/assets/582e2586-f68b-4efb-945b-eaf61b1ac5f9)|![Media (8)](https://github.com/user-attachments/assets/bca6731c-3c38-44b1-8ab9-f2a1a2ad1726)



|


## 🚀 Features :
```
• Authentication & Security
Email/password-based sign-up and login
Password reset & email verification
OTP (One-Time Password) or 2FA (optional for added security)
Role-based access (Admin, Member)
Create and edit personal profile
Upload profile picture
View savings statistics and history
Save money individually (personal savings tracker)
Set saving reminders or auto-save (if connected with banks)
Create group or team
Invite users to join group
Assign roles (Admin, Treasurer, Member)
View group members and contributions
📊 Admin Dashboard
View total users, active groups
Monitor total savings per group
Approve or remove members from groups
Generate reports (monthly, weekly)
💳 Payment System
Payment confirmation and history
Auto-generate receipts
Scheduled payments or reminders
📅 Reminders & Notifications
Reminder for contributions
Notifications for group updates
Alerts for upcoming targets/deadlines
Admin messages or updates
📈 Analytics & Reporting
Personal and group-level statistics
Pie chart or graph-based savings visualization
Export savings reports (PDF, CSV)
```


## Directory Structure
```
lib
│
├── core
│   ├── app_colors.dart
│   └── assetPath.dart
│
├── src
│   ├── model
│   │   ├── firebase
│   │   │   └── firebase_service.dart
│   │   ├── group_model.dart
│   │   └── reminder_model.dart
│   │
│   └── view
│       └── screen
│           ├── Admin Home Screen
│           │   ├── widget
│           │   │   ├── custom_card.dart
│           │   │   ├── custom_drawer.dart
│           │   │   ├── quick_action_container.dart
│           │   │   └── recent_activites.dart
│           │   └── admin_home_screens.dart
│           │
│           ├── AllUserScreen
│           │   ├── widgets
│           │   │   └── user_data_table.dart
│           │   └── all_user_screen.dart
│           │
│           ├── auth
│           │   ├── email_verification_screen.dart
│           │   ├── forgot_password_screen.dart
│           │   ├── onboarding_screen.dart
│           │   ├── reset_password_screen.dart
│           │   ├── sign_in_screen.dart
│           │   └── sign_up_screen.dart
│           │
│           ├── create_group
│           │   └── create_group_screen.dart
│           │
│           └── group
│           |    └── group.dart
│           ├── create_group
│           │   └── create_group_screen.dart
│           │
│           ├── group
│           │   └── group.dart
│           │
│           ├── group_details
│           │   ├── widget
│           │   └── group_details_screen.dart
│           │
│           ├── Individual Group
│           │   ├── widget
│           │   └── individual_group.dart
│           │
│           ├── manage_group
│           │   ├── widget
│           │   └── manage_group_screen.dart
│           │
│           ├── MemberPaymentScreen
│           │   ├── widgets
│           │   └── member_payment_screen.dart
│           │
│           ├── MyGroupScreen
│           │   ├── widgets
│           │   └── my_group.dart
│           │
│           ├── Payment_Screen
│           │   ├── widgets
│           │   └── payment_screen.dart
│           │
│           ├── profile
│           │   ├── widget
│           │   └── profile_screen.dart
│           │
│           └── widget
│               └── snack_bar_message.dart
│
├── ayuuto_savings.dart
├── firebase_options.dart
├── main.dart
└── navigation_menu.dart

