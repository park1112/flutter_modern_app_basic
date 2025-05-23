# AgroFlow - 농산물 유통 관리 시스템

AgroFlow는 농산물 공급자와 구매자를 위한 통합 유통 관리 모바일 애플리케이션입니다.

## 🚀 주요 기능

- **거래처 관리**: 거래처 정보 관리 및 분석
- **상품 관리**: 상품 등록, 가격 관리
- **주문/판매**: 주문 접수, 배송 관리
- **재고 관리**: 실시간 재고 현황 파악
- **정산 관리**: 매입/매출 정산, 미수금 관리
- **지도 기능**: 거래처 위치, 배송 경로 표시
- **채팅**: 거래처와의 실시간 커뮤니케이션
- **보고서**: 다양한 분석 보고서 제공

## 🛠 기술 스택

- **Frontend**: Flutter 3.x
- **State Management**: GetX
- **Backend**: Supabase
- **Maps**: Google Maps
- **Charts**: FL Chart
- **Local Storage**: GetStorage, Shared Preferences

## 📱 지원 플랫폼

- Android
- iOS
- Web

## 🏗 프로젝트 구조

```
lib/
├── core/              # 핵심 기능 (테마, 상수, 라우트, 유틸)
├── features/          # 기능별 모듈
│   ├── auth/         # 인증 (로그인, 회원가입)
│   ├── dashboard/    # 대시보드
│   ├── menu/         # 메뉴
│   ├── map/          # 지도
│   ├── chat/         # 채팅
│   ├── settings/     # 설정
│   └── splash/       # 스플래시
├── shared/           # 공유 컴포넌트
│   ├── widgets/      # 공통 위젯
│   ├── models/       # 공통 데이터 모델
│   └── services/     # 공통 서비스
└── main.dart         # 앱 진입점
```

## 🚦 시작하기

### 1. 프로젝트 클론
```bash
git clone https://github.com/your-username/flutter_agroflow.git
cd flutter_agroflow
```

### 2. 환경 설정
```bash
# .env.example을 복사하여 .env 파일 생성
cp .env.example .env

# .env 파일을 열어 필요한 값들을 설정
# - Supabase URL과 Anon Key
# - Google Maps API Keys
```

### 3. 의존성 설치
```bash
flutter pub get
```

### 4. Supabase 설정
1. [Supabase](https://supabase.com)에서 새 프로젝트 생성
2. 프로젝트 URL과 anon key를 .env 파일에 추가
3. 필요한 데이터베이스 테이블 생성

### 5. Google Maps 설정

#### Android
`android/app/src/main/AndroidManifest.xml`에 API 키 추가:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY_HERE"/>
```

#### iOS
`ios/Runner/AppDelegate.swift`에 API 키 추가:
```swift
GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
```

#### Web
`web/index.html`에 스크립트 추가:
```html
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY_HERE"></script>
```

### 6. 실행
```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Web
flutter run -d chrome
```

## 📋 할 일 목록

- [ ] Supabase 데이터베이스 스키마 설계
- [ ] 실시간 데이터 동기화 구현
- [ ] 푸시 알림 기능 추가
- [ ] 오프라인 모드 지원
- [ ] 다국어 지원 (i18n)
- [ ] 테스트 코드 작성
- [ ] CI/CD 파이프라인 구축

## 🤝 기여하기

1. 이 저장소를 포크합니다
2. 새 브랜치를 생성합니다 (`git checkout -b feature/amazing-feature`)
3. 변경사항을 커밋합니다 (`git commit -m 'Add some amazing feature'`)
4. 브랜치에 푸시합니다 (`git push origin feature/amazing-feature`)
5. Pull Request를 생성합니다

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 있습니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 🔒 보안

보안 취약점을 발견하면 공개 이슈 대신 이메일로 연락해주세요: security@example.com

## 👥 팀

- 개발자: [Your Name](https://github.com/yourusername)

## 📞 연락처

- 이메일: contact@example.com
- 웹사이트: https://agroflow.example.com
