-- Database schema initialization for cpu_scores

CREATE TABLE IF NOT EXISTS cpus (
    id VARCHAR(100) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    family VARCHAR(255),
    release_year INTEGER,
    price_usd NUMERIC,
    specifications JSONB NOT NULL,
    benchmarks JSONB NOT NULL
);

-- Seed values for the initial 5 CPUs
INSERT INTO cpus (id, name, brand, family, release_year, price_usd, specifications, benchmarks)
VALUES
(
  'intel-core-i9-14900k',
  'Intel Core i9-14900K',
  'Intel',
  'Raptor Lake Refresh',
  2023,
  589,
  '{"totalCores": 24, "performanceCores": 8, "efficiencyCores": 16, "threads": 32, "baseClockGHz": 3.2, "boostClockGHz": 6.0, "l3CacheMB": 36, "tdpWatts": 125, "maxTurboTdpWatts": 253, "socket": "LGA1700", "memoryType": ["DDR4", "DDR5"], "maxMemorySpeedMHz": 5600, "integratedGraphics": "Intel UHD Graphics 770", "lithography": "Intel 7 (10nm)", "pcieLanes": 20, "pcieVersion": "5.0"}',
  '{"cinebench_r23": {"singleCore": 2253, "multiCore": 38765, "source": "Cinebench R23"}, "geekbench_6": {"singleCore": 3190, "multiCore": 19850, "source": "Geekbench 6"}, "blender_monster": {"score": 392.5, "unit": "samples/min"}, "passmark": {"score": 63200}}'
),
(
  'amd-ryzen-7-7800x3d',
  'AMD Ryzen 7 7800X3D',
  'AMD',
  'Raphael (Zen 4 + 3D V-Cache)',
  2023,
  449,
  '{"totalCores": 8, "performanceCores": 8, "efficiencyCores": 0, "threads": 16, "baseClockGHz": 4.2, "boostClockGHz": 5.0, "l3CacheMB": 96, "tdpWatts": 120, "maxTurboTdpWatts": 120, "socket": "AM5", "memoryType": ["DDR5"], "maxMemorySpeedMHz": 5200, "integratedGraphics": "AMD Radeon Graphics (RDNA 2)", "lithography": "TSMC 5nm", "pcieLanes": 24, "pcieVersion": "5.0"}',
  '{"cinebench_r23": {"singleCore": 1848, "multiCore": 18285, "source": "Cinebench R23"}, "geekbench_6": {"singleCore": 2740, "multiCore": 13960, "source": "Geekbench 6"}, "blender_monster": {"score": 183.7, "unit": "samples/min"}, "passmark": {"score": 37950}}'
),
(
  'apple-m3-max',
  'Apple M3 Max',
  'Apple',
  'M3 (3nm)',
  2023,
  1999,
  '{"totalCores": 16, "performanceCores": 12, "efficiencyCores": 4, "threads": 16, "baseClockGHz": 3.35, "boostClockGHz": 4.05, "l3CacheMB": 48, "tdpWatts": 92, "maxTurboTdpWatts": 92, "socket": "BGA (Integrated SoC)", "memoryType": ["LPDDR5X (Unified)"], "maxMemorySpeedMHz": 6400, "integratedGraphics": "Apple M3 Max GPU (40-core)", "lithography": "TSMC 3nm", "pcieLanes": 0, "pcieVersion": "N/A (SoC)"}',
  '{"cinebench_r23": {"singleCore": 1876, "multiCore": 21320, "source": "Cinebench R23"}, "geekbench_6": {"singleCore": 3750, "multiCore": 21450, "source": "Geekbench 6"}, "blender_monster": {"score": 244.1, "unit": "samples/min"}, "passmark": {"score": 48600}}'
),
(
  'amd-ryzen-9-7950x',
  'AMD Ryzen 9 7950X',
  'AMD',
  'Raphael (Zen 4)',
  2022,
  699,
  '{"totalCores": 16, "performanceCores": 16, "efficiencyCores": 0, "threads": 32, "baseClockGHz": 4.5, "boostClockGHz": 5.7, "l3CacheMB": 64, "tdpWatts": 170, "maxTurboTdpWatts": 230, "socket": "AM5", "memoryType": ["DDR5"], "maxMemorySpeedMHz": 5200, "integratedGraphics": "AMD Radeon Graphics (RDNA 2)", "lithography": "TSMC 5nm", "pcieLanes": 24, "pcieVersion": "5.0"}',
  '{"cinebench_r23": {"singleCore": 2063, "multiCore": 38254, "source": "Cinebench R23"}, "geekbench_6": {"singleCore": 3025, "multiCore": 21800, "source": "Geekbench 6"}, "blender_monster": {"score": 376.2, "unit": "samples/min"}, "passmark": {"score": 59800}}'
),
(
  'intel-core-ultra-9-285k',
  'Intel Core Ultra 9 285K',
  'Intel',
  'Arrow Lake',
  2024,
  589,
  '{"totalCores": 24, "performanceCores": 8, "efficiencyCores": 16, "threads": 24, "baseClockGHz": 3.7, "boostClockGHz": 5.7, "l3CacheMB": 36, "tdpWatts": 125, "maxTurboTdpWatts": 250, "socket": "LGA1851", "memoryType": ["DDR5"], "maxMemorySpeedMHz": 6400, "integratedGraphics": "Intel Graphics (Xe-LP)", "lithography": "Intel 20A / TSMC N3B", "pcieLanes": 24, "pcieVersion": "5.0"}',
  '{"cinebench_r23": {"singleCore": 2162, "multiCore": 35140, "source": "Cinebench R23"}, "geekbench_6": {"singleCore": 3380, "multiCore": 18950, "source": "Geekbench 6"}, "blender_monster": {"score": 345.8, "unit": "samples/min"}, "passmark": {"score": 58100}}'
)
ON CONFLICT (id) DO NOTHING;
