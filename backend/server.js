const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
const port = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

// Set up PostgreSQL Pool connection using environment variables
const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432', 10),
  database: process.env.DB_NAME || 'cpu_scores',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || '1234',
  connectionTimeoutMillis: 5000,
});

// Middleware for logging requests
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
  next();
});

// Test connection endpoint
app.get('/api/health', async (req, res) => {
  try {
    const client = await pool.connect();
    const result = await client.query('SELECT NOW()');
    client.release();
    res.json({ status: 'healthy', dbTime: result.rows[0].now });
  } catch (err) {
    console.error('Db connection error in health check:', err.message);
    res.status(500).json({ status: 'unhealthy', error: err.message });
  }
});

// GET /api/cpus - Retrieve all CPUs
app.get('/api/cpus', async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT id, name, brand, family, release_year AS "releaseYear", price_usd, specifications, benchmarks 
       FROM cpus`
    );
    res.json({ cpus: result.rows });
  } catch (err) {
    console.error('Failed to retrieve CPUs:', err.message);
    res.status(500).json({ error: 'Failed to retrieve CPUs from database' });
  }
});

// POST /api/cpus - Add a new CPU
app.post('/api/cpus', async (req, res) => {
  const { id, name, brand, family, releaseYear, price_usd, specifications, benchmarks } = req.body;

  if (!name || !brand || !id) {
    return res.status(400).json({ error: 'id, name, and brand are required fields' });
  }

  try {
    const query = `
      INSERT INTO cpus (id, name, brand, family, release_year, price_usd, specifications, benchmarks)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        brand = EXCLUDED.brand,
        family = EXCLUDED.family,
        release_year = EXCLUDED.release_year,
        price_usd = EXCLUDED.price_usd,
        specifications = EXCLUDED.specifications,
        benchmarks = EXCLUDED.benchmarks
      RETURNING id, name, brand, family, release_year AS "releaseYear", price_usd, specifications, benchmarks
    `;
    const values = [
      id,
      name,
      brand,
      family || null,
      releaseYear ? parseInt(releaseYear, 10) : null,
      price_usd ? parseFloat(price_usd) : null,
      specifications || {},
      benchmarks || {},
    ];

    const result = await pool.query(query, values);
    console.log(`Successfully added/updated CPU: ${name} (${id})`);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error('Failed to save CPU:', err.message);
    res.status(500).json({ error: 'Failed to save CPU to database' });
  }
});

app.listen(port, () => {
  console.log(`Backend server running on port ${port}`);
});
