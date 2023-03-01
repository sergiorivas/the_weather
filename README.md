# The Weather APP

- Retrieve forecast data for the given address.
- Cache the forecast details for 30 minutes for all subsequent requests by zip codes.
- Display indicator if result is pulled from cache.

## How to run?

```
docker-compose up
```

## How to run backend tests

```
docker-compose run --rm weather_api rspec --format=documentation
```

# Strategy

1. Create a backend/frontend for flexibility on multiple clients, ans scalability
2. The API will be GraphQL for different clients
3. Create client wrapper or use existent gems for accesing the data
4. If time externalize the backend client wrappers to gems

# Tasks

## Research
- [x] Weather public APIs
- [x] Location public API (from address)

### Goal
- Find APIs that allows you to retreive weather data based on an address

### Outcome
- It seems weather API needs latitude and longitude as an input
- We will need another API for translate an address to latitude and longitude

## Backend Setup
- [x] Dockerized Rails API
- [x] Rspec
- [x] Rubocop
- [x] FactoryBot
- [x] Annotate (Models)
- [x] CORS

## Backend
- [x] Define models for location
- [x] Migrations for location
- [x] Location client (radar API)
- [x] Location service layer
- [x] Location service cache logic
- [x] Weather client (weather.gov)
- ~~Define models for weather~~ (Not needed)
- ~~Migrations for weather~~ (Not needed)
- [x] Wheater service layer
- [x] Wheater service cache feature
- [x] GrapqhQL layer

### GraphQL:

```
POST http://localhost:3000/graphql
```

with payload `query=`

#### Query
```grapql
query{
    forecast(addressQuery: "One Apple Park Way, Cupertino"){
        address {
            latitude
            longitude
            formalAddress
            zipcode
            informalAddress
        }
        forecasts {
            temperature
            temperatureUnit
            startTime
            endTime
            name
            relativeHumitidy
            windSpeed
            windDirection
            iconUrl
            summary
            forecastDescription
        }
        createdAt
        fromCache
    }
}
```
#### Response
```json
{
    "data": {
        "forecast": {
            "address": {
                "latitude": 37.330614,
                "longitude": -122.011627,
                "formalAddress": "Apple Park Way, Cupertino, CA 95014 USA",
                "zipcode": "95014",
                "informalAddress": "🇺🇸 , Cupertino, California, United States"
            },
            "forecasts": [
                {
                    "temperature": 54,
                    "temperatureUnit": "F",
                    "startTime": "2023-03-01 09:00:00 -0800",
                    "endTime": "2023-03-01 18:00:00 -0800",
                    "name": "Today",
                    "relativeHumitidy": 80,
                    "windSpeed": "12 to 18 mph",
                    "windDirection": "NW",
                    "iconUrl": "https://api.weather.gov/icons/land/day/few?size=medium",
                    "summary": "Sunny",
                    "forecastDescription": "Sunny. High near 54, with temperatures falling to around 52 in the afternoon. Northwest wind 12 to 18 mph, with gusts as high as 24 mph."
                },
                {
                    "temperature": 32,
                    "temperatureUnit": "F",
                    "startTime": "2023-03-01 18:00:00 -0800",
                    "endTime": "2023-03-02 06:00:00 -0800",
                    "name": "Tonight",
                    "relativeHumitidy": 87,
                    "windSpeed": "6 to 13 mph",
                    "windDirection": "WNW",
                    "iconUrl": "https://api.weather.gov/icons/land/night/few?size=medium",
                    "summary": "Mostly Clear then Widespread Frost",
                    "forecastDescription": "Widespread frost after 1am. Mostly clear. Low around 32, with temperatures rising to around 34 overnight. West northwest wind 6 to 13 mph."
                },
                ...
            ],
            "createdAt": "2023-03-01 17:58:35 UTC",
            "fromCache": false
        }
    }
}
```

## Frontend Setup
- [x] Dockerized frontend

## Frontend
- [ ] Layout
- [ ] Client
- [ ] Connections
