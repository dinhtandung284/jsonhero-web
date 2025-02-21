# Stage 1: Build
FROM node:16.17.0 AS builder
WORKDIR /app
# Copy package.json và package-lock.json để cài đặt Remix CLI trước
COPY package*.json ./
# Cài đặt Remix CLI để tránh lỗi
RUN npm install -g remix
# Cài đặt dependencies (bao gồm cả dev để đảm bảo remix có sẵn)
RUN npm install
# Copy source code
COPY . .
# Build project
RUN npm run build

# Stage 2: Production
FROM node:16.17.0
WORKDIR /app
COPY --from=builder /app /app
EXPOSE 8787
CMD ["npm", "start"]
