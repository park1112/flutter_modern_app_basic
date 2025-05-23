#!/bin/bash

echo "🚀 AgroFlow 빌드 테스트 시작"
echo "================================"

# Flutter 버전 확인
echo "📌 Flutter 버전 확인:"
flutter --version
echo ""

# 의존성 설치
echo "📦 패키지 설치 중..."
flutter pub get
echo ""

# 코드 분석
echo "🔍 코드 분석 중..."
flutter analyze
echo ""

# iOS 빌드 테스트 (Mac에서만)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 iOS 빌드 테스트 중..."
    cd ios
    pod install --repo-update
    cd ..
    flutter build ios --debug --no-codesign
    echo ""
fi

# Android 빌드 테스트
echo "🤖 Android 빌드 테스트 중..."
flutter build apk --debug
echo ""

# Web 빌드 테스트
echo "🌐 Web 빌드 테스트 중..."
flutter build web
echo ""

echo "✅ 빌드 테스트 완료!"
echo "================================"
echo ""
echo "📱 앱 실행 방법:"
echo "  - iOS: flutter run -d ios"
echo "  - Android: flutter run -d android"
echo "  - Web: flutter run -d chrome"
echo ""
echo "⚠️  주의사항:"
echo "  1. Google Maps API 키를 설정해야 지도가 표시됩니다"
echo "  2. Supabase 프로젝트를 생성하고 설정해야 합니다"
echo "  3. 테스트 로그인: test@test.com / password"
