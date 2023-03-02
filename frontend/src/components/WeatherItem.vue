<script>
export default {
	props: {
		weatherInfo: Object,
	},
};
</script>
<template>
	<div class="bg-orange-300 text-blue-800 px-3 py-2 rounded-lg mt-3 mx-auto w-6/12 flex justify-between">
		<div class="text-left w-1/3">
			<div class="text-xl">
				{{ weatherInfo.name }}
			</div>
			<div class="text-4xl text-orange-700">{{ weatherInfo.temperature }} {{ weatherInfo.temperatureUnit }}&deg;</div>
		</div>
		<div>
			<img class="scale-75 rounded-full" :src="weatherInfo.iconUrl" />
		</div>
		<div class="w-1/3 text-xl">
			<div class="text-end text-black">
				<div>{{ weatherInfo.summary }}</div>
			</div>
		</div>
	</div>
</template>
