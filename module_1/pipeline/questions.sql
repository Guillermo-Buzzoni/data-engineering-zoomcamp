-- Question 3. Counting short trips
SELECT COUNT(*) AS trips_less_than_1_mile
FROM green_taxi_trips
WHERE lpep_pickup_datetime >= '2025-11-01'
AND lpep_pickup_datetime <  '2025-12-01'
AND trip_distance <= 1;
-- Answer: 8007

-- Question 4. Longest trip for each day
SELECT
DATE(lpep_pickup_datetime) AS pickup_day,
MAX(trip_distance) AS max_trip_distance
FROM green_taxi_trips
WHERE trip_distance < 100
GROUP BY DATE(lpep_pickup_datetime)
ORDER BY max_trip_distance DESC
LIMIT 1;
-- Answer: 2025-11-14

-- Question 5. Biggest pickup zone
SELECT
z.zone,
SUM(t.total_amount) total_amount
FROM green_taxi_trips t
LEFT JOIN taxi_zones z ON t.PU_location_id = z.location_id
WHERE DATE(t.lpep_pickup_datetime) = '2025-11-18'
GROUP BY z.Zone
ORDER BY SUM(t.total_amount) DESC
LIMIT 1;
-- Answer: East Harlem North

-- Question 6. Largest tip
SELECT dz.zone drop_off_zone,
	MAX(t.tip_amount) max_tip
FROM green_taxi_trips t
LEFT JOIN taxi_zones pz ON t.pu_location_id = pz.location_id
LEFT JOIN taxi_zones dz ON t.do_location_id = dz.location_id
WHERE pz.zone = 'East Harlem North'
  AND t.lpep_pickup_datetime >= TIMESTAMP '2025-11-01 00:00:00'
  AND t.lpep_pickup_datetime <  TIMESTAMP '2025-12-01 00:00:00'
GROUP BY dz.zone
ORDER BY MAX(tip_amount) DESC
LIMIT 1;
-- Answer: Yorkville West