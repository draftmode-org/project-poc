<script setup lang="ts">
  import { reactive, ref, toRef } from 'vue';
  import { storeCustomer } from "~/stores/customer";
  import IconSave from '~/icons/IconSave.vue';
  import IconCancel from '~/icons/IconCancel.vue';
  import IconDelete from "~/icons/IconDelete.vue";
  import { ElMessage, ElMessageBox, Action, FormInstance } from 'element-plus'
  import Router from "~/router";

  const customerStore = storeCustomer()
  const props = defineProps({
    customerId: String
  })
  const id = toRef(props, 'customerId');
  customerStore.fetch(id.value);

  const customer = toRef(customerStore, 'customer')

  const formRef = ref<FormInstance>()

  const onSubmit = () => {
    ElMessageBox.confirm(
        'Do you really want to delete this customer? It will permanently delete the customer',
        'Remove Customer',{
          distinguishCancelAndClose: true,
          confirmButtonText: 'Save',
          cancelButtonText: 'Discard Changes',
        }
    )
    .then ((id: string) => {
      ElMessage({
        type: 'info',
        message: 'Changes saved. Proceeding to a new route.',
      })
    })
    .catch((action: Action) => {
      ElMessage({
        type: 'info',
        message:
            action === 'cancel'
                ? 'Changes discarded. Proceeding to a new route.'
                : 'Stay in the current route',
      })
    })
  }

  const onDelete = async () => {
    const removed = await customerStore.remove()
    if (removed) {
      Router.go(-1)
    }
  }

  const onCancel = (formEl: FormInstance | undefined) => {
    Router.go(-1)
  }

  const onReset = (formEl: FormInstance | undefined) => {
    formEl.resetFields()
  }

</script>
<template>
  <h1>Kunde</h1>
  <el-form
      ref="formRef"
      label-position="left"
      label-width="120px"
      :model="customerStore.customer"
      @submit.prevent
      status-icon
  >
    <el-form-item label="Name" required prop="name">
      <el-input v-model="customer.name" placeholder="Name" />
    </el-form-item>
    <el-form-item label="Address" prop="address" required>
      <el-col :span="12">
        <el-form-item >
          <el-input v-model="customer.address" placeholder="Strasse, Nr" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item label="Stadt" class="label-position-left" prop="city" required>
          <el-input v-model="customer.city" placeholder="Stadt"/>
        </el-form-item>
      </el-col>
    </el-form-item>
    <el-form-item>
      <el-button-group>
        <el-button type="success" @click="onSubmit">
          <icon-save class="h-5 mr-1" />
          Speichern
        </el-button>
        <el-button type="info" @click="onCancel(formRef)">
          <icon-cancel class="h-5 mr-1" />
          Abbrechen
        </el-button>
      </el-button-group>

      <el-button-group class="ml-4">
        <el-button type="warning" @click="onDelete">
          <icon-delete class="h-5 mr-1" />
          Löschen
        </el-button>
      </el-button-group>
    </el-form-item>
  </el-form>
</template>