# coding: utf-8
class EncryptUtils
  require 'openssl'
  require 'base64'
  
  ALG = 'DES-EDE3-CBC'
  
  class << self
    def encode(key, des_key, str)
      des = OpenSSL::Cipher::Cipher.new ALG
      des.pkcs5_keyivgen key, des_key
      des.encrypt
      cipher = des.update str
      cipher << des.final
      Base64.urlsafe_encode64 cipher
    end
    
    def decode(key, des_key, str)
      str = Base64.urlsafe_decode64 str
      des = OpenSSL::Cipher::Cipher.new ALG
      des.pkcs5_keyivgen key, des_key
      des.decrypt
      des.update(str) + des.final
    end
  end
  
end