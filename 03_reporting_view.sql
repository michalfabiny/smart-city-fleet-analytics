CREATE OR REPLACE VIEW `Smart_City_fleet_management.vw_fleet_analytics` AS
SELECT 
  f.Jazda_ID,
  f.Datum_Jazdy,

  
  v.Vozidlo_ID,
  v.Typ_vozidla,
  v.Model AS Model_Vozidla,
  v.Mesto,

  
  u.Uzivatel_ID,
  u.Meno_Priezvisko,
  u.Typ_Clenstva,
  u.Vek,

  
  f.Trvanie_Minuty,
  f.Vzdialenost_KM,
  f.Cena_Celkom,

  
  SAFE_DIVIDE(f.Vzdialenost_KM, (f.Trvanie_Minuty / 60)) AS priemerna_rychlost_kmh,
  SAFE_DIVIDE(f.Cena_Celkom, f.Vzdialenost_KM) AS cena_za_km,

  
  CASE 
    WHEN u.Vek < 25 THEN '18-24'
    WHEN u.Vek BETWEEN 25 AND 39 THEN '25-39'
    WHEN u.Vek BETWEEN 40 AND 59 THEN '40-59'
    ELSE '60+'
  END AS vekova_kategoria

FROM `Smart_City_fleet_management.fakt_jazdy_optimized` f
LEFT JOIN `Smart_City_fleet_management.dim_vozidla` v ON f.Vozidlo_ID = v.Vozidlo_ID
LEFT JOIN `Smart_City_fleet_management.dim_uzivatelia` u ON u.Uzivatel_ID = f.Uzivatel_ID;
