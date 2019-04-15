<upload1>
  <div show={ user } class="upload col-10">
    <form class="form">
      <div class="form-group">
        <label for="url-upload">URL of your SECRET</label>
        <input type="url" name="image" value="" class="form-control col-6" placeholder="URL of the image" refs="secret" onchange={ inputURL }>
        <small class="form-text text-muted">We'll never share your secret with anyone else.</small>
      </div>

      <button type="button" name="button" class="btn btn-primary" onclick={ postSecret }>Submit</button>
    </form>
  </div>

  <!-- <button type="button" name="button" class="btn btn-primary">My Secrets</button> -->
  <div show={ user } class="container" style="margin-top:50px;">
    <feed each={ item, i in secrets }></feed>
  </div>

  <script>
  //set up database
    let database = firebase.firestore();
    //referece to collections
    let secretsRef = database.collection('secrets');
    let usersRef = database.collection('users');

    // this.secretsURL = [];
    this.secretURL = "";
    //array for all secrets urls
    this.secrets = [];
    //update secret img url
    inputURL(e) {
      this.secretURL = e.currentTarget.value;
    }

    //post secrets and write data to db
    postSecret(e) {
      //push url to secrets array
      this.secrets.push(this.secretURL);

      //write data to secrets collection
      let secretKey = secretsRef.doc().id;
      database.doc('secrets/' + secretKey).set({
        url: this.secretURL,
        timestamp: firebase.firestore.FieldValue.serverTimestamp(),
        id: secretKey,
      });

      //write data to users collection
      let userKey = firebase.auth().currentUser.uid;
      database.doc('users/' + firebase.auth().currentUser.uid).set({
        id: userKey,
      });

      //write secrets to user collection
      database.doc('users/' + userKey).collection('secrets').doc(secretKey).set({
        url: this.secretURL,
        timestamp:firebase.firestore.FieldValue.serverTimestamp(),
        id:secretKey,
      })


    }





  </script>

  <style media="screen">
    .upload {
      border: solid;
      border-color: gray;
      border-width: 1px;
      border-radius: 10px;
    }
    .form {
      padding: 5px;
    }
  </style>
</upload1>
