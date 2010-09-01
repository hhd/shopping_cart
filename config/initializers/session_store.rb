# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hhd_template_session',
  :secret      => '3f6b785f2a06a94c5fe1b7e7cedd9e0337004de3f45849fbf1b9095b2bf5599719e5e2189575cfcd8ef84335cc13c64d7a525b3e97c62aeb6d8545d674af8117'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
