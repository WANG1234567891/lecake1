<template>
  <div>
    <!-- 引入jq的测试 -->
    <h1 id="h" @click="getData">{{ da }}</h1>
    <p>{{ add }}</p>

    <div class="container">
      <ul
        class="list-unstyled d-flex justify-content-around text-center text-muted font_small bg-light py-4 mb-0"
      >
        <li>
          <img src="img/footer/icon1.png" alt="" />
          <p>品质保障</p>
        </li>
        <li>
          <img src="img/footer/icon2.png" alt="" />
          <p>私人订制</p>
        </li>
        <li>
          <img src="img/footer/icon3.png" alt="" />
          <p>学员特供</p>
        </li>
        <li>
          <img src="img/footer/icon4.png" alt="" />
          <p>专属特权</p>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      da: "tests",
      add: "",
    };
  },
  methods: {
    getData() {
      // let content=document.getElementById("h").innerHTML;
      // this.add=content
      $("#h").css("backgroundColor", "red");
    },
  },
};
</script>

<style scope>
</style>