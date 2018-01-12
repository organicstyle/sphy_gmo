require 'digest/sha2'

def generate_id
  Time.now.to_i
end

def generate_token
  Digest::SHA256.new.update(rand(10).to_s).to_s
end
