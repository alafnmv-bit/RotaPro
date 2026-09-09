CREATE TABLE IF NOT EXISTS users (
 id SERIAL PRIMARY KEY,
 name TEXT NOT NULL,
 phone TEXT UNIQUE NOT NULL,
 password_hash TEXT NOT NULL,
 role TEXT NOT NULL CHECK (role IN ('admin','driver')) DEFAULT 'driver',
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS drivers (
 user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
 pix_type TEXT,
 pix_key TEXT,
 available BOOLEAN NOT NULL DEFAULT FALSE,
 last_lat DOUBLE PRECISION,
 last_lng DOUBLE PRECISION,
 last_location_at TIMESTAMPTZ
);
CREATE TABLE IF NOT EXISTS neighborhoods (
 id SERIAL PRIMARY KEY,
 name TEXT UNIQUE NOT NULL,
 fee NUMERIC(10,2) NOT NULL
);
CREATE TABLE IF NOT EXISTS clients (
 id SERIAL PRIMARY KEY,
 name TEXT NOT NULL,
 phone TEXT,
 address TEXT NOT NULL,
 neighborhood_id INTEGER REFERENCES neighborhoods(id),
 favorite BOOLEAN NOT NULL DEFAULT FALSE,
 created_by INTEGER REFERENCES users(id),
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS orders (
 id SERIAL PRIMARY KEY,
 client_id INTEGER REFERENCES clients(id),
 client_name TEXT NOT NULL,
 address TEXT NOT NULL,
 neighborhood_id INTEGER REFERENCES neighborhoods(id),
 fee NUMERIC(10,2) NOT NULL,
 status TEXT NOT NULL CHECK(status IN ('pending','accepted','picked_up','delivered','rejected','cancelled')) DEFAULT 'pending',
 driver_id INTEGER REFERENCES users(id),
 created_by INTEGER REFERENCES users(id),
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 accepted_at TIMESTAMPTZ,
 delivered_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS orders_status_idx ON orders(status);
CREATE INDEX IF NOT EXISTS orders_driver_idx ON orders(driver_id);
CREATE INDEX IF NOT EXISTS neighborhoods_name_idx ON neighborhoods(name);
