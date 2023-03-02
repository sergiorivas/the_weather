<script>
import MainWeatherItem from "./MainWeatherItem.vue";
import WeatherItem from "./WeatherItem.vue";
import ErrorMessage from "./ErrorMessage.vue";
import Loading from "./Loading.vue";
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
		Loading,
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
			this.status = "fetching";
			const result = await API.getWeatherInfo(this.addressQuery);
			console.log(result, 234);
			this.weatherData = result;
			this.computeStatus();
		},
		computeStatus() {
			if (this.weatherData.errors) {
				this.status = "error";
				return;
			}

			this.status = "ready";
		},
	},
};
</script>
<template>
	<main class="content rounded my-2 text-center py-6 px-4 bg-gradient-to-r from-cyan-400 to-blue-600 mx-auto md:w-2/3 w-full">
		<h1 class="font-bold text-4xl text-white my-5">Weather APP</h1>
		<form class="t" @submit.prevent="updateWeather()">
			<input class="border border-blue-600 rounded text-blue-600 py-2 px-3 shadow px-3 py-2 w-1/2" type="text" v-model="addressQuery" placeholder="Enter your address..." required="true" />
			<button class="border border-blue-800 bg-blue-600 text-white rounded py-2 px-7 m-1" :disabled="this.status == 'fetching'">Search</button>
			<div class="my-3" v-if="status == 'fetching'">
				<Loading />
			</div>
		</form>
		<div>
			<div v-if="status == 'ready'">
				<div class="mx-auto bg-indigo-200 w-7/12 rounded mt-4" v-if="weatherData.data.forecast.fromCache">FROM CACHE</div>
				<MainWeatherItem :address="weatherData.data.forecast.address" :weatherInfo="weatherData.data.forecast.forecasts[0]" />
				<div v-for="weatherInfo in weatherData.data.forecast.forecasts.slice(1)">
					<WeatherItem :weatherInfo="weatherInfo" />
				</div>
			</div>
			<div v-if="status == 'error'">
				<ErrorMessage :message="errorMessage" />
			</div>
		</div>
	</main>
</template>
