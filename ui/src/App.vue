<script setup>
import api from "./api";
import { onMounted, onUnmounted } from "vue";
import { useResourceStripStore } from "@/store/resourceStrip";
import ResourceStrip from "@/components/ResourceStrip.vue";

const store = useResourceStripStore();

const onMessage = (event) => {
  if (event.data.type === "state") {
    store.applyState(event.data.state);
  }
};

onMounted(async () => {
  window.addEventListener("message", onMessage);

  // Unlike the old togglable popup, this page is live from resource start
  // -- there's no user action to guarantee client/services/hud.lua has had
  // a chance to send anything before this component mounts. Ask for the
  // current config/state directly instead of waiting on a push.
  try {
    const res = await api.post("ready", {});
    store.applyConfig(res.data.config);
    store.applyState(res.data.state);
  } catch (e) {
    console.log(e.message);
  }
});

onUnmounted(() => {
  window.removeEventListener("message", onMessage);
});
</script>

<template>
  <ResourceStrip />
</template>

<style>
@font-face {
  font-family: rdrlino;
  src: url(assets/fonts/rdrlino-regular.ttf);
}

@font-face {
  font-family: chinarocks;
  src: url(assets/fonts/chinese-rocks.ttf);
}

#app {
  font-family: rdrlino;
  touch-action: manipulation;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #fff;
  overflow: hidden;
}

body {
  margin: 0;
  overflow: hidden;
}
</style>
