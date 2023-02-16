<script setup lang="ts">
import * as ROUTE_NAMES from '~/router/router-names'
import DashboardIcon from '~/icons/Dashboard.vue'
import CustomerIcon from '~/icons/Customer.vue'
</script>
<!-- https://uxwing.com/ -->
<template>
  <el-menu default-active="DASHBOARD" router :unique-opened=true>
      <el-menu-item index="DASHBOARD" :route="{ name: ROUTE_NAMES.DASHBOARD }">
        <el-icon>
          <dashboard-icon />
        </el-icon>
        <span>Dashboard</span>
      </el-menu-item>
    <el-menu-item index="CUSTOMER_LIST" :route="{ name: ROUTE_NAMES.CUSTOMER_LIST }">
      <el-icon>
        <customer-icon />
      </el-icon>
      <span>Kunden</span>
    </el-menu-item>
  </el-menu>
</template>