class ApiController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_default_format

  class MissingParameter < StandardError
  end

  class RecordNotFound < StandardError
  end

  class OutOfStock < StandardError
  end

  class RequiredParameters < StandardError
  end

  rescue_from MissingParameter do |exception|
    render json: {status: 400, message: 'Parameter is missing' }
  end

  rescue_from RecordNotFound do |exception|
    render json: {status: 400, message: 'variant is invalid' }
  end

  rescue_from OutOfStock do |exception|
    render json: { status: 422, message: 'Not enough stock for one of the variants' }
  end

  rescue_from RequiredParameters do |exception|
    render json: { status: 400, message: 'Required parameter is missing' }
  end

  private

  def set_default_format
    request.format = :json
  end

  def check_variant_params(param)
    if param[:variant_id].blank? || param[:variant_quantity].blank?
      raise MissingParameter
    else
      false
    end
  end

  def variant_record_exists?(param)
    if param.present?
      @variant_record = Variant.find(param)
    else
      raise RecordNotFound
    end
  end

  def check_required_params(params)
    if params[:customer_id].present? && params[:variant_ids].present?
      true
    else
      raise RequiredParameters
    end
  end
end