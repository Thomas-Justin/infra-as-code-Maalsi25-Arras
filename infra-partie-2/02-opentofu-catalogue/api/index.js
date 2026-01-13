const express = require('express');
const { Pool } = require('pg');
const { createClient } = require('redis');

const app = express();
const PORT = 3000;

const pgPool = new Pool({
  host: 'postgres',
  port: 5432,
  user: 'demo_user',
  password: 'demo_pass',
  database: 'demo_db'
});

// redis
const redisClient = createClient({
  url: 'redis://default:demo_pass@redis:6379'
});
redisClient.connect().catch(console.error);

// juste pour check vite fait si c'est ok
app.get('/health', async (req, res) => {
  try {
    await pgPool.query('SELECT 1');
    await redisClient.ping();
    res.json({ status: 'ok', db: 'reachable', cache: 'reachable' });
  } catch (err) {
    res.status(500).json({ status: 'error', error: err.message });
  }
});

app.get('/products', async (req, res) => {
  try {
    const cache = await redisClient.get('products');
    if (cache) return res.json({ source: 'cache', data: JSON.parse(cache) });

    const result = await pgPool.query('SELECT * FROM products LIMIT 5');
    await redisClient.setEx('products', 60, JSON.stringify(result.rows));
    res.json({ source: 'db', data: result.rows });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(PORT, () => console.log(`API listening on port ${PORT}`));