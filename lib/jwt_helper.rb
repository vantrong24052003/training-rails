  # lib/jwt_helper.rb
  module JwtHelper
    extend self

    # Thuật toán custom cho HS512
    module CustomHS512Algorithm
      extend JWT::JWA::SigningAlgorithm

      def self.alg
        'HS512'
      end

      def self.sign(data:, signing_key:)
        OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha512'), signing_key, data)
      end

      def self.verify(data:, signature:, verification_key:)
        ::OpenSSL.secure_compare(sign(data: data, signing_key: verification_key), signature)
      end
    end

    # Ký token
    def sign_token(payload, key, alg = CustomHS512Algorithm, header_fields = {})
    payload[:exp] ||= 1.hour.from_now.to_i
      JWT.encode(payload, key, alg, header_fields)
    end

    # Giải mã token
    def decode_token(token, key, alg = CustomHS512Algorithm)
      JWT.decode(token, key, true, algorithm: alg)
    end

    # Xác minh token nâng cao (EncodedToken)
    def verify_encoded_token(token, key, alg = 'HS512')
      encoded = JWT::EncodedToken.new(token)

      encoded.verify!(signature: { algorithm: alg, key: key })
      encoded.verify_claims!(:exp, :sub) # thêm :jti, :aud nếu cần

      {
        payload: encoded.payload,
        header: encoded.header
      }
    rescue JWT::DecodeError => e
      { error: e.message }
    end
  end
