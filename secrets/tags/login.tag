<!-- user logs in and can upload secretes -->
<login>
  <!-- HTML -->
  <button show={ !user } class="btn btn-outline-success my-2 my-sm-0" type="button" onclick={ login }>Login</button>
	<button show={ user } class="btn btn-outline-danger my-2 my-sm-0" type="button" onclick={ logout }>Logout</button>
  <button show={ user } class="btn btn-outline-success my-2 my-sm-0" type="button" onclick={ ownFeeds }>Own feeds</button>



  <script>
    // JAVASCRIPT
    login() {
			var provider = new firebase.auth.GoogleAuthProvider();
			firebase.auth().signInWithPopup(provider);
		}
		logout() {
			firebase.auth().signOut();
		}

		this.on('update', () => {
			this.user = opts.user;
			this.room = opts.room;
		});

    this.userPosts = [];

  ownFeeds(){
    let database = firebase.firestore();
    //referece to collections
    let secretsRef = database.collection('secrets');
    let usersRef = database.collection('users');
    let userKey = firebase.auth().currentUser.uid;

    this.userPosts = [];
    let postsRef = database.doc('users/' + userKey).collection('secrets');

    postsRef.onSnapshot(snapshot => {
      let posts = [];
      snapshot.forEach(doc => {
        posts.push(doc.data().url);
      });
      this.userPosts = posts;
      
      this.update();

      observable.trigger('data', this.userPosts);

    });
  };

  // observable.trigger('data', this.userPosts);


  </script>

  <style>
    /* CSS */
    :scope {}
    .special {
      background-color: #333333;
      color: #FFFFFF;
    }
  </style>
</login>
