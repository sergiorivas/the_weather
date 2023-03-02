<script>
export default {
	props: {
		message: String,
	},
};
</script>
<template>
	<div class="bg-red-500 text-white px-3 py-2 font-bold rounded-lg mt-3 mx-auto w-7/12">
		ERROR: {{ message }}
	</div>
</template>
