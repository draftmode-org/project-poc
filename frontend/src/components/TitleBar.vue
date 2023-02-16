<script setup lang="ts">
import { useRouter } from 'vue-router';

const router = useRouter()
const onNavigateBack = () => {
  router.back()
}
const logout = () => {
  console.log('logout')
}
</script>

<template>
  <el-page-header class="main" @back="onNavigateBack">
    <template #content>
      <div class="flex items-center">
        <img height="32" src="/src/assets/logo.svg"  alt="logo"/>
        <span class="text-large font-600 ml-3">webfux.io - POC</span>
      </div>
    </template>
<!--    <template #extra>
      <div class="flex items-center">
        <el-button style="margin-left:auto;" class="ml-auto" @click="logout">Logout</el-button>
      </div>
    </template>
-->
  </el-page-header>
</template>

<style>
</style>
