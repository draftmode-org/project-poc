<script setup lang="ts">
import { Search } from '@element-plus/icons-vue'
import { storeCustomers } from '~/stores/customers';

const customerStore = storeCustomers()
</script>
<template>
  <el-input
      v-model="customerStore.searchTerm"
      class="w-100%"
      size="large"
      placeholder="Kundenname"
  >
    <template #prepend>
      <el-icon color="black">
        <Search />
      </el-icon>
    </template>
  </el-input>
</template>
