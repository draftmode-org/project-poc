// @ts-ignore
import { createRouter, createWebHistory } from "vue-router"
import * as ROUTE_NAMES from '~/router/router-names'

const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: '/',
            redirect: {name: ROUTE_NAMES.DASHBOARD},
            meta: { breadCrumb: 'Home' }
        },
        {
            path: '/dashboard',
            name: ROUTE_NAMES.DASHBOARD,
            component: () => import('~/pages/Dashboard.vue'),
            meta: { breadCrumb: 'Dashboard' }
        },
        {
            path: '/customers',
            name: ROUTE_NAMES.CUSTOMER_LIST,
            component: () => import('~/pages/Customers.vue'),
            meta: { breadCrumb: 'Dashboard' }
        },
        {
            path: '/customers/:id',
            name: ROUTE_NAMES.CUSTOMER_DIALOG,
            props: true,
            component: () => import('~/pages/Customer.vue'),
            meta: { breadCrumb: 'Dashboard' }
        }
    ]
})

export default router
