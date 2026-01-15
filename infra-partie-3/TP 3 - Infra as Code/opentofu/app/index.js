import express from "express";
import pkg from "pg";

const { Pool } = pkg;

const app = express();
const port = process.env.PORT || 3000;

const pool = new Pool({
    host: process.env.PGHOST,
    port: Number(process.env.PGPORT || 5432),
    user: process.env.PGUSER,
    password: process.env.PGPASSWORD,
    database: process.env.PGDATABASE,
});

app.get("/", (req, res) => {
    res.json({
        status: "ok",
        message: "WebSolutions API (behind Nginx)",
    });
});

app.get("/health", async (req, res) => {
    try {
        const r = await pool.query("SELECT 1 as ok;");
        res.json({ status: "ok", db: r.rows[0] });
    } catch (e) {
        res.status(500).json({ status: "error", error: String(e.message || e) });
    }
});

app.listen(port, () => {
    console.log(`API listening on port ${port}`);
});