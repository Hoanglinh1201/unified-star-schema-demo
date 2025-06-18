select
    geolocation_id as _key_geolocation_id,
    geolocation_id,
    geo_latitude,
    geo_longitude,
    geo_city,
    geo_state
from {{ ref('stg_geolocations') }}
