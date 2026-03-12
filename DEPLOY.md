# 部署指南

## 架構

```
Flutter Web  →  Vercel / Netlify   (免費，CDN)
Backend API  →  Railway            (免費 $5/月額度)
PostgreSQL   →  Railway Plugin     (免費，由 Railway 提供)
Redis        →  Upstash            (免費，10k req/day)
```

---

## Step 1：後端資料庫設定

### 1a. Upstash Redis（免費）

1. 前往 https://upstash.com → 建立帳號
2. 新增 Redis database → 選 region: `ap-northeast-1`（東京，離台灣最近）
3. 複製 **REST URL** 或 **Redis URL**（格式：`rediss://...`）

### 1b. 確認 Railway 內建 PostgreSQL

Railway 部署時會自動注入 `DATABASE_URL`，不需要手動設定。

---

## Step 2：部署 Backend → Railway

### 方式A：一鍵部署（最簡單）

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template)

1. 前往 https://railway.app → GitHub 登入
2. **New Project → Deploy from GitHub repo** → 選 `ecoco-game`
3. 選 `backend/` 子目錄
4. Railway 自動讀取 `railway.toml` 設定

### 方式B：Railway CLI

```bash
npm install -g @railway/cli
railway login
cd backend
railway link          # 連結專案
railway up            # 部署
```

### 設定環境變數（Railway Dashboard → Variables）

| Key | Value |
|-----|-------|
| `NODE_ENV` | `production` |
| `JWT_SECRET` | `openssl rand -base64 32` 的輸出 |
| `REDIS_URL` | Upstash 的 Redis URL |
| `PORT` | `3000` |

> `DATABASE_URL` 由 Railway PostgreSQL plugin 自動注入

### 完成後取得 API URL

Railway 會給你一個 URL 如 `https://ecoco-game-production.up.railway.app`

---

## Step 3：部署 Flutter Web → Vercel

### 方式A：Netlify Drop（最快，不需帳號）

直接把 `ecoco_game/build/web/` 資料夾拖進：
**https://app.netlify.com/drop**

### 方式B：Vercel CLI

```bash
# 登入（開瀏覽器授權）
~/npm-global/node_modules/.bin/vercel login

# 部署（在 ecoco_game/ 目錄）
cd ecoco_game
~/npm-global/node_modules/.bin/vercel deploy --prod
```

### 方式C：Vercel GitHub 整合（推薦）

1. 前往 https://vercel.com → 用 GitHub 登入
2. **Add New Project** → Import `ecoco-game` repo
3. **Framework Preset**: Other
4. **Root Directory**: `ecoco_game`
5. **Output Directory**: `build/web`
6. **Build Command**:
   ```
   curl -L https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.41.4-stable.tar.xz | tar xJ -C /opt && export PATH="/opt/flutter/bin:$PATH" && flutter pub get && dart run build_runner build --delete-conflicting-outputs && flutter build web --release
   ```
7. 設定環境變數：
   | Key | Value |
   |-----|-------|
   | `BASE_URL` | Railway 的 API URL |
   | `WS_URL` | Railway 的 URL |

---

## Step 4：本機 Rebuild（改 API URL 後）

```bash
export PATH="$HOME/development/flutter/bin:$PATH"
cd ecoco_game
flutter build web --release \
  --dart-define=BASE_URL=https://你的railway網址/api \
  --dart-define=WS_URL=https://你的railway網址
```

然後重新部署 Vercel。

---

## 免費額度總結

| 服務 | 免費額度 | 限制 |
|------|---------|------|
| Vercel | 100GB 流量/月 | 商業用途需付費 |
| Railway | $5/月 credits | 約 500小時運行 |
| Upstash Redis | 10,000 req/day | 256MB |
| Railway PostgreSQL | 1GB 儲存 | 包含在 $5 額度內 |

> **預估月費：$0**（流量小的情況下 Railway $5 額度完全夠用）
