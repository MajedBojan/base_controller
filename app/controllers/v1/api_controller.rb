# frozen_string_literal: true

class V1::ApiController < ApplicationController
  include JsonResponders
  include ExceptionHandler
  include MissingData
  before_action :authenticate!
  before_action :set_locale
  require_power_check

  self.responder = ApplicationResponder

  private

  def authenticate_user!
    return if missing_headers!('Authorization')

    @current_user = Authentication.get(request.headers['Authorization'].split(' ').last)
  end

  def set_locale
    I18n.locale = params[:locale] || request.headers['locale'] || I18n.default_locale
  end
end
