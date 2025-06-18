select
    geolocation_zip_code_prefix as geolocation_id,
    geolocation_zip_code_prefix as geo_zipcode,
    geolocation_lat as geo_latitude,
    geolocation_lng as geo_longitude,
    geolocation_city as geo_city,
    geolocation_state as geo_state
from {{ source('olist', 'geolocation') }}
