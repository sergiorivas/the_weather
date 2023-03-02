<script>
export default {
	data() {
		return {
			addressQuery: "",
			status: "init",
			weatherData: {},
		};
	},
	computed: {
		errorMessage() {
			if (this.status != "error") return "";

			if (this.weatherData.errors) {
				return this.weatherData.errors[0].message;
			}

			return "Sorry, we are having some errors now!";
		},

		currentWeatherInfo() {
			if (this.status != "ready") return;
			return this.weatherData.data.forecast.forecasts[0];
		},

		additionalWeatherInfo() {
			if (this.status != "ready") return;
			return this.weatherData.data.forecast.forecasts.slice(1);
		},

		address() {
			if (this.status != "ready") return;
			return this.weatherData.data.forecast.address;
		},
	},
	methods: {
		async getWeather() {
			const query = `
      query{
          forecast(addressQuery: "${this.addressQuery}"){
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
				this.status = "fetching";
				const response = await fetch("http://localhost:3000/graphql", {
					method: "POST",
					headers: { "Content-Type": "application/json" },
					body: JSON.stringify({
						query: `${query}`,
					}),
				});
				this.weatherData = await response.json();
				if (this.weatherData.errors) {
					this.status = "error";
					return;
				}
			} catch (e) {
				this.status = "error";
				return;
			}
			this.status = "ready";
		},
	},
};
</script>
<template>
	<main>
		<form @submit.prevent="getWeather()">
			<input class="border border-blue-600 rounded py-2 px-3 m-1" type="text" v-model="addressQuery" placeholder="Enter your address..." required="true" />
			<button class="border border-blue-600 rounded py-2 px-3 m-1">Search</button>
			<div v-if="status == 'fetching'">Spinner...</div>
		</form>
		<div>
			<div v-if="status == 'ready'">
				<div>
					ADDRESS
					{{ address }}
					CARD
					{{ currentWeatherInfo }}
				</div>
				<div>
					REST
					{{ additionalWeatherInfo }}
				</div>
			</div>
			<div v-if="status == 'error'">
				ERROR
				{{ errorMessage }}
			</div>
		</div>
	</main>
</template>
