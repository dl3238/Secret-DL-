<upload>
  <div show={ user } class="upload col-10">
    <form class="form">
      <div class="form-group">
        <label for="url-upload">URL of your SECRET</label>
        <input type="url" name="image" class="form-control col-6" placeholder="URL of the image" refs="secret" onchange={ inputURL }>

      </div>
      <!-- <img src="{ secretURL }" if={ secretURL } alt=""> -->
      <button type="button" name="button" class="btn btn-primary" onclick={ postSecret }>Submit</button>
    </form>
  </div>

  <button type="button" name="button" class="btn btn-primary" onclick={ mySecrets }>My Secrets</button>
  <div show={ user } class="container" style="margin-top:50px;">
    <div class="row" each={ item, i in secrets }>
      <div class="">
        <!-- <img class="rounded mx-auto d-block" style="width:60%; height:100%;" src="https://images.unsplash.com/photo-1553531580-a0868f1263f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80" alt="trial"> -->
        <img class="rounded mx-auto d-block" style="width:70%; height:100%;" src={ item }  if = { inputURL } alt="">

      </div>
    </div>
  </div>



  <script>
   // JAVASCRIPT

   //set up database
   let database = firebase.firestore();
   //set up secret image url
   this.secretURL = "";
   this.secrets = [];
   // updating secret image url
   inputURL(e){
     this.secretURL = e.currentTarget.value;
   };
   // make reference to all secrets collection
   let secretsRef = database.collection('secrets');
   //make reference to user
   // let auth = firebase.auth();
   let user = database.collection('user')

   //array for users secrets
   this.userSecrets = [];

   postSecret(e){
     this.secrets.push(this.secretURL);
     // creates a new secret
//debugger
     let secretKey = secretsRef.doc().id;
//debugger
     // let secrets = database.doc('secrets/' + secretKey).set({
     //   url: this.secretURL,
     //   timestamp: firebase.firestore.FieldValue.serverTimestamp(),
     //   id: secretKey,
     // });
     database.doc('secrets/' + secretKey).set({
       url: this.secretURL,
       timestamp: firebase.firestore.FieldValue.serverTimestamp(),
       id: secretKey,
     });
//debugger
     // this.userSecrets.push(secret);
     // this.update();

     //creates user document
     let userKey = user.doc().id;
//debugger
     let userRef = database.doc('user/' + firebase.auth().currentUser.uid).collection('secrets').doc(secretKey);

     userRef.set({
       url: this.secretURL,
       timestamp: firebase.firestore.FieldValue.serverTimestamp(),
       id: secretKey,
     });
    //adds secrets to user
//      let userSecretsRef = user.doc(userKey).collection('secrets');
// //debugger
//      userSecretsRef.doc(secretKey).collection('secrets').doc(secretKey).set({
//        url: this.secretURL,
//        timestamp: firebase.firestore.FieldValue.serverTimestamp(),
//        id: secretKey
//      });

   };

   mySecrets() {
     database.collection(user.currentUser.uid).orderBy('timestamp','asc')
     .startAfter(this.lastTimestamp).limit(3).get().then(snapshot => {
       this.items = [];
       snapshot.forEach(doc => {
         this.items.push(doc.data());
       });

       this.lastTimestamp = this.items[this.items.length - 1].timestamp;
       this.update();
     });
   }

   // this.on('update', () => {
   // 	this.user = opts.user;
   // 	this.room = opts.room;
   // });
 </script>




  <style media="screen">
    .upload{
      border:solid;
      border-color: gray;
      border-width: 1px;
      border-radius: 10px;
    }
    .form{
      padding:5px;
    }
  </style>

</upload>
