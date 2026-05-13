# Supabase Configuration

## Database Setup

### SQL Format
- Postgresql Supabase

### schema.sql
Gunakan schema.sql untuk membuat schema database, formatnya:
- Hanya boleh query CREATE DAN DROP
- Tidak boleh ada query CREATE INDEX, dan INSERT
- Sebelum CREATE TABLE, harus ada DROP TABLE DULU

```sql
CASCADE DROP ...
CREATE TABLE ...

CASCADE DROP ...
CREATE TABLE ...
```

### schema_seeder.sql
- Hanya berisi query INSERT

## Example Structure
```
schema.sql          -- Table creation and drops
schema_seeder.sql   -- Data seeding with INSERT statements
```
