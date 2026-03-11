import express from 'express';
import { createServer } from 'http';
import { Server } from 'socket.io';
import cors from 'cors';
import morgan from 'morgan';
import { config } from './config/index.js';
import { redis } from './config/redis.js';
import { prisma } from './config/prisma.js';
import routes from './routes/index.js';
import { setupBattleSocket } from './socket/battle.socket.js';

const app = express();
const httpServer = createServer(app);
const io = new Server(httpServer, {
  cors: { origin: '*', methods: ['GET', 'POST'] },
});

// Middleware
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());

// Admin Dashboard SPA
app.get('/', (_req, res) => {
  res.send(`<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ECOCO Game 後台</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;background:#0f172a;color:#e2e8f0;min-height:100vh}
/* Login */
#loginView{display:flex;align-items:center;justify-content:center;min-height:100vh}
.card{background:#1e293b;border:1px solid #334155;border-radius:16px;padding:40px;width:380px;box-shadow:0 25px 50px rgba(0,0,0,.5)}
.logo{font-size:32px;text-align:center;margin-bottom:8px}
.card h1{text-align:center;font-size:20px;color:#94a3b8;margin-bottom:32px}
label{display:block;font-size:13px;color:#64748b;margin-bottom:6px;margin-top:16px}
input,select,textarea{width:100%;padding:10px 14px;background:#0f172a;border:1px solid #334155;border-radius:8px;color:#e2e8f0;font-size:14px;outline:none;transition:border-color .2s}
input:focus,select:focus,textarea:focus{border-color:#22c55e}
.btn{padding:10px 18px;border:none;border-radius:8px;cursor:pointer;font-size:14px;font-weight:600;transition:all .2s}
.btn-primary{background:#22c55e;color:#0f172a}.btn-primary:hover{background:#16a34a}
.btn-danger{background:#ef4444;color:#fff}.btn-danger:hover{background:#dc2626}
.btn-sm{padding:5px 10px;font-size:12px}
.btn-block{width:100%;margin-top:20px;padding:12px}
.alert{margin-top:12px;padding:10px;border-radius:8px;font-size:13px}
.alert-error{background:#450a0a;color:#fca5a5;border:1px solid #7f1d1d}
.alert-success{background:#052e16;color:#86efac;border:1px solid #14532d}
.tabs{display:flex;gap:8px;margin-bottom:24px}
.tab{flex:1;padding:8px;border-radius:8px;border:1px solid #334155;background:transparent;color:#64748b;cursor:pointer;font-size:13px;font-weight:600;transition:all .2s}
.tab.active{background:#22c55e;color:#0f172a;border-color:#22c55e}
/* Dashboard */
#dashView{display:none;flex-direction:row;min-height:100vh}
aside{width:220px;background:#1e293b;border-right:1px solid #334155;padding:24px 0;flex-shrink:0;display:flex;flex-direction:column}
.brand{padding:0 20px 24px;font-size:16px;font-weight:700;color:#22c55e;border-bottom:1px solid #334155}
nav a{display:flex;align-items:center;gap:10px;padding:12px 20px;color:#94a3b8;text-decoration:none;font-size:14px;transition:all .2s;cursor:pointer}
nav a:hover,nav a.active{background:#0f172a;color:#22c55e;border-right:3px solid #22c55e}
.sidebar-footer{margin-top:auto;padding:16px 20px;border-top:1px solid #334155}
.user-info{font-size:12px;color:#64748b;margin-bottom:8px}
main{flex:1;padding:32px;overflow:auto}
.page{display:none}.page.active{display:block}
h2{font-size:22px;font-weight:700;margin-bottom:24px;color:#f1f5f9}
/* Stats cards */
.stats-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(160px,1fr));gap:16px;margin-bottom:32px}
.stat-card{background:#1e293b;border:1px solid #334155;border-radius:12px;padding:20px}
.stat-label{font-size:12px;color:#64748b;margin-bottom:6px}
.stat-value{font-size:28px;font-weight:700;color:#22c55e}
.stat-sub{font-size:11px;color:#475569;margin-top:4px}
/* Table */
.table-wrap{background:#1e293b;border:1px solid #334155;border-radius:12px;overflow:hidden}
.table-header{display:flex;justify-content:space-between;align-items:center;padding:16px 20px;border-bottom:1px solid #334155}
.table-header h3{font-size:15px;font-weight:600}
table{width:100%;border-collapse:collapse}
th{text-align:left;padding:10px 16px;font-size:12px;color:#64748b;border-bottom:1px solid #334155;white-space:nowrap}
td{padding:10px 16px;font-size:13px;border-bottom:1px solid #1e293b;vertical-align:middle}
tr:last-child td{border-bottom:none}
tr:hover td{background:rgba(255,255,255,.02)}
.badge{display:inline-block;padding:2px 8px;border-radius:9999px;font-size:11px;font-weight:600}
.badge-common{background:#334155;color:#94a3b8}
.badge-uncommon{background:#1a3a1a;color:#4ade80}
.badge-rare{background:#1a2a4a;color:#60a5fa}
.badge-epic{background:#2d1a4a;color:#c084fc}
.badge-legendary{background:#4a2a00;color:#fbbf24}
.badge-victory{background:#052e16;color:#86efac}
.badge-defeat{background:#450a0a;color:#fca5a5}
.badge-fled{background:#2a2a00;color:#fde68a}
.badge-active{background:#052e16;color:#86efac}
.badge-inactive{background:#1e293b;color:#64748b}
/* Modal */
.modal-overlay{position:fixed;inset:0;background:rgba(0,0,0,.7);display:flex;align-items:center;justify-content:center;z-index:100;display:none}
.modal-overlay.open{display:flex}
.modal{background:#1e293b;border:1px solid #334155;border-radius:16px;padding:32px;width:480px;max-height:80vh;overflow-y:auto}
.modal h3{font-size:18px;font-weight:700;margin-bottom:20px}
.modal-footer{display:flex;gap:8px;justify-content:flex-end;margin-top:20px}
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:12px}
</style>
</head>
<body>

<!-- Login -->
<div id="loginView">
  <div class="card">
    <div class="logo">🌿</div>
    <h1>ECOCO Game 後台</h1>
    <div class="tabs">
      <button class="tab active" onclick="switchTab('login')">登入</button>
      <button class="tab" onclick="switchTab('register')">註冊</button>
    </div>
    <div id="loginForm">
      <label>Email</label>
      <input type="email" id="email" placeholder="you@example.com"/>
      <label>密碼</label>
      <input type="password" id="password" placeholder="••••••••"/>
      <button class="btn btn-primary btn-block" onclick="login()">登入</button>
    </div>
    <div id="registerForm" style="display:none">
      <label>用戶名</label>
      <input type="text" id="reg_username" placeholder="edward"/>
      <label>Email</label>
      <input type="email" id="reg_email" placeholder="you@example.com"/>
      <label>密碼（最少 8 字元）</label>
      <input type="password" id="reg_password" placeholder="••••••••"/>
      <button class="btn btn-primary btn-block" onclick="register()">註冊</button>
    </div>
    <div id="loginMsg"></div>
  </div>
</div>

<!-- Dashboard -->
<div id="dashView">
  <aside>
    <div class="brand">🌿 ECOCO 後台</div>
    <nav>
      <a onclick="showPage('overview')" class="active">📊 總覽</a>
      <a onclick="showPage('users')">👥 用戶</a>
      <a onclick="showPage('monsters')">👾 怪物</a>
      <a onclick="showPage('shop')">🛍️ 商店</a>
      <a onclick="showPage('stations')">📍 機台</a>
      <a onclick="showPage('battles')">⚔️ 戰鬥記錄</a>
    </nav>
    <div class="sidebar-footer">
      <div class="user-info" id="sidebarUser"></div>
      <button class="btn btn-danger btn-sm" style="width:100%" onclick="logout()">登出</button>
    </div>
  </aside>
  <main>
    <!-- Overview -->
    <div class="page active" id="page-overview">
      <h2>📊 系統總覽</h2>
      <div class="stats-grid" id="statsGrid"></div>
    </div>

    <!-- Users -->
    <div class="page" id="page-users">
      <h2>👥 用戶管理</h2>
      <div class="table-wrap">
        <div class="table-header">
          <h3>所有用戶</h3>
        </div>
        <table>
          <thead><tr><th>用戶名</th><th>Email</th><th>點數</th><th>幣</th><th>VIP</th><th>HP</th><th>操作</th></tr></thead>
          <tbody id="usersTable"></tbody>
        </table>
      </div>
    </div>

    <!-- Monsters -->
    <div class="page" id="page-monsters">
      <h2>👾 怪物管理</h2>
      <div class="table-wrap">
        <div class="table-header">
          <h3>所有怪物</h3>
          <button class="btn btn-primary btn-sm" onclick="openMonsterModal()">+ 新增怪物</button>
        </div>
        <table>
          <thead><tr><th>名稱</th><th>稀有度</th><th>類型</th><th>HP</th><th>攻擊</th><th>防禦</th><th>狀態</th><th>操作</th></tr></thead>
          <tbody id="monstersTable"></tbody>
        </table>
      </div>
    </div>

    <!-- Shop -->
    <div class="page" id="page-shop">
      <h2>🛍️ 商店管理</h2>
      <div class="table-wrap">
        <div class="table-header">
          <h3>所有商品</h3>
          <button class="btn btn-primary btn-sm" onclick="openShopModal()">+ 新增商品</button>
        </div>
        <table>
          <thead><tr><th>名稱</th><th>類型</th><th>幣價</th><th>NT$</th><th>狀態</th><th>操作</th></tr></thead>
          <tbody id="shopTable"></tbody>
        </table>
      </div>
    </div>

    <!-- Stations -->
    <div class="page" id="page-stations">
      <h2>📍 機台管理</h2>
      <div class="table-wrap">
        <div class="table-header">
          <h3>所有機台</h3>
          <button class="btn btn-primary btn-sm" onclick="openStationModal()">+ 新增機台</button>
        </div>
        <table>
          <thead><tr><th>名稱</th><th>類型</th><th>地址</th><th>緯度</th><th>經度</th><th>狀態</th><th>操作</th></tr></thead>
          <tbody id="stationsTable"></tbody>
        </table>
      </div>
    </div>

    <!-- Battles -->
    <div class="page" id="page-battles">
      <h2>⚔️ 戰鬥記錄</h2>
      <div class="table-wrap">
        <div class="table-header"><h3>最新戰鬥</h3></div>
        <table>
          <thead><tr><th>時間</th><th>用戶</th><th>怪物</th><th>稀有度</th><th>結果</th><th>回合</th></tr></thead>
          <tbody id="battlesTable"></tbody>
        </table>
      </div>
    </div>
  </main>
</div>

<!-- Monster Modal -->
<div class="modal-overlay" id="monsterModal">
  <div class="modal">
    <h3 id="monsterModalTitle">新增怪物</h3>
    <input type="hidden" id="monster_id"/>
    <label>名稱</label><input id="monster_name" placeholder="電池惡魔"/>
    <div class="form-row">
      <div><label>稀有度</label>
        <select id="monster_rarity">
          <option>COMMON</option><option>UNCOMMON</option><option>RARE</option><option>EPIC</option><option>LEGENDARY</option>
        </select></div>
      <div><label>類型</label>
        <select id="monster_type">
          <option>BATTERY</option><option>POLLUTION</option><option>PLASTIC</option><option>CORPORATE</option><option>SEASONAL</option>
        </select></div>
    </div>
    <div class="form-row">
      <div><label>HP</label><input type="number" id="monster_hp" value="100"/></div>
      <div><label>攻擊</label><input type="number" id="monster_atk" value="10"/></div>
    </div>
    <div class="form-row">
      <div><label>防禦</label><input type="number" id="monster_def" value="5"/></div>
      <div><label>贊助商</label><input id="monster_sponsor" placeholder="可留空"/></div>
    </div>
    <div class="form-row">
      <div><label>緯度</label><input type="number" id="monster_lat" value="25.0330" step="0.0001"/></div>
      <div><label>經度</label><input type="number" id="monster_lng" value="121.5654" step="0.0001"/></div>
    </div>
    <label>機台 ID（stationId）</label><input id="monster_station" placeholder="station uuid"/>
    <div class="modal-footer">
      <button class="btn btn-sm" onclick="closeModal('monsterModal')" style="background:#334155;color:#e2e8f0">取消</button>
      <button class="btn btn-primary btn-sm" onclick="saveMonster()">儲存</button>
    </div>
  </div>
</div>

<!-- Shop Modal -->
<div class="modal-overlay" id="shopModal">
  <div class="modal">
    <h3 id="shopModalTitle">新增商品</h3>
    <input type="hidden" id="shop_id"/>
    <label>名稱</label><input id="shop_name" placeholder="HP 藥水"/>
    <label>描述</label><textarea id="shop_desc" rows="2" placeholder="回復 50 HP"></textarea>
    <div class="form-row">
      <div><label>類型</label><input id="shop_type" placeholder="potion"/></div>
      <div><label>幣價</label><input type="number" id="shop_coin" value="5"/></div>
    </div>
    <label>NT$ 價格（可留空）</label><input type="number" id="shop_ntd" placeholder="可留空"/>
    <div class="modal-footer">
      <button class="btn btn-sm" onclick="closeModal('shopModal')" style="background:#334155;color:#e2e8f0">取消</button>
      <button class="btn btn-primary btn-sm" onclick="saveShop()">儲存</button>
    </div>
  </div>
</div>

<!-- Station Modal -->
<div class="modal-overlay" id="stationModal">
  <div class="modal">
    <h3 id="stationModalTitle">新增機台</h3>
    <input type="hidden" id="station_id"/>
    <label>名稱</label><input id="station_name" placeholder="台北車站電池機"/>
    <label>地址</label><input id="station_address" placeholder="台北市中正區…"/>
    <div class="form-row">
      <div><label>緯度</label><input type="number" id="station_lat" value="25.0330" step="0.0001"/></div>
      <div><label>經度</label><input type="number" id="station_lng" value="121.5654" step="0.0001"/></div>
    </div>
    <label>類型</label>
    <select id="station_type"><option value="battery">battery</option><option value="cleaning">cleaning</option></select>
    <div class="modal-footer">
      <button class="btn btn-sm" onclick="closeModal('stationModal')" style="background:#334155;color:#e2e8f0">取消</button>
      <button class="btn btn-primary btn-sm" onclick="saveStation()">儲存</button>
    </div>
  </div>
</div>

<script>
let TOKEN = localStorage.getItem('ecoco_token');
let ME = null;

const api = async (path, opts = {}) => {
  const r = await fetch('/api' + path, {
    ...opts,
    headers: { 'Content-Type': 'application/json', Authorization: 'Bearer ' + TOKEN, ...(opts.headers || {}) },
  });
  return r.json();
};

// ── Auth ──
function switchTab(tab) {
  document.querySelectorAll('.tab').forEach((t, i) => t.classList.toggle('active', (i === 0) === (tab === 'login')));
  document.getElementById('loginForm').style.display = tab === 'login' ? '' : 'none';
  document.getElementById('registerForm').style.display = tab === 'register' ? '' : 'none';
}
function showLoginMsg(txt, type) {
  const el = document.getElementById('loginMsg');
  el.innerHTML = '<div class="alert alert-' + type + '">' + txt + '</div>';
}
async function login() {
  const email = document.getElementById('email').value;
  const password = document.getElementById('password').value;
  try {
    const d = await api('/auth/login', { method: 'POST', body: JSON.stringify({ email, password }) });
    if (d.error) return showLoginMsg(d.error, 'error');
    TOKEN = d.accessToken;
    ME = d.user;
    localStorage.setItem('ecoco_token', TOKEN);
    enterDash();
  } catch { showLoginMsg('連線失敗', 'error'); }
}
async function register() {
  const body = { username: document.getElementById('reg_username').value, email: document.getElementById('reg_email').value, password: document.getElementById('reg_password').value };
  try {
    const d = await api('/auth/register', { method: 'POST', body: JSON.stringify(body) });
    if (d.error) return showLoginMsg(d.error, 'error');
    showLoginMsg('註冊成功，請登入', 'success');
    switchTab('login');
  } catch { showLoginMsg('連線失敗', 'error'); }
}
function logout() { localStorage.removeItem('ecoco_token'); location.reload(); }
document.addEventListener('keydown', e => { if (e.key === 'Enter') { if (document.getElementById('loginForm').style.display !== 'none') login(); else register(); } });

// ── Dashboard ──
function enterDash() {
  document.getElementById('loginView').style.display = 'none';
  document.getElementById('dashView').style.display = 'flex';
  document.getElementById('sidebarUser').textContent = ME ? ME.username + ' · ' + ME.email : '';
  loadOverview();
}
function showPage(name) {
  document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
  document.querySelectorAll('nav a').forEach(a => a.classList.remove('active'));
  document.getElementById('page-' + name).classList.add('active');
  document.querySelectorAll('nav a')[['overview','users','monsters','shop','stations','battles'].indexOf(name)].classList.add('active');
  const loaders = { overview: loadOverview, users: loadUsers, monsters: loadMonsters, shop: loadShop, stations: loadStations, battles: loadBattles };
  loaders[name]?.();
}

// ── Overview ──
async function loadOverview() {
  const d = await api('/admin/stats');
  const grid = document.getElementById('statsGrid');
  const wins = d.battleStats?.find(s => s.status === 'VICTORY')?._count || 0;
  grid.innerHTML = [
    ['👥 用戶', d.users, 'VIP ' + d.vipCount + ' 人'],
    ['👾 怪物', d.monsters, '活躍 ' + d.activeMonsters],
    ['⚔️ 戰鬥', d.battles, '勝利 ' + wins + ' 場'],
    ['📍 機台', d.stations, ''],
    ['🛍️ 商品', d.shopItems, ''],
  ].map(([label, val, sub]) =>
    '<div class="stat-card"><div class="stat-label">' + label + '</div><div class="stat-value">' + val + '</div><div class="stat-sub">' + sub + '</div></div>'
  ).join('');
}

// ── Users ──
async function loadUsers() {
  const d = await api('/admin/users');
  document.getElementById('usersTable').innerHTML = d.data.map(u =>
    '<tr><td>' + u.username + '</td><td>' + u.email + '</td><td>' + u.ecocoPoints + '</td><td>' + u.ecocoCoins + '</td>' +
    '<td>' + (u.isVip ? '<span class="badge badge-active">VIP</span>' : '—') + '</td>' +
    '<td>' + (u.character ? u.character.hp + '/' + u.character.maxHp : '—') + '</td>' +
    '<td><button class="btn btn-danger btn-sm" onclick="deleteUser(\'' + u.id + '\',\'' + u.username + '\')">刪除</button></td></tr>'
  ).join('');
}
async function deleteUser(id, name) {
  if (!confirm('確定刪除用戶 ' + name + '？')) return;
  await api('/admin/users/' + id, { method: 'DELETE' });
  loadUsers();
}

// ── Monsters ──
const rarityBadge = r => '<span class="badge badge-' + r.toLowerCase() + '">' + r + '</span>';
async function loadMonsters() {
  const d = await api('/admin/monsters');
  document.getElementById('monstersTable').innerHTML = d.data.map(m =>
    '<tr><td>' + m.name + '</td><td>' + rarityBadge(m.rarity) + '</td><td>' + m.type + '</td>' +
    '<td>' + m.maxHp + '</td><td>' + m.attackPower + '</td><td>' + m.defense + '</td>' +
    '<td><span class="badge ' + (m.isActive ? 'badge-active' : 'badge-inactive') + '">' + (m.isActive ? '活躍' : '停用') + '</span></td>' +
    '<td><button class="btn btn-sm" style="background:#334155;color:#e2e8f0;margin-right:4px" onclick="editMonster(' + JSON.stringify(m).replace(/"/g,'&quot;') + ')">編輯</button>' +
    '<button class="btn btn-danger btn-sm" onclick="deleteMonster(\'' + m.id + '\')">刪除</button></td></tr>'
  ).join('');
}
function openMonsterModal(m) {
  document.getElementById('monsterModalTitle').textContent = m ? '編輯怪物' : '新增怪物';
  ['id','name','rarity','type','hp','atk','def','sponsor','lat','lng','station'].forEach(k => {
    const el = document.getElementById('monster_' + k);
    if (m) el.value = { id: m.id, name: m.name, rarity: m.rarity, type: m.type, hp: m.maxHp, atk: m.attackPower, def: m.defense, sponsor: m.sponsorName||'', lat: m.latitude, lng: m.longitude, station: m.stationId }[k] ?? '';
    else if (k !== 'rarity' && k !== 'type') el.value = k === 'hp' ? 100 : k === 'atk' ? 10 : k === 'def' ? 5 : k === 'lat' ? 25.0330 : k === 'lng' ? 121.5654 : '';
  });
  document.getElementById('monsterModal').classList.add('open');
}
function editMonster(m) { openMonsterModal(m); }
async function saveMonster() {
  const id = document.getElementById('monster_id').value;
  const body = { name: document.getElementById('monster_name').value, rarity: document.getElementById('monster_rarity').value, type: document.getElementById('monster_type').value, maxHp: +document.getElementById('monster_hp').value, attackPower: +document.getElementById('monster_atk').value, defense: +document.getElementById('monster_def').value, sponsorName: document.getElementById('monster_sponsor').value || null, latitude: +document.getElementById('monster_lat').value, longitude: +document.getElementById('monster_lng').value, stationId: document.getElementById('monster_station').value };
  if (id) await api('/admin/monsters/' + id, { method: 'PATCH', body: JSON.stringify(body) });
  else await api('/admin/monsters', { method: 'POST', body: JSON.stringify(body) });
  closeModal('monsterModal'); loadMonsters();
}
async function deleteMonster(id) {
  if (!confirm('確定刪除？')) return;
  await api('/admin/monsters/' + id, { method: 'DELETE' }); loadMonsters();
}

// ── Shop ──
async function loadShop() {
  const d = await api('/admin/shop');
  document.getElementById('shopTable').innerHTML = d.map(i =>
    '<tr><td>' + i.name + '</td><td>' + i.type + '</td><td>' + i.coinPrice + '</td><td>' + (i.ntdPrice || '—') + '</td>' +
    '<td><span class="badge ' + (i.isActive ? 'badge-active' : 'badge-inactive') + '">' + (i.isActive ? '上架' : '下架') + '</span></td>' +
    '<td><button class="btn btn-sm" style="background:#334155;color:#e2e8f0;margin-right:4px" onclick="editShop(' + JSON.stringify(i).replace(/"/g,'&quot;') + ')">編輯</button>' +
    '<button class="btn btn-danger btn-sm" onclick="deleteShop(\'' + i.id + '\')">刪除</button></td></tr>'
  ).join('');
}
function openShopModal(i) {
  document.getElementById('shopModalTitle').textContent = i ? '編輯商品' : '新增商品';
  document.getElementById('shop_id').value = i?.id || '';
  document.getElementById('shop_name').value = i?.name || '';
  document.getElementById('shop_desc').value = i?.description || '';
  document.getElementById('shop_type').value = i?.type || '';
  document.getElementById('shop_coin').value = i?.coinPrice ?? 5;
  document.getElementById('shop_ntd').value = i?.ntdPrice || '';
  document.getElementById('shopModal').classList.add('open');
}
function editShop(i) { openShopModal(i); }
async function saveShop() {
  const id = document.getElementById('shop_id').value;
  const body = { name: document.getElementById('shop_name').value, description: document.getElementById('shop_desc').value, type: document.getElementById('shop_type').value, coinPrice: +document.getElementById('shop_coin').value, ntdPrice: document.getElementById('shop_ntd').value ? +document.getElementById('shop_ntd').value : null };
  if (id) await api('/admin/shop/' + id, { method: 'PATCH', body: JSON.stringify(body) });
  else await api('/admin/shop', { method: 'POST', body: JSON.stringify(body) });
  closeModal('shopModal'); loadShop();
}
async function deleteShop(id) {
  if (!confirm('確定刪除？')) return;
  await api('/admin/shop/' + id, { method: 'DELETE' }); loadShop();
}

// ── Stations ──
async function loadStations() {
  const d = await api('/admin/stations');
  document.getElementById('stationsTable').innerHTML = d.map(s =>
    '<tr><td>' + s.name + '</td><td>' + s.type + '</td><td>' + (s.address || '—') + '</td><td>' + s.latitude + '</td><td>' + s.longitude + '</td>' +
    '<td><span class="badge ' + (s.isActive ? 'badge-active' : 'badge-inactive') + '">' + (s.isActive ? '活躍' : '停用') + '</span></td>' +
    '<td><button class="btn btn-sm" style="background:#334155;color:#e2e8f0;margin-right:4px" onclick="editStation(' + JSON.stringify(s).replace(/"/g,'&quot;') + ')">編輯</button>' +
    '<button class="btn btn-danger btn-sm" onclick="deleteStation(\'' + s.id + '\')">刪除</button></td></tr>'
  ).join('');
}
function openStationModal(s) {
  document.getElementById('stationModalTitle').textContent = s ? '編輯機台' : '新增機台';
  document.getElementById('station_id').value = s?.id || '';
  document.getElementById('station_name').value = s?.name || '';
  document.getElementById('station_address').value = s?.address || '';
  document.getElementById('station_lat').value = s?.latitude ?? 25.0330;
  document.getElementById('station_lng').value = s?.longitude ?? 121.5654;
  document.getElementById('station_type').value = s?.type || 'battery';
  document.getElementById('stationModal').classList.add('open');
}
function editStation(s) { openStationModal(s); }
async function saveStation() {
  const id = document.getElementById('station_id').value;
  const body = { name: document.getElementById('station_name').value, address: document.getElementById('station_address').value, latitude: +document.getElementById('station_lat').value, longitude: +document.getElementById('station_lng').value, type: document.getElementById('station_type').value };
  if (id) await api('/admin/stations/' + id, { method: 'PATCH', body: JSON.stringify(body) });
  else await api('/admin/stations', { method: 'POST', body: JSON.stringify(body) });
  closeModal('stationModal'); loadStations();
}
async function deleteStation(id) {
  if (!confirm('確定刪除？') ) return;
  await api('/admin/stations/' + id, { method: 'DELETE' }); loadStations();
}

// ── Battles ──
async function loadBattles() {
  const d = await api('/admin/battles');
  const statusBadge = s => '<span class="badge badge-' + s.toLowerCase() + '">' + {VICTORY:'勝利',DEFEAT:'敗北',FLED:'逃跑',IN_PROGRESS:'進行中'}[s] + '</span>';
  document.getElementById('battlesTable').innerHTML = d.data.map(b =>
    '<tr><td>' + new Date(b.createdAt).toLocaleString('zh-TW') + '</td>' +
    '<td>' + b.user.username + '</td><td>' + b.monster.name + '</td>' +
    '<td>' + rarityBadge(b.monster.rarity) + '</td><td>' + statusBadge(b.status) + '</td><td>' + b.turnCount + '</td></tr>'
  ).join('');
}

function closeModal(id) { document.getElementById(id).classList.remove('open'); }
document.querySelectorAll('.modal-overlay').forEach(el => el.addEventListener('click', e => { if (e.target === el) el.classList.remove('open'); }));

// Auto-login if token exists
if (TOKEN) {
  api('/users/me').then(d => { if (!d.error) { ME = d; enterDash(); } else { localStorage.removeItem('ecoco_token'); TOKEN = null; } });
}
</script>
</body>
</html>`);
});

// Routes
app.use('/api', routes);

// Socket.io
setupBattleSocket(io);

// Startup
async function main() {
  await redis.connect();
  await prisma.$connect();

  httpServer.listen(config.port, () => {
    console.log(`🚀 ECOCO Game Server running on http://localhost:${config.port}`);
  });
}

main().catch(console.error);

// Graceful shutdown
process.on('SIGINT', async () => {
  await prisma.$disconnect();
  await redis.quit();
  process.exit(0);
});
