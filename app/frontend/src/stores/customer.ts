import { defineStore } from 'pinia'
import { CUSTOMER } from './store-names'
import { storeCustomers } from './customers'
import { ref } from 'vue'
import { customerApi } from "~/api/Customer";

export const storeCustomer = defineStore(CUSTOMER, () => {
    const customer = ref<customerInterface>({
        'id' : null,
        'name' : null,
        'address' : null,
        'city': null
    })

    const save = async () => {
        return customerApi.put(customer.value.id, customer.value)
    }

    const remove = async () => {
        const customersStore = storeCustomers()
        return customersStore.removeById(customer.value.id)
    }

    const fetch = async (id: string) => {
        customer.value = customerApi.fetch(id)
    }
    return {
        customer,
        fetch,
        save,
        remove
    }
})