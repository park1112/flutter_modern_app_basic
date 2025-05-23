#!/bin/bash

echo "🧹 Flutter 프로젝트 정리 중..."

# Flutter clean
flutter clean

# Remove iOS build artifacts
echo "iOS 빌드 파일 정리 중..."
cd ios
rm -rf Pods
rm -f Podfile.lock
rm -rf .symlinks
rm -rf Flutter/Flutter.framework
rm -rf Flutter/Flutter.podspec
cd ..

# Remove pubspec.lock
rm -f pubspec.lock

# Get packages
echo "패키지 재설치 중..."
flutter pub get

# iOS pod install
echo "iOS CocoaPods 설치 중..."
cd ios
pod install --repo-update
cd ..

echo "✅ 정리 완료!"
echo ""
echo "이제 다시 실행해보세요:"
echo "flutter run"
