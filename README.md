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
- [ ] Define models for weather
- [ ] Migrations for weather
- [ ] Weather clients
- [ ] Wheater service layer
- [ ] GrapqhQL layer

## Frontend Setup
- [ ] Dockerized frontend

## Frontend
- [ ] Layout
- [ ] Client
- [ ] Connections
