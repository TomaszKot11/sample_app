# frozen_string_literal: true

module ApiErrorHandling
  def self.included(klass)
    klass.class_eval do
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    end
  end

  private

  def record_invalid(e)
    render json: { error:  e.message }, status: :unprocessable_entity
  end

  def record_not_found(_e)
    render json: { error: 'Record not found' }, status: :not_found
  end
end
