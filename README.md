# C-Hat Client

Cross-platform client for the c-hat chatting service. Say no to centralized chats, hello to decentralized servers! The client allows you to login to JUST 1 server of your choice, with unique credentials, leaving no trace of connections between various servers.

<p align="center">
<img src=".github/1.png" style="width: 200px;">
<img src=".github/2.png" style="width: 200px;">
<img src=".github/3.png" style="width: 200px;">
</p>

## Tech Stack
- Flutter/Dart
- Backend: [C-Hat Server V2](https://github.com/justincodinguk/c-hat-server-v2)
- BLoC architecture with repository pattern
- Websocket clients
- Custom code generators for data classes
- Custom library for platform-specific UI 
- Floor DB for SQLite ORM
- Custom Auth system with email verification handled by the backend.