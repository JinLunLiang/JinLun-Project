--Check data type
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'worldometer_data';