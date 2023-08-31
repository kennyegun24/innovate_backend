class ApplicationController < ActionController::API
        before_action :authenticate_request

        SECRET_KEY = Rails.application.secret_key_base. to_s
        TOKEN_EXPIRATION = 120.hours.to_i

      def encode_token(payload)
        payload[:exp] = Time.now.to_i + TOKEN_EXPIRATION
        JWT.encode(payload, SECRET_KEY)
      end

      def decode_token(token)
        decode = JWT.decode(token, SECRET_KEY).first
        HashWithIndifferentAccess.new decode
      end

      def authenticate_request
        header = request.headers['Authorization']
        token = header.split.last if header.present?
        begin
          decoded_token = decode_token(token)
          @current_user_id = decoded_token['user_id']
          if decoded_token.present? && decoded_token[:exp] < Time.now.to_i
            render json: { status: 'ERROR', message: 'Token has expired' }, status: :unauthorized
          end
        rescue JWT::DecodeError
          render json: { status: 'ERROR', message: 'Invalid token' }, status: :unauthorized
        end
      end

      def current_user
        @current_user ||= User.find(@current_user_id)
      end

      def exempted_words
        @exempted_words = [
          'hey',
          'of',
          'a',
          'as',
          '|',
          'started',
          'and',
          'see',
          'already',
          'for',
          'made',
          'making',
          'I',
          'going',
          'leave',
          'discuss',
          'dozens',
          'ago',
          'ego',
          'gap',
          'who',
          'enjoys',
          'am',
          'full',
          'fully',
          'began',
          'that',
          'friend',
          'more',
          'that',
          'this',
          'they',
          'them',
          'people',
          'assist',
          'people',
          'individual',
          'get',
          'like',
          'what',
          'feel',
          'it',
          'nothing',
          'fill',
          'with',
          'few'
        ]
        return @exempted_words
      end

end
