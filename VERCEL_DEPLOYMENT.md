# AgroFlow Vercel 배포 방법

## 빠른 시작 가이드

### 방법 1: Vercel CLI 사용 (권장)

1. **Vercel CLI 설치**
   ```bash
   npm i -g vercel
   ```

2. **프로젝트 빌드**
   ```bash
   flutter build web --release
   ```

3. **Vercel로 배포**
   ```bash
   cd /Users/park/flutter_agroflow
   vercel --prod
   ```

   첫 배포 시 나타나는 질문:
   - Set up and deploy? `Y`
   - Which scope? (계정 선택)
   - Link to existing project? `N`
   - Project name? `agroflow` (또는 원하는 이름)
   - In which directory? `./build/web`
   - Override settings? `N`

### 방법 2: GitHub 연동 자동 배포

1. **GitHub에 푸시**
   ```bash
   git add .
   git commit -m "Add Vercel deployment configuration"
   git push origin main
   ```

2. **Vercel 대시보드에서 설정**
   - https://vercel.com 로그인
   - "New Project" 클릭
   - GitHub 저장소 선택
   - 다음 설정 적용:
     ```
     Framework Preset: Other
     Root Directory: ./
     Build Command: flutter build web --release
     Output Directory: build/web
     Install Command: (비워두기)
     ```

### 방법 3: 드래그 앤 드롭

1. **빌드 실행**
   ```bash
   flutter build web --release
   ```

2. **Vercel 대시보드**
   - https://vercel.com 로그인
   - build/web 폴더를 브라우저로 드래그 앤 드롭

## 배포 전 체크리스트

- [ ] Google Maps API 키 설정 (build/web/index.html)
- [ ] 환경 변수 설정 필요 시 Vercel 대시보드에서 추가
- [ ] CORS 설정 확인 (백엔드 API)

## 배포 후 확인

배포가 완료되면 Vercel이 제공하는 URL로 접속하여 확인:
- 예: https://agroflow.vercel.app

## 커스텀 도메인 연결

1. Vercel 대시보드 > Settings > Domains
2. Add Domain 클릭
3. DNS 설정 안내 따르기

## 문제 해결

### 빌드 에러 발생 시
```bash
# 클린 빌드
flutter clean
flutter pub get
flutter build web --release
```

### 큰 파일 크기 문제
```bash
# HTML 렌더러 사용 (파일 크기 감소)
flutter build web --web-renderer html --release
```

## 성능 최적화

vercel.json에 다음 추가:
```json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "SAMEORIGIN"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        }
      ]
    }
  ]
}
```