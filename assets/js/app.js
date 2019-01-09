import Vue from "vue";
import VueRouter from "vue-router";

import "axios";
import bookingz from "./bookingz";

Vue.use(VueRouter);

Vue.component("bookingz", bookingz);

var router = new VueRouter({
  routes: [
      { path: '/', component: bookingz },
      { path: '*', redirect: '/' }
  ]
});

new Vue({router}).$mount("#app");