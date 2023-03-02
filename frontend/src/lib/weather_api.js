export default {
  async getWeatherInfo(addressQuery) {
    const query = `
    query{
        forecast(addressQuery: "${addressQuery}"){
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
    }`;
    try {
      const response = await fetch("http://localhost:3000/graphql", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          query: `${query}`,
        }),
      });
      const result = await response.json();
      console.log('result:', result)
      return result
    } catch (e) {
      return {
        errors: [
          {
            message: 'Weird error!'
          }
        ]
      }
    }
  }
}
