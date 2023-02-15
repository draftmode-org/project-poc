<script setup lang="ts">
import CustomerDialog from '~/components/customer/CustomerDialog.vue';
import { toRef } from 'vue';
const props = defineProps({
  id: String
})
const id = toRef(props, 'id');

</script>

<template>
  Stammdatenblatt
  <customer-dialog :customer-id="id"></customer-dialog>
</template>

<style>
</style>
