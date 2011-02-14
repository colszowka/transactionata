# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails2_session',
  :secret      => 'bea65fe1561ce0ac1ec7e3524c6b5b9707e3bc6c32d803a7aa2da6cb7463c8f29e30f4517e827666c08277fa2183166bbc18f076a356d4b73d22b0c5dd68de8b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
