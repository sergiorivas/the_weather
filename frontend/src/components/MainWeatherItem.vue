<script>
export default {
	props: {
		address: String,
		weatherInfo: Object,
	},
};
</script>
<template>
	<div>
		ADDRESS1
		{{ address }}
		CARD
		{{ weatherInfo }}
	</div>
</template>
