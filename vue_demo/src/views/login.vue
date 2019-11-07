<template>
  <div class>
    <p>登录界面</p><br><br><br><br>
    <Form ref="formInline" :model="formInline" :rules="ruleInline" inline>
      <FormItem prop="user">
        <Input type="text" v-model="formInline.user" placeholder="Username">
          <Icon type="ios-person-outline" slot="prepend"></Icon>
        </Input>
      </FormItem>
      <FormItem prop="password">
        <Input type="password" v-model="formInline.password" placeholder="Password">
          <Icon type="ios-lock-outline" slot="prepend"></Icon>
        </Input>
      </FormItem>
      <FormItem>
        <Button type="primary" @click="handleSubmit()">Signin</Button>
      </FormItem>
    </Form>
  </div>
</template>

<script type="text/ecmascript-6">
import axios from "axios";
export default {
  name: "login",
  data() {
    return {
      formInline: {
        user: "",
        password: ""
      },
      ruleInline: {
        user: [{ required: true, message: "请填写用户名", trigger: "blur" }],
        password: [{ required: true, message: "请填写密码", trigger: "blur" }]
      }
    };
  },
  components: {},
  methods: {
    handleSubmit() {
      this.$refs.formInline.validate(valid => {
        if (valid) {
          this.$Message.success("Success!");
          alert(this.formInline.user);
          axios
            .post("http://localhost:3000/login", {
              username: this.formInline.user,
              password: this.formInline.password
            })
            .then(response => {
              if (response.data.status === 200) {
                alert("登录成功");
                this.$store.commit("SET_TOKEN", response.data.token);
                this.$store.commit("GET_USER", response.data.user);

                this.$router.push({ name: "about" });
              } else {
                alert("用户名或密码错误");
              }
            })
            .catch(function(error) {
              console.log(error);
            });
        } else {
          this.$Message.error("Fail!");
        }
      });
    }
  }
};
</script>

<style lang="scss" scoped>
</style>
