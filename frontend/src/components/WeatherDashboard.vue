<script>
import MainWeatherItem from "./MainWeatherItem.vue";
import WeatherItem from "./WeatherItem.vue";
import ErrorMessage from "./ErrorMessage.vue";
import API from "../lib/weather_api.js";

export default {
	data() {
		return {
			addressQuery: "",
			status: "init",
			weatherData: {},
		};
	},
	components: {
		MainWeatherItem,
		WeatherItem,
		ErrorMessage,
		ErrorMessage,
	},
	computed: {
		errorMessage() {
			if (this.status != "error") return "";

			if (this.weatherData.errors) {
				return this.weatherData.errors[0].message;
			}
		},
	},
	methods: {
		async updateWeather() {
			this.weatherData = await API.getWeatherInfo(this.addressQuery);
			this.computeStatus();
		},
		computeStatus() {
			if (this.weatherData.data) {
				this.status = "ready";
				return;
			}

			this.status = "error";
		},
	},
};
</script>
<template>
	<main>
		<form @submit.prevent="updateWeather()">
			<input class="border border-blue-600 rounded py-2 px-3 m-1" type="text" v-model="addressQuery" placeholder="Enter your address..." required="true" />
			<button class="border border-blue-600 rounded py-2 px-3 m-1">Search</button>
			<div v-if="status == 'fetching'">Spinner...</div>
		</form>
		<div>
			<div v-if="status == 'ready'">
				<MainWeatherItem :address="weatherData.data.forecast.address" :weatherInfo="weatherData.data.forecast.forecasts[0]" />
				<div v-for="weatherInfo in weatherData.data.forecast.forecasts.slice(1)">
					REST
					<WeatherItem :weatherInfo="weatherInfo" />
				</div>
			</div>
			<div v-if="status == 'error'">
				<ErrorMessage :message="errorMessage" />
			</div>
		</div>
	</main>
</template>
