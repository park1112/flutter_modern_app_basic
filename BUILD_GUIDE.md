# AgroFlow 빌드 및 실행 가이드

## 빠른 시작

### 1. 의존성 설치
```bash
flutter pub get
```

### 2. 플랫폼별 실행

#### Web
```bash
flutter run -d chrome
```

#### Android
```bash
flutter run -d android
```

#### iOS (Mac에서만)
```bash
cd ios
pod install
cd ..
flutter run -d ios
```

## 테스트 계정
- 이메일: test@test.com
- 비밀번호: password

## 빌드 테스트

### 모든 플랫폼 빌드 테스트
```bash
chmod +x build_test.sh
./build_test.sh
```

### 개별 플랫폼 빌드

#### Android APK
```bash
flutter build apk --debug
```

#### iOS (Mac에서만)
```bash
flutter build ios --debug --no-codesign
```

#### Web
```bash
flutter build web
```

## 알려진 이슈 및 해결 방법

### 1. iOS 빌드 오류 - 최소 배포 버전
**오류**: `The plugin "google_maps_flutter_ios" requires a higher minimum iOS deployment version`

**해결**:
```bash
chmod +x fix_ios.sh
./fix_ios.sh
```

또는 수동으로:
1. `ios/Podfile`에서 `platform :ios, '14.0'` 설정 확인
2. Xcode에서 프로젝트 열기
3. Runner 타겟 선택 → Build Settings → iOS Deployment Target → 14.0으로 변경
4. 다음 명령 실행:
   ```bash
   cd ios
   rm -rf Pods Podfile.lock
   pod install --repo-update
   cd ..
   flutter clean
   flutter pub get
   ```

### 2. Google Maps 표시 안됨
- 각 플랫폼의 설정 파일에 Google Maps API 키 추가 필요
- Android: `android/app/src/main/AndroidManifest.xml`
- iOS: `ios/Runner/AppDelegate.swift`
- Web: `web/index.html`

### 3. Supabase 연결 오류
- `.env` 파일 생성 및 Supabase 정보 입력
- `lib/core/constants/app_constants.dart`에서 URL과 Key 설정

### 4. iOS 빌드 오류 - 일반
```bash
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
flutter clean
flutter pub get
```

### 5. Android 빌드 오류
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

## 개발 환경 요구사항

- Flutter SDK: 3.x 이상
- Dart SDK: 3.x 이상
- Android Studio / VS Code
- Xcode (iOS 개발시)
- Chrome (Web 개발시)
