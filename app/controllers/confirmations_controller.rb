# frozen_string_literal: true

# controller for overriding devise confirmation controller
class ConfirmationsController < Devise::ConfirmationsController
  def show
    set_resource
  end

  def confirm
    update_resource

    if resource_saves
      @resource.confirm
      set_flash_message :notice, :confirmed
      sign_in_and_redirect resource_name, @resource
    else
      render :show
    end
  end

  private

  def permitted_params
    params.require(resource_name)
          .permit(:confirmation_token, :password, :password_confirmation)
  end

  def set_resource
    @original_token = params[:confirmation_token]
    @resource = resource_class.find_by(confirmation_token: @original_token)
  end

  def update_resource
    @original_token = permitted_params[:confirmation_token]
    @resource = resource_class.find_by(confirmation_token: @original_token)
    @resource.assign_attributes(
      password: permitted_params[:password],
      password_confirmation: permitted_params[:password_confirmation],
      confirmation_token: ''
    )
  end

  def resource_saves
    @resource.valid? && @resource.password_match? && @resource.save
  end
end
