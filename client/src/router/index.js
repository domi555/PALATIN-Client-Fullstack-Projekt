import Vue from 'vue';
import VueRouter from 'vue-router';
import Patient from '../views/Patient.vue';
import Arzt from '../views/Arzt.vue';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'Patient',
    component: Patient,
  },
  {
    path: '/arzt',
    name: 'Arzt',
    component: Arzt,
  },
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
});

export default router;
