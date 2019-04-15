<!-- user logs in and can upload secretes -->
<login>
  <!-- HTML -->
  <button show={ !user } class="btn btn-outline-success my-2 my-sm-0" type="button" onclick={ login }>Login</button>
	<button show={ user } class="btn btn-outline-danger my-2 my-sm-0" type="button" onclick={ logout }>Logout</button>
  <button show={ user } class="btn btn-outline-success my-2 my-sm-0" type="button" onclick={}>Own feed</button>



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
