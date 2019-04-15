<!-- log in option to upload and see feed -->
<app>
  <!-- HTML -->
  <div class="container">
    <div class="row">
      <div class="col-10">
        <h1>
          Secrets
        </h1>
        <p>
          Secrets is a community platform that allows you to share life-changing events that might be defining your life annoymously. Hopefully, through sharing your troubles, the process of healing can start.
        </p>
      </div>
      <div class="col-2">
        <login></login>

      </div>
    </div>
    <upload1></upload1>
  </div>

  <!-- <div class="container" style="margin-top:50px;">
    <div class="row">
      <div class="">
        <img class="rounded mx-auto d-block" style="width:60%; height:100%;" src="https://images.unsplash.com/photo-1553531580-a0868f1263f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80" alt="trial">
      </div>
    </div>


  </div> -->



  <script>
    // JAVASCRIPT
    firebase.auth().onAuthStateChanged(userObj => {
      if (userObj) {
        this.user = userObj;
      } else {
        this.user = null;
        this.room = null;
      }
      this.update();
    });


  </script>

  <style>
    /* CSS */
    :scope {}
    .special {
      background-color: #333333;
      color: #FFFFFF;
    }
  </style>
</app>
