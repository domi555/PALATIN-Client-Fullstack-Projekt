import Vue from 'vue';
import VueRouter from 'vue-router';
import Pass from '../views/Pass.vue';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'Pass',
    component: Pass,
  },
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
});

export default router;
