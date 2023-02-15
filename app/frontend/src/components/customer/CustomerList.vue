<script setup lang="ts">

  import { storeCustomers } from "~/stores/customers";
  import { CUSTOMER_DIALOG } from "~/router/router-names";
  import IconEdit from '~/icons/EditPencil.vue';
  import IconDelete from '~/icons/IconDelete.vue';
  import { ElMessageBox } from 'element-plus';
  import Router from "~/router";

  const customersStore = storeCustomers()
  customersStore.fetchCustomers()
  const viewCustomer = (data: customerInterface) => {
    Router.push({name: CUSTOMER_DIALOG, params: { id: data.id}});
  }
  const deleteCustomer = (id: string) => {
    customersStore.removeById(id)
  }
</script>
<template>
  <el-table
      stripe
      style="width: 100%"
      :data="customersStore.customers" @row-click="viewCustomer">
    <el-table-column sortable class="padding-small" prop="name" label="Name"></el-table-column>
    <el-table-column sortable prop="address" label="Strasse"></el-table-column>
    <el-table-column sortable prop="city" label="Stadt" width="180"></el-table-column>
    <el-table-column width="110" @click.prevent="">
      <template #default="{ row }">
        <router-link
            class="el-button el-button--small action"
            :to="{ name: CUSTOMER_DIALOG, params: { id: row.id } }"
        >
          <IconEdit class="icon" />
        </router-link>
        <el-button class="el-button el-button--small action" @click.stop="deleteCustomer(row.id)">
          <IconDelete class="icon"/>
        </el-button>
      </template>
    </el-table-column>
  </el-table>
</template>