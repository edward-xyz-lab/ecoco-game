# ECOCO Game — 環保版 Pokémon GO

> 把環保行為（投電池、補充站）轉化為遊戲補給，讓年輕族群自願做環保。

---

## 專案結構

```
APP遊戲化/
├── ecoco_game/          # Flutter APP
│   ├── lib/
│   │   ├── core/        # 主題、路由、常數
│   │   ├── data/        # Models、API、Repository
│   │   ├── domain/      # Entities、UseCase
│   │   └── presentation/
│   │       ├── screens/ # home, game_map, battle, character, shop
│   │       ├── widgets/
│   │       └── providers/ # Riverpod
│   └── pubspec.yaml
├── backend/             # Node.js API Server
│   ├── src/
│   │   ├── config/      # Prisma, Redis, env
│   │   ├── middleware/  # auth, validate
│   │   ├── routes/      # REST endpoints
│   │   ├── services/    # Business logic
│   │   └── socket/      # Socket.io 即時戰鬥
│   ├── prisma/
│   │   └── schema.prisma
│   └── Dockerfile
└── docker-compose.yml
```

---

## 快速啟動

### 1. 啟動基礎設施

```bash
docker-compose up postgres redis -d
```

### 2. 啟動後端

```bash
cd backend
cp .env.example .env        # 填入你的設定
npm install
npx prisma migrate dev
npm run dev
```

後端運行在 `http://localhost:3000`

### 3. 啟動 Flutter

```bash
cd ecoco_game
flutter pub get
flutter run
```

---

## API 端點

| Method | Path | 說明 |
|--------|------|------|
| POST | /api/auth/register | 註冊 |
| POST | /api/auth/login | 登入 |
| GET | /api/users/me | 取得自己資料 |
| GET | /api/monsters/nearby?lat&lng | 附近怪物 |
| POST | /api/battles/start | 開始戰鬥 |
| POST | /api/battles/:id/action | 戰鬥動作 (attack/flee) |
| POST | /api/currency/convert-points | 點數→幣 |
| POST | /api/currency/recharge-energy | 補電量 |
| POST | /api/currency/recharge-hp | 補血 |
| GET | /api/shop/items | 商店品項 |
| POST | /api/shop/purchase | 購買 |
| POST | /api/stations/:id/scan | 掃描機台 QR |

### Socket.io `/battle` namespace

```js
// 連線
const socket = io('http://localhost:3000/battle', {
  auth: { token: 'your-jwt-token' }
});

socket.emit('join_battle', battleId);
socket.emit('attack', { battleId });
socket.emit('flee', { battleId });

socket.on('battle_update', (state) => { ... });
socket.on('battle_end', (state) => { ... });
```

---

## 遊戲設計

### 雙貨幣系統
- **ECOCO點數**：投電池/活動獲得，兌換商品折扣
- **ECOCO幣**：遊戲貨幣，打怪獲得 or 點數換 or 付費購買

### 補給機制（核心差異化）
| 狀態 | 免費方式 | 付費方式 |
|------|---------|---------|
| 電量耗盡 | 到電池機投電池 | 5 ECOCO幣 |
| 血量耗盡 | 到補充站補清潔液 | 3 ECOCO幣 |

### 怪物稀有度
`COMMON → UNCOMMON → RARE → EPIC → LEGENDARY`

### 商業模式
1. ECOCO幣微交易（幣包）
2. VIP月卡 NT$99（每日幣+機率加成）
3. 廠商贊助Boss（打倒獲得品牌折扣券）

---

## 技術棧

| 層 | 技術 |
|----|------|
| Flutter | Riverpod + go_router + google_maps_flutter |
| Backend | Node.js + Express + TypeScript |
| Database | PostgreSQL (Prisma ORM) |
| Cache/Session | Redis (ioredis) |
| Real-time | Socket.io |
| Container | Docker + docker-compose |
