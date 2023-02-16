import { defineStore } from 'pinia'
import { CUSTOMERS } from './store-names'
import { ref } from 'vue'
import { customerApi } from "~/api/Customer";
import { ElMessageBox } from 'element-plus'

export const storeCustomers = defineStore(CUSTOMERS, () => {
    const customers = ref([])
    let loaded = false

    const reloadCustomers = async () => {
        loaded=false;
        return fetchCustomers()
    }

    const fetchCustomers = async () => {
        if (!loaded) {
            customers.value = customerApi.fetchAll()
            loaded=true
        }
    }

    const removeById = async (id: string) => {
        try {
            const result = await ElMessageBox.confirm(
                'Do you really want to delete this customer? It will permanently delete the customer',
                'Remove Customer'
            )
            console.log('result', result);
            const removeIndex = customers.value.findIndex((customer: customerInterface) => {
                return customer.id === id
            })
            customers.value.splice(removeIndex, 1)
            return true
        }
        catch {
            return false
        }
    }

    return {
        customers,
        fetchCustomers,
        reloadCustomers,
        removeById
    }
})