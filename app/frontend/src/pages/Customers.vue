<script setup lang="ts">
import CustomerList from '~/components/customer/CustomerList.vue';
//import { storeCustomers } from '~/stores/customers';
//import CustomerSearch from '~/components/customer/CustomerSearch.vue';
//const customerStore = storeCustomers()
//customerStore.fetchAll()
</script>

<template>
  <h1>Kundeliste</h1>
<!--
  <customer-search
      class="mb-3"
  />
-->
  <customer-list></customer-list>
</template>

<style>
</style>
