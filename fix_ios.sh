#!/bin/bash

echo "🍎 iOS 빌드 문제 해결 중..."

cd ios

# Clean previous build
echo "기존 빌드 정리 중..."
rm -rf Pods
rm -f Podfile.lock
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# Install pods
echo "CocoaPods 설치 중..."
pod install --repo-update

cd ..

echo "✅ iOS 설정 완료!"
echo ""
echo "이제 다시 실행해보세요:"
echo "flutter run -d ios"
