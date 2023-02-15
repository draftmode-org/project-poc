<script setup lang="ts">
import * as ROUTE_NAMES from '~/router/router-names'
import DashboardIcon from '~/icons/Dashboard.vue'
import BillingIncomeIcon from '~/icons/BillingIncome.vue'
import BillingOutcomeIcon from '~/icons/BillingOutcome.vue'
import BillingIcon from '~/icons/Billing.vue'
import CustomerIcon from '~/icons/Customer.vue'
import ObjectIcon from '~/icons/Object.vue'
import SchedulerIcon from '~/icons/Scheduler.vue'
import VehicleLogIcon from '~/icons/VehicleLog.vue'
import WarehouseIcon from '~/icons/Warehouse.vue'
import SetupIcon from "~/icons/Setup.vue";
import RequestIcon from "~/icons/Request.vue";
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