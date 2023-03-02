<script>
export default {
	props: {
		address: String,
		weatherInfo: Object,
	},
};
</script>
<template>
	<div class="bg-white text-blue-800 px-3 py-6 rounded-lg mt-3 mx-auto w-7/12">
		<div class="text-center text-orange-800 text-xl font-bold">
			{{ address.formalAddress }}
		</div>
		<div class="text-center font-bold">{{ address.latitude }}, {{ address.longitude }}</div>
		<div class="text-center text-l">WIND: {{ weatherInfo.windSpeed }} ({{ weatherInfo.windDirection }})</div>
		<div class="bg-white text-blue-800 px-3 py-6 rounded-lg mt-3 mx-auto flex justify-between">
			<div class="text-left w-1/3">
				<div class="text-xl">
					{{ weatherInfo.name }}
				</div>
				<div class="text-4xl text-orange-700">{{ weatherInfo.temperature }} {{ weatherInfo.temperatureUnit }}&deg;</div>
			</div>
			<div>
				<img class="rounded-full" :src="weatherInfo.iconUrl" />
			</div>
			<div class="w-1/3 text-xl">
				<div class="text-end text-black">
					<div>{{ weatherInfo.summary }}</div>
				</div>
			</div>
		</div>
		<div class="text-center font-bold">
			{{ weatherInfo.forecastDescription }}
		</div>
	</div>
</template>
