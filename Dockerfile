# 베이스 이미지 선택
FROM node:18-alpine

# 작업 디렉터리 생성
WORKDIR /app

# 의존성 설치를 위해 package.json과 package-lock.json 복사
COPY package*.json ./

# 의존성 설치
RUN npm install --production

# 앱 소스 코드 전체 복사
COPY . .

# 앱 포트 노출 (필요하면 변경)
EXPOSE 3000

# 컨테이너 시작 명령
CMD ["node", "index.js"]

