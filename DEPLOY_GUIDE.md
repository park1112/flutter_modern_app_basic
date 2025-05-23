# Vercel 배포 가이드

## 사전 준비사항

1. Vercel 계정이 필요합니다 (https://vercel.com)
2. Vercel CLI 설치 (선택사항):
   ```bash
   npm i -g vercel
   ```

## 빌드 및 배포 과정

### 1. Flutter 웹 빌드

```bash
# 프로덕션 빌드
flutter build web --release

# 또는 HTML 렌더러 사용 (더 나은 호환성)
flutter build web --web-renderer html --release

# 또는 CanvasKit 렌더러 사용 (더 나은 성능)
flutter build web --web-renderer canvaskit --release
```

### 2. Vercel CLI를 통한 배포

```bash
# Vercel CLI로 배포
vercel

# 프로덕션 배포
vercel --prod
```

### 3. GitHub를 통한 자동 배포

1. GitHub 저장소에 코드 푸시
2. Vercel 대시보드에서 "New Project" 클릭
3. GitHub 저장소 연결
4. 다음 설정 사용:
   - Framework Preset: Other
   - Build Command: `flutter build web --release`
   - Output Directory: `build/web`
   - Install Command: `flutter pub get`

### 4. 수동 배포 (대시보드 사용)

1. 빌드된 `build/web` 폴더를 압축
2. Vercel 대시보드에서 "New Project" 클릭
3. "Upload" 선택 후 압축 파일 업로드
4. 또는 `build/web` 폴더를 드래그 앤 드롭

## 환경 변수 설정

Vercel 대시보드에서 환경 변수 추가:
- FLUTTER_WEB_USE_SKIA=true (성능 향상)
- 기타 앱에서 사용하는 환경 변수

## 최적화 팁

### 1. 빌드 최적화
```bash
# 트리 쉐이킹과 최적화 활성화
flutter build web --release --tree-shake-icons

# 소스맵 제외 (파일 크기 감소)
flutter build web --release --no-source-maps
```

### 2. 캐싱 설정 (vercel.json)
```json
{
  "headers": [
    {
      "source": "/assets/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    }
  ]
}
```

### 3. 압축 활성화
Vercel은 자동으로 gzip/brotli 압축을 적용합니다.

## 문제 해결

### CORS 에러
API 호출 시 CORS 에러가 발생하면 백엔드에서 Vercel 도메인을 허용해야 합니다.

### 폰트 로딩 문제
```yaml
# pubspec.yaml
flutter:
  fonts:
    - family: YourFont
      fonts:
        - asset: fonts/YourFont.ttf
```

### 이미지 경로 문제
절대 경로 대신 상대 경로 사용:
```dart
Image.asset('assets/images/logo.png')  // Good
Image.asset('/assets/images/logo.png') // Bad
```

## 배포 후 확인사항

1. 모든 페이지가 정상적으로 로드되는지 확인
2. API 연결이 정상적으로 작동하는지 확인
3. 폰트와 아이콘이 제대로 표시되는지 확인
4. 반응형 디자인이 정상 작동하는지 확인

## 도메인 연결

1. Vercel 대시보드에서 프로젝트 선택
2. Settings > Domains
3. 커스텀 도메인 추가
4. DNS 설정 업데이트

## 성능 모니터링

Vercel Analytics를 활용하여 웹 성능 모니터링:
- Core Web Vitals
- 실시간 방문자 통계
- 성능 점수